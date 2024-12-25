import 'package:the_movie_db/domain/domain.dart';

class LocalMovieDetails {
  final MovieDetailsResponse details;
  final bool isFavorite;

  LocalMovieDetails({required this.details, required this.isFavorite});
}