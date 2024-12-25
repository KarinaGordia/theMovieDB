// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_credits_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCreditsResponse _$MovieCreditsResponseFromJson(
        Map<String, dynamic> json) =>
    MovieCreditsResponse(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CastMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => CrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieCreditsResponseToJson(
        MovieCreditsResponse instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

CrewMember _$CrewMemberFromJson(Map<String, dynamic> json) => CrewMember(
      adult: json['adult'] as bool,
      gender: (json['gender'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      department: json['department'] as String,
      job: json['job'] as String,
    );

Map<String, dynamic> _$CrewMemberToJson(CrewMember instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
    };

CastMember _$CastMemberFromJson(Map<String, dynamic> json) => CastMember(
      adult: json['adult'] as bool,
      gender: (json['gender'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      castId: (json['cast_id'] as num).toInt(),
      character: json['character'] as String,
      creditId: json['credit_id'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$CastMemberToJson(CastMember instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };
