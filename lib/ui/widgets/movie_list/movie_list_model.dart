import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entity/movie.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
  final _dateFormat = DateFormat.yMMMMd(); 
    
  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  Future<void> loadMovies() async {
    final moviesResponse = await _apiClient.getPopularMovieList(1, 'ru-RU');
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavigationNames.movieDetails, arguments: id);
  }
}

