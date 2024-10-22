import 'package:json_annotation/json_annotation.dart';

import 'movie_date_parser.dart';

part 'movie_videos_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieVideosResponse {
  final List<VideoInfo> results;

  MovieVideosResponse({required this.results});

  factory MovieVideosResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieVideosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideosResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VideoInfo {
  @JsonKey(name: 'iso_639_1')
  final String language;
  @JsonKey(name: 'iso_3166_1')
  final String countryCode;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  @JsonKey(name: 'published_at', fromJson: parseMovieDateFromString)
  final DateTime? publicationDate;
  final String id;

  VideoInfo(
      {required this.language,
      required this.countryCode,
      required this.name,
      required this.key,
      required this.site,
      required this.size,
      required this.type,
      required this.official,
      required this.publicationDate,
      required this.id});

  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}
