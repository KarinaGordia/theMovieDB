import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/auth/authorization_page_model.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Movie DB',
        ),
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1.0),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: _HeaderWidget(),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  void _click() {
    log('text link click');
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      height: 1.3,
      fontSize: 16,
      color: Color.fromRGBO(0, 0, 0, 1),
    );
    const linkTextStyle = TextStyle(
      height: 1.3,
      fontSize: 16,
      color: Color.fromRGBO(1, 180, 228, 1),
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: const Text(
              'Login to your account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          _TextPartWidget(
            textParts: [
              const TextSpan(
                text:
                    'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
                style: textStyle,
              ),
              TextSpan(
                text: 'Click here',
                style: linkTextStyle,
                recognizer: TapGestureRecognizer()..onTap = _click,
              ),
              const TextSpan(
                text: ' to get started.',
                style: textStyle,
              ),
            ],
          ),
          _TextPartWidget(
            textParts: [
              const TextSpan(
                text:
                    'If you signed up but didn\'t get your verification email, ',
                style: textStyle,
              ),
              TextSpan(
                text: 'click here',
                style: linkTextStyle,
                recognizer: TapGestureRecognizer()..onTap = _click,
              ),
              const TextSpan(
                text: ' to have it resent.',
                style: textStyle,
              ),
            ],
          ),
          const _AuthorizationForm(),
        ],
      ),
    );
  }
}

class _TextPartWidget extends StatelessWidget {
  const _TextPartWidget({super.key, required this.textParts});

  final List<TextSpan> textParts;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: RichText(
        text: TextSpan(
          children: textParts,
        ),
      ),
    );
  }
}

class _AuthorizationForm extends StatelessWidget {
  const _AuthorizationForm();

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthorizationViewModel>();

    const textFieldHeaderTextStyle = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(33, 37, 41, 1),
    );
    const textFieldDecoration = InputDecoration(
      isCollapsed: true,
      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 6),
      border: OutlineInputBorder(),
    );

    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ErrorMessageWidget(),
          const Text(
            'Username',
            style: textFieldHeaderTextStyle,
          ),
          TextField(
            controller: model.loginTextController,
            decoration: textFieldDecoration,
          ),
          const Text(
            'Password',
            style: textFieldHeaderTextStyle,
          ),
          TextField(
            controller: model.passwordTextController,
            decoration: textFieldDecoration,
            obscureText: true,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const _AuthButtonWidget(),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Reset password',
                  style: TextStyle(
                    color: Color.fromRGBO(1, 180, 228, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthorizationViewModel>();
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    final child = model.isAuthInProgress
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : const Text(
            'Login',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          );
    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        context.select((AuthorizationViewModel vm) => vm.errorMessage);

    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 17,
        ),
      ),
    );
  }
}
