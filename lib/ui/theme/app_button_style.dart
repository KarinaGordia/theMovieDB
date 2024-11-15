import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/theme.dart';

abstract class AppButtonStyle {
  static final ButtonStyle linkButton = ButtonStyle(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
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
      AppColors.blue,
    ),
  );
}