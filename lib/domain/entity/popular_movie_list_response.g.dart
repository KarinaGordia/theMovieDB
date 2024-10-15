// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovieListResponse _$PopularMovieListResponseFromJson(
        Map<String, dynamic> json) =>
    PopularMovieListResponse(
      page: (json['page'] as num).toInt(),
      movies: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$PopularMovieListResponseToJson(
        PopularMovieListResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
