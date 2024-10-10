import 'package:flutter/material.dart';
import 'package:the_movie_db/resources/app_images.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_widget.dart';

class TVShow extends Movie {
  TVShow(
      {required super.id,
      required super.imageName,
      required super.title,
      required super.time,
      required super.description});
}

class TWShowListWidget extends StatefulWidget {
  const TWShowListWidget({super.key});

  @override
  State<TWShowListWidget> createState() => _TWShowListWidgetState();
}

class _TWShowListWidgetState extends State<TWShowListWidget> {
  final _movies = <TVShow>[
    TVShow(
      id: 1,
      imageName: AppImages.godzilla,
      title: 'Flash',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 2,
      imageName: AppImages.godzilla,
      title: 'Чудеса науки',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 3,
      imageName: AppImages.godzilla,
      title: 'Скользящие',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 4,
      imageName: AppImages.godzilla,
      title: 'Академия амбрелла',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 5,
      imageName: AppImages.godzilla,
      title: 'Ходячие мертвицы',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 6,
      imageName: AppImages.godzilla,
      title: 'Пищеблок',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 7,
      imageName: AppImages.godzilla,
      title: 'Вампиры средней полосы',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 8,
      imageName: AppImages.godzilla,
      title: 'Теория большого взрыва',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 9,
      imageName: AppImages.godzilla,
      title: 'Дество шелдона',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 10,
      imageName: AppImages.godzilla,
      title: 'Как я встретил вашу маму',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 11,
      imageName: AppImages.godzilla,
      title: 'Гравити фолз',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 12,
      imageName: AppImages.godzilla,
      title: 'Утинные истории',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 13,
      imageName: AppImages.godzilla,
      title: 'Джентельмены',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 14,
      imageName: AppImages.godzilla,
      title: 'Наследие юпитера',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 15,
      imageName: AppImages.godzilla,
      title: 'Друзья',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    TVShow(
      id: 16,
      imageName: AppImages.godzilla,
      title: 'Квантовый скачек',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
  ];

  var _filteredMovies = <TVShow>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((TVShow movie) {
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
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationNames.movieDetails,
      arguments: id,
    );
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
