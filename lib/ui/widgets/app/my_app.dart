import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          //backgroundColor: AppColors.mainDarkBlue,
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainDarkBlue),
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      routes: mainNavigation.routes,
      initialRoute: MainNavigationNames.loaderWidget,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
