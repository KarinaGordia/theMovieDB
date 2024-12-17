import 'package:json_annotation/json_annotation.dart';

part 'movie_credits_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieCreditsResponse {
  final List<CastMember> cast;
  final List<CrewMember> crew;

  MovieCreditsResponse(
      {required this.cast, required this.crew});

  factory MovieCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CrewMember {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;

  CrewMember(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.creditId,
      required this.department,
      required this.job});

  factory CrewMember.fromJson(Map<String, dynamic> json) =>
      _$CrewMemberFromJson(json);

  Map<String, dynamic> toJson() => _$CrewMemberToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CastMember {
  final bool adult;
  final int? gender;
  final int id;

  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  CastMember(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.castId,
      required this.character,
      required this.creditId,
      required this.order});

  factory CastMember.fromJson(Map<String, dynamic> json) =>
      _$CastMemberFromJson(json);

  Map<String, dynamic> toJson() => _$CastMemberToJson(this);
}
