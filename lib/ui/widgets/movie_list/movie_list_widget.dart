import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entity/movie.dart';
import 'package:the_movie_db/library/widgets/inherited/provider.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_model.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.movies.length,
          itemExtent: 141,
          itemBuilder: (BuildContext context, int index) {
            model.getCurrentMovieByIndex(index);
            final movie = model.movies[index];
            return CardMovie(
              movie: movie,
              onTap: () => model.onMovieTap(context, index),
            );
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            filled: true,
            fillColor: Colors.white.withAlpha(235),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class CardMovie extends StatelessWidget {
  const CardMovie({
    super.key,
    this.onTap,
    required this.movie,
  });

  final Movie movie;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieListModel>(context);
    final imagePath = movie.posterPath;
    final releaseDate = movie.releaseDate;

    return Stack(
      children: [
        Card(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              if (imagePath != null)
                Image.network(
                  ApiClient.imageUrl(imagePath),
                  width: 90,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        model!.stringFromDate(releaseDate),
                        style: const TextStyle(
                          fontSize: 14.4,
                          color: Color.fromRGBO(153, 153, 153, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        style: const TextStyle(
                          fontSize: 14.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        movie.overview,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
