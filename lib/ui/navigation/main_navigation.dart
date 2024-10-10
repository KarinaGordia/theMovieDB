import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/widgets.dart';

class MainNavigationNames {
  static const auth = '/authorization_page';
  static const mainPage = '/main_page';
  static const movieDetails = '/main_page/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) {
    return isAuth ? MainNavigationNames.mainPage : MainNavigationNames.auth;
  }

  final routes = <String, Widget Function(BuildContext)>{
    '/authorization_page': (context) => AuthProvider(
          model: AuthModel(),
          child: const AuthorizationPage(),
        ),
    '/main_page': (context) => const MainPage(),
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
