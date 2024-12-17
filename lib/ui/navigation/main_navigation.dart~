import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/factories/screen_factory.dart';

class MainNavigationNames {
  static const loaderWidget = '/';
  static const auth = '/authorization_page';
  static const mainPage = '/main_page';
  static const movieDetails = '/main_page/movie_details';
  static const movieTrailerWidget = '/main_page/movie_details/trailer';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationNames.mainPage: (_) => _screenFactory.makeMain(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeMovieDetails(movieId));
      case MainNavigationNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final key = arguments is String ? arguments : '';
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeMovieTrailer(key));
      default:
        const widget = Scaffold(
          body: Center(
            child: Text('Navigation error'),
          ),
        );
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
