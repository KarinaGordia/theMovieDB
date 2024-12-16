import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/library/widgets/inherited/provider.dart' as old_provider;
import 'package:the_movie_db/ui/widgets/widgets.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderWidgetViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return old_provider.NotifierProvider(
      create: () => AuthorizationPageModel(),
      child: const AuthorizationPage(),
    );
  }

  Widget makeMain() {
    return old_provider.NotifierProvider(
      create: () => MainPageModel(),
      child: const MainPage(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return old_provider.NotifierProvider(
      create: () => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(
        primaryColor: Color.fromRGBO(10, 31, 52, 1),
      ),
    );
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }
}