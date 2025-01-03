import 'dart:convert';
import 'dart:io';

import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/domain.dart';

class NetworkClient {
  final _client = HttpClient();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${Configuration.baseUrl}$path');

    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }


  Future<T> get<T>(String path, T Function(dynamic json) parser,
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

  Future<T> post<T>(
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
      } else if(code == 3) {
        throw ApiClientException(ApiClientExceptionType.sessionExpired);
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