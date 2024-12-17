import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class AuthorizationViewModel extends ChangeNotifier {
  final _authService = AuthorizationService();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isAuthInProgress = false;

  bool get isAuthInProgress => _isAuthInProgress;

  bool get canStartAuth => !_isAuthInProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _updateErrorMessage('Please, fill in the username and the password fields', false);
      return;
    }

    _updateErrorMessage(null, true);

    _errorMessage = await _tryLogIn(login, password);

    if(_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateErrorMessage(_errorMessage, false);
    }
  }

  Future<String?> _tryLogIn(String login, String password) async {
    try {
      await _authService.logIn(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'The server is unavailable. Check your network connection.';
        case ApiClientExceptionType.auth:
          return 'Incorrect username or password';
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
        return 'An error has occurred. Please try again later.';
      }
    } catch (e) {
      return 'An error has occurred. Please try again later.';
    }
    return null;
  }

  void _updateErrorMessage(String? errorMessage, bool isAuthInProgress) {
    if(_errorMessage == errorMessage && _isAuthInProgress == isAuthInProgress) return;

    _errorMessage = errorMessage;
    _isAuthInProgress = isAuthInProgress;
    notifyListeners();
  }
}
