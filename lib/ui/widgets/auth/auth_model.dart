import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthInProgress = false;
  bool get isAuthInProgress => _isAuthInProgress;
  bool get canStartAuth => !_isAuthInProgress;

  Future<void> auth(BuildContext context) async{
    final login = loginTextController.text;
    final password =passwordTextController.text;
    if(login.isEmpty || password.isEmpty) {
      _errorMessage = 'Please, fill in the username and the password fields';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthInProgress = true;
    notifyListeners();

    final sessionId = _apiClient.auth(userName: login, password: password);
    _isAuthInProgress = false;
    notifyListeners();
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  const AuthProvider ({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

    static AuthProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}