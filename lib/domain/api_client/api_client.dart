import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/domain.dart';

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class ApiClient {
  final _networkClient = NetworkClient();

  Future<String> auth({
    required String userName,
    required String password,
  }) async {
    final token = await _makeToken();
    final validatedToken = await _validateUser(
        userName: userName, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validatedToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.get('/authentication/token/new', parser,
        <String, dynamic>{'api_key': Configuration.apiKey});
    return result;
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'username': userName,
      'password': password,
      'request_token': requestToken
    };
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{'request_token': requestToken};
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final result = _networkClient.post(
      '/authentication/session/new',
      parameters,
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
    );
    return result;
  }

  Future<int> getAccountId(String sessionId) async {
    int parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['id'] as int;
      return response;
    }

    final result = _networkClient.get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );

    return result;
  }

  Future<MovieListResponse> getPopularMovieList(int page, String locale) async {
    MovieListResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieListResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'language': locale,
        'page': page.toString(),
      },
    );
    return result;
  }

  Future<MovieListResponse> getSearchedMovieList(
      int page, String locale, String query) async {
    MovieListResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieListResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'query': query,
        'language': locale,
        'page': page.toString(),
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  Future<MovieDetailsResponse> getMovieDetails(
      int movieId, String locale) async {
    MovieDetailsResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'append_to_response': 'credits,release_dates,videos',
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<bool> isFavorite(int movieId, String sessionId) async {
    bool parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;
      return result;
    }

    final result = _networkClient.get(
      '/movie/$movieId/account_states',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<void> markAsFavorite(int accountId, String sessionId,
      MediaType mediaType, int mediaId, bool isFavorite) async {
    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };

    bool parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['success'] as bool;
      return result;
    }

    await _networkClient.post(
      '/account/$accountId/favorite',
      parameters,
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
  }

}

