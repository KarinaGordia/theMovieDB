import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/movie.dart';

part 'popular_movie_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieListResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  PopularMovieListResponse(
      {required this.page,
      required this.movies,
      required this.totalPages,
      required this.totalResults});

  factory PopularMovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieListResponseToJson(this);
}
