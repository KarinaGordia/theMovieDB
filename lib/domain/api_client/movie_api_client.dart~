import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/domain.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

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



}

