import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthInProgress = false;
  bool get canStartAuth => !_isAuthInProgress;

  Future<void> auth(BuildContext context) async{

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