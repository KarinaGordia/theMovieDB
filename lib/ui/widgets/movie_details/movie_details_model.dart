import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entity/movie_details_response.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetailsResponse? _movieDetails;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetailsResponse? get movieDetails => _movieDetails;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadMovieDetails();
  }

  Future<void> loadMovieDetails() async {
    _movieDetails = await _apiClient.getMovieDetails(movieId, _locale);
    notifyListeners();
  }
}
