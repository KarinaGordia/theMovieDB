import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/widgets.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderWidgetViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }
}