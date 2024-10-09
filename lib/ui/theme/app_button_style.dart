import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static final ButtonStyle linkButton = ButtonStyle(
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: 19.2,
        vertical: 6,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
    ),
    backgroundColor: WidgetStateProperty.all(
      Color.fromRGBO(1, 180, 228, 1),
    ),
  );
}