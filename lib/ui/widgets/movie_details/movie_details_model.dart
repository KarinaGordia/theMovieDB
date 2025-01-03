import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/library/library.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieDetailsPosterData {
  final String? posterPath;
  final String? backdropPath;
  final bool isFavorite;

  IconData get favoriteIcon =>
      isFavorite ? Icons.favorite : Icons.favorite_outline_outlined;

  MovieDetailsPosterData({
    required this.posterPath,
    required this.backdropPath,
    this.isFavorite = false,
  });

  MovieDetailsPosterData copyWith({
    String? posterPath,
    String? backdropPath,
    bool? isFavorite,
  }) {
    return MovieDetailsPosterData(
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieReleaseData {
  final String? certification;
  final String? releaseDate;
  final String? countryCode;

  MovieReleaseData({
    required this.certification,
    required this.releaseDate,
    required this.countryCode,
  });
}

class MovieDetailsData {
  bool isLoading = true;
  String title = '';
  String overview = '';
  String tagline = '';
  MovieDetailsPosterData posterData = MovieDetailsPosterData(
    posterPath: null,
    backdropPath: null,
  );
  String? releaseYear;
  int voteAverage = 0;
  String? trailerKey;
  String genres = '';
  String runtime = '';
  MovieReleaseData? releaseInfo;
  Map<String, String> crew = {};
  List<CastMember> cast = [];
}

class MovieDetailsModel extends ChangeNotifier {
  final _authService = AuthorizationService();
  final _service = MovieService();

  final int movieId;
  final data = MovieDetailsData();
  final _localeStorage = LocaleStorageModel();
  late DateFormat _dateFormat;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if (!_localeStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMd(_localeStorage.localeTag);
    _updateData(null, false);
    await loadMovieDetails(context);
  }

  void _updateData(MovieDetailsResponse? details, bool isFavorite) {
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }

    final icon = isFavorite ? Icons.favorite : Icons.favorite_outline_outlined;
    var releaseYear = details.releaseDate?.year.toString();
    releaseYear = releaseYear != null ? ' ($releaseYear)' : '';
    var score = (details.voteAverage * 10).toInt();
    final videos = details.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;

    var cast = details.credits.cast;
    if (cast.length > 9) {
      cast = cast.sublist(0, 9);
    }

    data.title = details.title;
    data.overview = details.overview ?? '';
    data.tagline = details.tagline ?? '';
    data.posterData = MovieDetailsPosterData(
      posterPath: details.posterPath,
      backdropPath: details.backdropPath,
      isFavorite: isFavorite,
    );
    data.releaseYear = releaseYear;
    data.voteAverage = score;
    data.trailerKey = trailerKey;
    data.genres = _getGenresString(details.genres);
    data.runtime = _movieRuntimeInHours(details.runtime);
    data.releaseInfo = _getLocaleMovieReleaseInfo(details);
    data.crew = _getMainCrewMembers(details);
    data.cast = cast;

    notifyListeners();
  }

  String _getGenresString(List<Genre>? genres) {
    if (genres != null && genres.isNotEmpty) {
      var genreNames = <String>[];
      for (var genre in genres) {
        genreNames.add(genre.name);
      }

      return genreNames.join(', ');
    }

    return '';
  }

  String _movieRuntimeInHours(int? runtime) {
    if (runtime == null) return 'N/A';
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours == 0) return '${minutes}m';
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }

  Future<void> loadMovieDetails(BuildContext context) async {
    try {
      final movieDetails = await _service.loadMovieDetails(
        movieId: movieId,
        locale: _localeStorage.localeTag,
      );

      _updateData(movieDetails.details, movieDetails.isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  Future<void> addToFavorite(BuildContext context) async {
    data.posterData =
        data.posterData.copyWith(isFavorite: !data.posterData.isFavorite);
    notifyListeners();

    try {
      _service.updateFavorite(
        movieId: movieId,
        isFavorite: data.posterData.isFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  String _stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieReleaseData? _getLocaleMovieReleaseInfo(MovieDetailsResponse details) {
    final releaseInfo = details.releaseInfo;
    final results = releaseInfo.results;
    for (var result in results) {
      if (result.iso == _localeStorage.countryCode) {
        final releaseInfo = result.releaseDates.first;
        final releaseDate = _stringFromDate(releaseInfo.releaseDate);
        return MovieReleaseData(
          certification: releaseInfo.certification,
          releaseDate: releaseDate,
          countryCode: '(${result.iso})',
        );
      }
    }

    return null;
  }

  Map<String, String> _getMainCrewMembers(MovieDetailsResponse details) {
    final mainCrewJobs = <String>[
      'Director',
      'Screenplay',
      'Author',
      'Novel',
      'Characters',
      'Writer',
      'Story',
      'Teleplay',
    ];

    final crew = details.credits.crew;
    var members = <String, List<String>>{};

    for (var job in mainCrewJobs) {
      for (var member in crew) {
        if (member.job == job) {
          final name = member.name;
          if (!members.containsKey(name)) {
            members[name] = <String>[];
          }
          members[name]?.add(member.job);
        }
      }
    }

    return members.map((key, value) => MapEntry(key, value.join(', ')));
  }

  void _handleApiClientException(
    ApiClientException exception,
    BuildContext context,
  ) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logOut();
        MainNavigation.resetNavigation(context);
      default:
        log('$exception');
    }
  }
}
