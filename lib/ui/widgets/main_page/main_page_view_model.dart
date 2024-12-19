import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/ui.dart';

class MainPageViewModel {
  final _authService = AuthorizationService();
  Future<void> logOut(BuildContext context) async {
    await _authService.logOut();
    MainNavigation.resetNavigation(context);
  }
}