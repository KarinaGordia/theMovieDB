import 'dart:convert';
import 'dart:io';

import 'package:the_movie_db/domain/entity/movie_details_response.dart';
import 'package:the_movie_db/domain/entity/movie_list_response.dart';

//karinagordya
//login_FoR_flutter

enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '0170708c03fdae05fbf2c02b9f0119ea';

  static String imageUrl(String path) => _imageUrl + path;

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

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');

    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> _makeToken() async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get('/authentication/token/new', parser,
        <String, dynamic>{'api_key': _apiKey});
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

    final result = _post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
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

    final result = _post(
      '/authentication/session/new',
      parameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<MovieListResponse> getPopularMovieList(int page, String locale) async {
    MovieListResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieListResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language' : locale,
        'page' : page.toString(),
      },
    );
    return result;
  }

  Future<MovieListResponse> getSearchedMovieList(int page, String locale, String query) async {
    MovieListResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieListResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'query' : query,
        'language' : locale,
        'page' : page.toString(),
        'include_adult' : true.toString(),
      },
    );
    return result;
  }

  Future<MovieDetailsResponse> getMovieDetails(int movieId, String locale) async {
    MovieDetailsResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'append_to_response' : 'credits,release_dates,videos',
        'api_key': _apiKey,
        'language' : locale,
      },
    );
    return result;
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(
      path,
      parameters,
    );
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
      String path,
      Map<String, dynamic> bodyParameters,
      T Function(dynamic json) parser, [
        Map<String, dynamic>? urlParameters,
      ]) async {
    try {
      final url = _makeUri(
        path,
        urlParameters,
      );
      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponse(
      HttpClientResponse response, Map<String, dynamic> json) {
    if (response.statusCode == 401) {
      final status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
