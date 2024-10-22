import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/movie_date_parser.dart';

part 'movie_certification_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieReleaseInfoResponse {
  final List<CountryReleaseInfo> results;

  MovieReleaseInfoResponse({required this.results});

  factory MovieReleaseInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieReleaseInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieReleaseInfoResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CountryReleaseInfo {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final List<ReleaseDateInfo> releaseDates;

  CountryReleaseInfo({required this.iso, required this.releaseDates});

  factory CountryReleaseInfo.fromJson(Map<String, dynamic> json) =>
      _$CountryReleaseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CountryReleaseInfoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReleaseDateInfo {
  final String certification;
  final Object descriptors;
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String note;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final int type;

  ReleaseDateInfo(
      {required this.certification,
      required this.descriptors,
      required this.iso,
      required this.note,
      required this.releaseDate,
      required this.type});

  factory ReleaseDateInfo.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseDateInfoToJson(this);
}
