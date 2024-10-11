import 'package:flutter/material.dart';
import 'package:the_movie_db/library/widgets/inherited/provider.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/main_page/main_page_model.dart';
import 'package:the_movie_db/ui/widgets/widgets.dart';

class MainNavigationNames {
  static const auth = 'authorization_page';
  static const mainPage = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) {
    return isAuth ? MainNavigationNames.mainPage : MainNavigationNames.auth;
  }

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationNames.auth: (context) => NotifierProvider(
          model: AuthModel(),
          child: const AuthorizationPage(),
        ),
    MainNavigationNames.mainPage: (context) => NotifierProvider(
          model: MainPageModel(),
          child: const MainPage(),
        ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => MoviePage(
            movieId: movieId,
            primaryColor: const Color.fromRGBO(10, 31, 52, 1),
          ),
        );
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
