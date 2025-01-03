import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_model.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListViewModel>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _MovieListViewWidget(),
        _SearchFieldWidget(),
      ],
    );
  }
}

class _MovieListViewWidget extends StatelessWidget {
  const _MovieListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return ListView.builder(
      padding: const EdgeInsets.only(top: 70),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: model.movies.length,
      itemExtent: 141,
      itemBuilder: (BuildContext context, int index) {
        model.getCurrentMovieByIndex(index);
        return _MovieCard(movieIndex: index);
      },
    );
  }
}

class _SearchFieldWidget extends StatelessWidget {
  const _SearchFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search',
        filled: true,
        fillColor: Colors.white.withAlpha(235),
        border: const OutlineInputBorder(),
      ),
      onChanged: model.searchMovie,
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    super.key,
    required this.movieIndex,
  });

  final int movieIndex;

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    final movie = model.movies[movieIndex];
    final imagePath = movie.posterPath;

    return Stack(
      children: [
        Card(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              if (imagePath != null)
                Image.network(
                  ImageDownloader.imageUrl(imagePath),
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
                        movie.releaseDate,
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
            onTap: () => model.onMovieTap(context, movieIndex),
          ),
        ),
      ],
    );
  }
}
