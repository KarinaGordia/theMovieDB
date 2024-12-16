import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_widget_view_model.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  static Widget create() {
    return Provider(
      create: (context) => LoaderWidgetViewModel(context),
      lazy: false,
      child: const LoaderWidget(),

    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
