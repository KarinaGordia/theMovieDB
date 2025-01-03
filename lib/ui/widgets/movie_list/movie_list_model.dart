import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/library/library.dart';
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
  final _service = MovieService();
  late final Paginator<Movie> _popularMoviesPaginator;
  late final Paginator<Movie> _searchedMoviesPaginator;
  final _movies = <MovieCardData>[];
  String? _searchQuery;
  final _localeStorage = LocaleStorageModel();
  late DateFormat _dateFormat;
  Timer? searchDebounce;

  List<MovieCardData> get movies => List.unmodifiable(_movies);

  bool get isSearchMode {
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  MovieListViewModel() {
    _popularMoviesPaginator = Paginator<Movie>((page) async {
      final result = await _service.getPopularMovieList(page,_localeStorage.localeTag);
      return PaginatorLoadResult(
        data: result.movies,
        currentPage: result.page,
        totalPage: result.totalPages,
      );
    });
    _searchedMoviesPaginator = Paginator<Movie>((page) async {
      final result = await _service.getSearchedMovieList(
        page,
        _localeStorage.localeTag,
        _searchQuery ?? '',
      );
      return PaginatorLoadResult(
        data: result.movies,
        currentPage: result.page,
        totalPage: result.totalPages,
      );
    });
  }

  Future<void> setupLocale(Locale locale) async {
    if (!_localeStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await _resetList();
  }

  Future<void> _resetList() async {
    await _popularMoviesPaginator.reset();
    await _searchedMoviesPaginator.reset();
    _movies.clear();
    await _loadMovieList();
  }

  Future<void> _loadMovieList() async {
    if (isSearchMode) {
      await _searchedMoviesPaginator.loadNextPage();
      _movies.addAll(_searchedMoviesPaginator.data.map(_makeCardData).toList());
    } else {
      await _popularMoviesPaginator.loadNextPage();
      _movies.addAll(_popularMoviesPaginator.data.map(_makeCardData).toList());
    }
    notifyListeners();
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
      _movies.clear();
      if(isSearchMode) {
        await _searchedMoviesPaginator.reset();
      }
      await _loadMovieList();
    });
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationNames.movieDetails, arguments: id);
  }

  void getCurrentMovieByIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadMovieList();
  }
}
