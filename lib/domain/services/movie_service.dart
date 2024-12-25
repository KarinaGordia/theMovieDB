import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/domain.dart';

class MovieService {
  final _apiClient = MovieApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();

  Future<MovieListResponse> getPopularMovieList(
          int page, String locale) async =>
      await _apiClient.getPopularMovieList(page, locale, Configuration.apiKey);

  Future<MovieListResponse> getSearchedMovieList(
          int page, String locale, String query) async =>
      await _apiClient.getSearchedMovieList(
          page, locale, query, Configuration.apiKey);

  Future<LocalMovieDetails> loadMovieDetails(
      {required int movieId, required String locale}) async {
    final movieDetails = await _apiClient.getMovieDetails(movieId, locale);
    final sessionId = await _sessionDataProvider.getSessionId();
    var isFavorite = false;
    if (sessionId != null) {
      isFavorite = await _apiClient.isFavorite(movieId, sessionId);
    }

    return LocalMovieDetails(details: movieDetails, isFavorite: isFavorite);
  }

  Future<void> updateFavorite({
    required int movieId,
    required bool isFavorite,
  }) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) return;

    await _accountApiClient.markAsFavorite(accountId, sessionId,
        MediaType.movie, movieId, isFavorite);
  }
}
