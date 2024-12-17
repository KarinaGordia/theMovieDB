// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_certification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieReleaseInfoResponse _$MovieReleaseInfoResponseFromJson(
        Map<String, dynamic> json) =>
    MovieReleaseInfoResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => CountryReleaseInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieReleaseInfoResponseToJson(
        MovieReleaseInfoResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

CountryReleaseInfo _$CountryReleaseInfoFromJson(Map<String, dynamic> json) =>
    CountryReleaseInfo(
      iso: json['iso_3166_1'] as String,
      releaseDates: (json['release_dates'] as List<dynamic>)
          .map((e) => ReleaseDateInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryReleaseInfoToJson(CountryReleaseInfo instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso,
      'release_dates': instance.releaseDates,
    };

ReleaseDateInfo _$ReleaseDateInfoFromJson(Map<String, dynamic> json) =>
    ReleaseDateInfo(
      certification: json['certification'] as String,
      descriptors: json['descriptors'] as Object,
      iso: json['iso_639_1'] as String,
      note: json['note'] as String,
      releaseDate: parseMovieDateFromString(json['release_date'] as String?),
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$ReleaseDateInfoToJson(ReleaseDateInfo instance) =>
    <String, dynamic>{
      'certification': instance.certification,
      'descriptors': instance.descriptors,
      'iso_639_1': instance.iso,
      'note': instance.note,
      'release_date': instance.releaseDate?.toIso8601String(),
      'type': instance.type,
    };
