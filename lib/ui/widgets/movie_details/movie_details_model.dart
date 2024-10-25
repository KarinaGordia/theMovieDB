import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/entity/movie_certification_response.dart';
import 'package:the_movie_db/domain/entity/movie_details_response.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetailsResponse? _movieDetails;
  bool _isFavorite = false;
  CountryReleaseInfo? _localeReleaseInfo;
  String _locale = '';
  String _countryCode = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

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
    await loadMovieDetails();
    getLocaleMovieReleaseInfo();
  }

  Future<void> loadMovieDetails() async {
    try {
      _movieDetails = await _apiClient.getMovieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
      }

      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> addToFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();

    try {
      await _apiClient.markAsFavorite(
          accountId, sessionId, MediaType.movie, movieId, _isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
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

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
        break;
      default:
        print(exception);
    }
  }
}
