import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/painters/circle_progress_bar.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key, required this.primaryColor});

  final Color primaryColor;

  Color chooseTextColor(Color color) {
    const flipYs = 0.342; // based on APCA™ 0.98G middle contrast BG color

    const trc = 2.4;
    const rCoef = 0.2126729;
    const gCoef = 0.7151522;
    const bCoef = 0.0721750; // 0.98G
    var yS = pow((color.red / 255.0), trc) * rCoef +
        pow((color.green / 255.0), trc) * gCoef +
        pow((color.blue / 255.0), trc) * bCoef;

    return yS < flipYs ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = chooseTextColor(primaryColor);
    const secondaryTextColor = Color.fromRGBO(239, 239, 239, 1);
    return Column(
      children: [
        const _TopPosterWidget(),
        _MovieNameWidget(
          textColor: textColor,
        ),
        _UserScoreWidget(
          textColor: textColor,
        ),
        _GeneralMovieInfoWidget(
          textColor: textColor,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OverviewWidget(
                textColor: textColor,
                secondaryTextColor: secondaryTextColor,
              ),
              const _CrewWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget();

  double calculateAspectRatio(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait ? 16 / 9 : 3;
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    final posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;

    return AspectRatio(
      aspectRatio: calculateAspectRatio(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (backdropPath != null)
            Image.network(ImageDownloader.imageUrl(backdropPath)),
          if (posterPath != null)
            Positioned(
              top: 20,
              bottom: 20,
              left: 20,
              child: Image.network(
                ImageDownloader.imageUrl(posterPath),
              ),
            ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              onPressed: () => model.addToFavorite(context),
              icon: Icon(posterData.favoriteIcon),
              color: Colors.white,
              style: const ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(50, 50)),
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromRGBO(10, 31, 52, 1))),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        context.select((MovieDetailsModel model) => model.data);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: movieDetails.title,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w600, fontSize: 20),
            ),
            TextSpan(
              text: movieDetails.releaseYear,
              style: const TextStyle(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserScoreWidget extends StatelessWidget {
  const _UserScoreWidget({required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final score =
        context.select((MovieDetailsModel model) => model.data.voteAverage);
    final textStyle = TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 16,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: CircleProgressBarWidget(
                  percent: score,
                  lineWidth: 3,
                  margin: 3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text('User Score', style: textStyle),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 24,
          color: const Color.fromRGBO(255, 255, 255, 0.3),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'What\'s your Vibe?',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class _GeneralMovieInfoWidget extends StatelessWidget {
  const _GeneralMovieInfoWidget({required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        context.select((MovieDetailsModel model) => model.data);
    final releaseInfo = movieDetails.releaseInfo;

    final certification = releaseInfo?.certification;
    final releaseDate = releaseInfo?.releaseDate ?? '';
    final countryCode = releaseInfo?.countryCode ?? '';
    final runtime = movieDetails.runtime;
    final genres = movieDetails.genres;

    var textStyle = TextStyle(
      color: textColor,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
    const borderStyle = BorderSide(
      color: Color.fromRGBO(0, 0, 0, 0.2),
    );

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        border: Border(
          top: borderStyle,
          bottom: borderStyle,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (certification != null)
                  Container(
                    padding: const EdgeInsets.only(
                        top: 1, bottom: 2.4, left: 4, right: 4),
                    margin: const EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(168, 160, 160, 1),
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      certification,
                      style: textStyle,
                    ),
                  ),
                Text(
                  '$releaseDate $countryCode, $runtime',
                  style: textStyle,
                ),
                _PlayTrailerButton(textColor: textColor),
              ],
            ),
            Text(
              genres,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayTrailerButton extends StatelessWidget {
  const _PlayTrailerButton({
    super.key,
    required this.textColor,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final trailerKey =
        context.select((MovieDetailsModel model) => model.data.trailerKey);
    if (trailerKey == null) return const SizedBox.shrink();
    return SizedBox(
      height: 24,
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
        onPressed: () => Navigator.of(context).pushNamed(
            MainNavigationNames.movieTrailerWidget,
            arguments: trailerKey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              color: textColor,
            ),
            Text(
              'Play trailer',
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({
    required this.textColor,
    required this.secondaryTextColor,
  });

  final Color textColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        context.select((MovieDetailsModel model) => model.data);
    final tagline = movieDetails.tagline;
    final overview = movieDetails.overview;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tagline,
          style: TextStyle(
              color: secondaryTextColor,
              fontSize: 17.6,
              fontStyle: FontStyle.italic),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Overview',
            style: TextStyle(
                color: textColor, fontSize: 20.8, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            overview,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _CrewWidget extends StatelessWidget {
  const _CrewWidget();

  @override
  Widget build(BuildContext context) {
    final members =
        context.select((MovieDetailsModel model) => model.data.crew);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: members.entries
            .map((entry) => _CreatorProfileWidget(
                  name: entry.key,
                  occupation: entry.value,
                ))
            .toList(),
      ),
    );
  }
}

class _CreatorProfileWidget extends StatelessWidget {
  const _CreatorProfileWidget({
    required this.name,
    required this.occupation,
  });

  final String name;
  final String occupation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            occupation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.4,
            ),
          ),
        ],
      ),
    );
  }
}
