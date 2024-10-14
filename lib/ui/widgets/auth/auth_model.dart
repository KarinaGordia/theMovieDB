import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthInProgress = false;
  bool get isAuthInProgress => _isAuthInProgress;
  bool get canStartAuth => !_isAuthInProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Please, fill in the username and the password fields';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthInProgress = true;
    notifyListeners();

    String? sessionId;

    try {
      sessionId = await _apiClient.auth(userName: login, password: password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'The server is unavailable. Check your network connection.';
        case ApiClientExceptionType.auth:
          _errorMessage = 'Incorrect username or password';
        case ApiClientExceptionType.other:
          _errorMessage = 'An error has occurred. Please try again later.';
      }
    } catch (e) {
      _errorMessage = 'An error has occurred. Please try again later.';
    }

    _isAuthInProgress = false;

    if(_errorMessage != null || sessionId == null) {
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context).pushReplacementNamed(MainNavigationNames.mainPage));
  }
}
