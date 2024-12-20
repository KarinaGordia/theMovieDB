import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _authService = AuthorizationService();
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final int movieId;
  MovieDetailsResponse? _movieDetails;
  bool _isFavorite = false;
  CountryReleaseInfo? _localeReleaseInfo;
  String _locale = '';
  String _countryCode = '';
  late DateFormat _dateFormat;


  MovieDetailsResponse? get movieDetails => _movieDetails;

  CountryReleaseInfo? get movieReleaseInfo => _localeReleaseInfo;

  bool get isFavorite => _isFavorite;
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

  MovieDetailsModel(this.movieId);

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final countryCode = Localizations.localeOf(context).countryCode;
    if (_locale == locale && _countryCode == countryCode) return;
    _locale = locale;
    _countryCode = countryCode ?? '';
    _dateFormat = DateFormat.yMd(locale);
    await loadMovieDetails(context);
    getLocaleMovieReleaseInfo();
  }

  Future<void> loadMovieDetails(BuildContext context) async {
    try {
      _movieDetails = await _apiClient.getMovieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
      }

      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  Future<void> addToFavorite(BuildContext context) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();

    try {
      await _accountApiClient.markAsFavorite(
          accountId, sessionId, MediaType.movie, movieId, _isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void getLocaleMovieReleaseInfo() {
    final releaseInfo = _movieDetails?.releaseInfo;
    if (releaseInfo != null) {
      final results = releaseInfo.results;
      for (var result in results) {
        if (result.iso == _countryCode) {
          _localeReleaseInfo = result;
          break;
        }
      }
      notifyListeners();
    }
  }

  Map<String, List<String>> getMainCrewMembers() {
    final crew = _movieDetails?.credits.crew;
    final members = <String, List<String>>{};

    if (crew != null) {
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
    }

    return members;
  }

  void _handleApiClientException(ApiClientException exception, BuildContext context,) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logOut();
        MainNavigation.resetNavigation(context);
      default:
        log('$exception');
    }
  }
}
