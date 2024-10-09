// import 'dart:convert';
// import 'dart:io';
//
// class ApiClient {
//   final _client = HttpClient();
//
//   static const _host = 'https://api.themoviedb.org/3';
//   static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
//   static const _apiKey = '0170708c03fdae05fbf2c02b9f0119ea';
//
//   Future<List<Post>> getPosts() async {
//     final json = await get('https://jsonplaceholder.typicode.com/posts')
//     as List<dynamic>;
//
//     final posts = json
//         .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
//         .toList();
//     return posts;
//   }
//
//   Future<dynamic> get(String urlString) async {
//     //default Uri constructor
//     //final url = Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
//     final url = Uri.parse(urlString);
//     final request = await _client.getUrl(url);
//     final response = await request.close();
//
//     final jsonStrings = await response.transform(utf8.decoder).toList();
//     final jsonString = jsonStrings.join();
//     final dynamic json = jsonDecode(jsonString);
//     return json;
//   }
//
//   Future<Post> createPost({required String title, required String body}) async {
//     final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//     final parameters = <String, dynamic>{
//       'title': title,
//       'body': body,
//       'userId': 109
//     };
//
//     final request = await _client.postUrl(url);
//     request.headers.set('Content-type', 'application/json; charset=UTF-8');
//     request.write(jsonEncode(parameters));
//     final response = await request.close();
//     final jsonStrings = await response.transform(utf8.decoder).toList();
//     final jsonString = jsonStrings.join();
//     final json = jsonDecode(jsonString) as Map<String, dynamic>;
//     return Post.fromJson(json);
//   }
// }