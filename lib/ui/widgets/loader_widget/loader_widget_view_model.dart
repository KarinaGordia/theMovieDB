import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class LoaderWidgetViewModel {
  final BuildContext context;
  final _authorizationService = AuthorizationService();

  LoaderWidgetViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authorizationService.isAuthorized();
    final nextScreen =
        isAuth ? MainNavigationNames.mainPage : MainNavigationNames.auth;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
