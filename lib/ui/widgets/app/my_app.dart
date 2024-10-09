import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/widgets/widgets.dart';
import 'package:the_movie_db/ui/theme/theme.dart';

import '../auth/auth_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.mainDarkBlue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.black87,
          backgroundColor: AppColors.mainDarkBlue,
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(
              color: Colors.white,
            ),
          ),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        filledButtonTheme: FilledButtonThemeData(
          style: AppButtonStyle.linkButton,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ),
      routes: {
        '/authorization_page': (context) => AuthProvider(
              model: AuthModel(),
              child: const AuthorizationPage(),
            ),
        '/main_page': (context) => const MainPage(),
        '/main_page/movie_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MoviePage(
              movieId: arguments,
              primaryColor: const Color.fromRGBO(10, 31, 52, 1),
            );
          }

          return const MoviePage(movieId: 0, primaryColor: Colors.black);
        },
      },
      // initialRoute: '/main_page',
      initialRoute: '/authorization_page',
      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute<void>(builder: (context) {
      //     return Scaffold(
      //       body: Center(
      //         child: Text('Navigation error'),
      //       ),
      //     );
      //   });
      // },
    );
  }
}
