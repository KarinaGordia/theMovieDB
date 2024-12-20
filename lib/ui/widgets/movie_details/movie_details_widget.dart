import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_cast_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_main_info_widget.dart';

import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key, required this.primaryColor});

  final Color primaryColor;

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() =>
        context.read<MovieDetailsModel>().setupLocale(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _AppBarTitle(),
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1.0),
      ),
      body: ColoredBox(
        color: widget.primaryColor,
        child: _MovieDetailsBodyWidget(color: widget.primaryColor),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final movieName = context.select((MovieDetailsModel model) => model.data.title);
    return Text(movieName, overflow: TextOverflow.ellipsis,);
  }
}

class _MovieDetailsBodyWidget extends StatelessWidget {
  const _MovieDetailsBodyWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((MovieDetailsModel model) => model.data.isLoading);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        MovieDetailsMainInfoWidget(primaryColor: color),
        const ColoredBox(
          color: Colors.white,
          child: MovieDetailsCastWidget(),
        ),
      ],
    );
  }
}
