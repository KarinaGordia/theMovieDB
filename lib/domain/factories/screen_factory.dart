import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/ui.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderWidgetViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthorizationViewModel(),
      child: const AuthorizationPage(),
    );
  }

  Widget makeMain() {
    return Provider(
      create: (_) => MainPageViewModel(),
      child: const MainPage(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(
        primaryColor: Color.fromRGBO(10, 31, 52, 1),
      ),
    );
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }

  Widget makeNews() {
    return const NewsWidget();
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }
}
