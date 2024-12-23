import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/domain.dart';

class MovieService {
  final _apiClient = MovieApiClient();

  Future<MovieListResponse> getPopularMovieList(
          int page, String locale) async =>
      await _apiClient.getPopularMovieList(page, locale, Configuration.apiKey);

  Future<MovieListResponse> getSearchedMovieList(
          int page, String locale, String query) async =>
      await _apiClient.getSearchedMovieList(
          page, locale, query, Configuration.apiKey);
}
