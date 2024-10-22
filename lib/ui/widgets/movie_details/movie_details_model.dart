import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entity/movie_certification_response.dart';
import 'package:the_movie_db/domain/entity/movie_credits_response.dart';
import 'package:the_movie_db/domain/entity/movie_details_response.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetailsResponse? _movieDetails;
  CountryReleaseInfo? _localeReleaseInfo;
  String _locale = '';
  String _countryCode = '';
  late DateFormat _dateFormat;

  MovieDetailsResponse? get movieDetails => _movieDetails;

  CountryReleaseInfo? get movieReleaseInfo => _localeReleaseInfo;
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
    _movieDetails = await _apiClient.getMovieDetails(movieId, _locale);
    notifyListeners();
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

    if(crew != null) {
      for(var job in mainCrewJobs) {
        for(var member in crew) {
          if(member.job == job) {
            final name = member.name;
            if(!members.containsKey(name)) {
              members[name] = <String>[];
            }
            members[name]?.add(member.job);
          }
        }
      }
    }

    return members;
  }
}
