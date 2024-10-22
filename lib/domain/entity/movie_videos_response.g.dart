// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_videos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideosResponse _$MovieVideosResponseFromJson(Map<String, dynamic> json) =>
    MovieVideosResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => VideoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieVideosResponseToJson(
        MovieVideosResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) => VideoInfo(
      language: json['iso_639_1'] as String,
      countryCode: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: (json['size'] as num).toInt(),
      type: json['type'] as String,
      official: json['official'] as bool,
      publicationDate:
          parseMovieDateFromString(json['published_at'] as String?),
      id: json['id'] as String,
    );

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'iso_639_1': instance.language,
      'iso_3166_1': instance.countryCode,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'published_at': instance.publicationDate?.toIso8601String(),
      'id': instance.id,
    };
