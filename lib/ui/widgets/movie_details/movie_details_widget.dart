import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_movie_db/resources/app_images.dart';
import 'package:the_movie_db/ui/widgets/elements/circle_progress_bar.dart';

part 'movie_details_main_info_widget.dart';

part 'movie_details_media_widget.dart';

part 'movie_details_recommendations_widget.dart';

part 'movie_details_season_widget.dart';

part 'movie_details_cast_widget.dart';

part 'movie_details_social_widget.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key, required this.movieId, required this.primaryColor});

  final int movieId;
  final Color primaryColor;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Movie DB',
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
            color: const Color.fromRGBO(1, 180, 228, 1),
          ),
        ],
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1.0),
      ),
      body: SafeArea(
        child: ColoredBox(
          color: widget.primaryColor,
          child: ListView(
            children: [
              MovieDetailsMainInfoWidget(
                primaryColor: widget.primaryColor,
              ),
              const ColoredBox(color: Colors.white, child: MovieDetailsCastWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
