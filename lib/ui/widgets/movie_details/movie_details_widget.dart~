import 'package:flutter/material.dart';
import 'package:the_movie_db/library/widgets/inherited/provider.dart';
import 'package:the_movie_db/ui/widgets/app/my_app_model.dart';
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
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel= Provider.read<MyAppModel>(context);

    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Movie DB',
        ),
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1.0),
      ),
      body: ColoredBox(
        color: widget.primaryColor,
        child: _MovieDetailsBodyWidget(color: widget.primaryColor),
      ),
    );
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if(movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        MovieDetailsMainInfoWidget(
          primaryColor: color,
        ),
        const ColoredBox(
          color: Colors.white,
          child: MovieDetailsCastWidget(),
        ),
      ],
    );
  }
}
