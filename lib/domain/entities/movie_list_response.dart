import 'package:json_annotation/json_annotation.dart';
import 'entities.dart';

part 'movie_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieListResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  MovieListResponse(
      {required this.page,
      required this.movies,
      required this.totalPages,
      required this.totalResults});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}
