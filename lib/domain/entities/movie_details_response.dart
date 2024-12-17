import 'package:json_annotation/json_annotation.dart';
import 'entities.dart';

part 'movie_details_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsResponse {
  final bool adult;
  final String? backdropPath;
  final String? belongsToCollections;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  @JsonKey(name: 'release_dates')
  final MovieReleaseInfoResponse releaseInfo;
  final MovieCreditsResponse credits;
  final MovieVideosResponse videos;

  MovieDetailsResponse({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollections,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseInfo,
    required this.credits,
    required this.videos,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Collection {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  Collection(
      {required this.id,
      required this.name,
      required this.posterPath,
      required this.backdropPath});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;

  SpokenLanguage(
      {required this.englishName, required this.iso, required this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany(
      {required this.id,
      required this.logoPath,
      required this.name,
      required this.originCountry});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;

  ProductionCountry({required this.iso, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}
