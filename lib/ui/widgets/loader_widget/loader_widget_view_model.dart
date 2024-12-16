import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class LoaderWidgetViewModel {
  final BuildContext context;
  final _sessionDataProvider = SessionDataProvider();

  LoaderWidgetViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    final nextScreen =
        isAuth ? MainNavigationNames.mainPage : MainNavigationNames.auth;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
