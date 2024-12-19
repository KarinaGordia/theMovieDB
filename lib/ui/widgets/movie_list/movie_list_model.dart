import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieCardData {
  final int id;
  final String title;
  final String? posterPath;
  final String releaseDate;
  final String overview;

  MovieCardData({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
  });
}

class MovieListViewModel extends ChangeNotifier {
  final _apiClient = MovieApiClient();
  final _movies = <MovieCardData>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String? _searchQuery;
  String _locale = '';
  Timer? searchDebounce;

  List<MovieCardData> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();
  }

  Future<MovieListResponse> _loadMovieList(int page, String locale) async {
    final query = _searchQuery;
    if (_searchQuery == null) {
      return await _apiClient.getPopularMovieList(page, locale);
    }

    return await _apiClient.getSearchedMovieList(page, locale, query!);
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final moviesResponse = await _loadMovieList(nextPage, _locale);
      _movies.addAll(moviesResponse.movies.map(_makeCardData).toList());
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  MovieCardData _makeCardData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final releaseDateTitle =
    releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieCardData(
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.title,
      releaseDate: releaseDateTitle,
      overview: movie.overview,
    );
  }

  Future<void> searchMovie(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery?.trim();
      await _resetList();
    });
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationNames.movieDetails, arguments: id);
  }

  void getCurrentMovieByIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }
}
