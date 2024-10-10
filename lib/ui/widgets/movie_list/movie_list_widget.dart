import 'package:flutter/material.dart';
import 'package:the_movie_db/resources/resources.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie(
      {required this.id,
      required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = <Movie>[
    Movie(
      id: 1,
      imageName: AppImages.godzilla,
      title: 'Godzilla Minus One',
      time: '15 December 2023',
      description:
          'Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.',
    ),
    Movie(
      id: 2,
      imageName: AppImages.godzilla,
      title: 'Kingdom of the Planet of the Apes',
      time: '15 December 2023',
      description:
          'Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.',
    ),
    Movie(
      id: 3,
      imageName: AppImages.godzilla,
      title: 'Ghostbusters: Frozen Empire',
      time: '15 December 2023',
      description:
          'Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.',
    ),
    Movie(
      id: 4,
      imageName: AppImages.godzilla,
      title: 'Godzilla x Kong: The New Empire',
      time: '15 December 2023',
      description:
          'Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.',
    ),
    Movie(
      id: 5,
      imageName: AppImages.godzilla,
      title: 'Abigail',
      time: '15 December 2023',
      description:
          'Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.',
    ),
  ];

  var _filteredMovies = <Movie>[];
  final _searchController = TextEditingController();

  void _searchMovie() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovie);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavigationNames.movieDetails, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 141,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];
            return CardMovie(
              movie: movie,
              onTap: () => _onMovieTap(index),
            );
          },
        ),
        TextField(
          controller: _searchController,
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
    return Stack(
      children: [
        Card(
          //margin: EdgeInsets.only(top: 6),
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Image(
                image: AssetImage(movie.imageName),
                // width: 94,
                // height: 141,
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
                        movie.time,
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
                        movie.description,
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
