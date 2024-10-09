import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Movie DB',
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
            color: const Color.fromRGBO(1, 180, 228, 1),
          ),
        ],
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

  void _click() {}

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
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
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
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
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
            ),
          ),
          const _AuthorizationForm(),
        ],
      ),
    );
  }
}

class _AuthorizationForm extends StatelessWidget {
  const _AuthorizationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    
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
            controller: model?.loginTextController,
            decoration: textFieldDecoration,
          ),
          const Text(
            'Password',
            style: textFieldHeaderTextStyle,
          ),
          TextField(
            controller: model?.passwordTextController,
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
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed = model?.canStartAuth == true ? () => model?.auth(context) : null;
    return FilledButton(
      onPressed: onPressed,
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;

    if(errorMessage == null) return const SizedBox.shrink();

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
