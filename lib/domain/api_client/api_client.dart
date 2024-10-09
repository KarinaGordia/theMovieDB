import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '0170708c03fdae05fbf2c02b9f0119ea';

  Future<String> auth({required String userName,
    required String password,}) async {
    final token = await _makeToken();
    final validatedToken = await _validateUser(userName: userName, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validatedToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse(
        '$_host/$path');

    if(parameters !=null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> _makeToken() async {
    final url = _makeUri('authentication/token/new', {'api_key' :_apiKey});
    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = response.jsonDecode() as Map<String, dynamic>;
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    final url = _makeUri('authentication/token/validate_with_login', {'api_key' :_apiKey});
    final parameters = <String, dynamic>{
      'username':userName,
      'password':password,
      'request_token':requestToken
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = response.jsonDecode() as Map<String, dynamic>;
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final url = _makeUri('authentication/session/new', {'api_key' :_apiKey});
    final parameters = <String, dynamic>{
      'request_token':requestToken
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = response.jsonDecode() as Map<String, dynamic>;
    //если не работает добавить await
    //final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  dynamic jsonDecode() {
    transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => json.decode(v));
  }
}