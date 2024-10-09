part of 'movie_details_widget.dart';

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
          name: 'Spider-Man: Far From Home',
          releaseYear: 2019,
        ),
        _UserScoreWidget(
          score: 72,
          textColor: textColor,
        ),
        _GeneralMovieInfoWidget(
          textColor: textColor,
          filmRating: '12A',
          runtime: '1h 55m',
          releaseDate: '29/03/2024 (GB)',
          genres: const [
            'Science Fiction',
            'Action',
            'Adventure',
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TagLineWidget(secondaryTextColor: secondaryTextColor),
              _OverviewWidget(textColor: textColor),
              _DescriptionTextWidget(textColor: textColor),
              Column(
                children: [
                  _CreatorProfilesRow(
                    firstCreatorProfile: _CreatorProfileWidget(
                      name: 'Adam Wingard',
                      occupation: 'Director, Story',
                      textColor: textColor,
                    ),
                    secondCreatorProfile: _CreatorProfileWidget(
                      name: 'Terry Rossio',
                      occupation: 'Screenplay, Story',
                      textColor: textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _CreatorProfilesRow(
                    firstCreatorProfile: _CreatorProfileWidget(
                      name: 'Simon Barrett',
                      occupation: 'Screenplay, Story',
                      textColor: textColor,
                    ),
                    secondCreatorProfile: _CreatorProfileWidget(
                      name: 'Jeremy Slater',
                      occupation: 'Screenplay',
                      textColor: textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Row(
        //   children: [
        //     TextButton(onPressed: onPressed, child: child),
        //     Divider(),
        //     TextButton(onPressed: onPressed, child: child),
        //   ],
        // ),
        // Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(),
        //         Text(data),
        //         Divider(),
        //         Text(data),
        //         TextButton(onPressed: onPressed, child: child),
        //       ],
        //     ),
        //     Text(data),
        //   ],
        // ),
        // Column(
        //   children: [
        //     Text(data),
        //     Text(data),
        //     Table(
        //       children: [
        //         TableRow(
        //           children: [
        //             CreatorProfileWidget(),
        //             CreatorProfileWidget(),
        //           ],
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _CreatorProfilesRow extends StatelessWidget {
  const _CreatorProfilesRow({
    required this.firstCreatorProfile,
    required this.secondCreatorProfile,
  });

  final _CreatorProfileWidget firstCreatorProfile;
  final _CreatorProfileWidget secondCreatorProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: firstCreatorProfile,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: secondCreatorProfile,
          ),
        ),
      ],
    );
  }
}

class _CreatorProfileWidget extends StatelessWidget {
  const _CreatorProfileWidget({
    required this.name,
    required this.occupation,
    required this.textColor,
  });

  final String name;
  final String occupation;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          occupation,
          style: TextStyle(
            color: textColor,
            fontSize: 14.4,
          ),
        ),
      ],
    );
  }
}

class _TagLineWidget extends StatelessWidget {
  const _TagLineWidget({
    required this.secondaryTextColor,
  });

  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Rise together or fall alone.',
      style: TextStyle(
          color: secondaryTextColor,
          fontSize: 17.6,
          fontStyle: FontStyle.italic),
    );
  }
}

class _DescriptionTextWidget extends StatelessWidget {
  const _DescriptionTextWidget({
    required this.textColor,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Text(
        'Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.',
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({
    required this.textColor,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
      child: Text(
        'Overview',
        style: TextStyle(
            color: textColor, fontSize: 20.8, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Image(
          image: AssetImage(AppImages.spidermanBackground),
        ),
        Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: Image(image: AssetImage(AppImages.spidermanPoster))),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget(
      {required this.name,
      required this.releaseYear,
      required this.textColor});

  final String name;
  final int releaseYear;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: name,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w600, fontSize: 20),
            ),
            TextSpan(
              text: ' ($releaseYear)',
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
  const _UserScoreWidget({required this.textColor, required this.score});

  final Color textColor;
  final int score;

  @override
  Widget build(BuildContext context) {
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
                  backgroundColor: const Color.fromARGB(255, 10, 23, 25),
                  indicatorColor: const Color.fromARGB(255, 37, 203, 103),
                  backgroundIndicatorColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  margin: 3,
                ),
              ),
              const SizedBox(width: 10,),
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
  const _GeneralMovieInfoWidget(
      {required this.filmRating,
      this.releaseDate,
      this.runtime,
      required this.genres,
      required this.textColor});

  final String filmRating;
  final String? releaseDate;
  final String? runtime;
  final List<String> genres;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    var textStyle =
        TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 16);
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
                Text(
                  '$filmRating, $releaseDate, $runtime',
                  style: textStyle,
                ),
                SizedBox(
                  height: 24,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                    onPressed: () {},
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
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: genres
                    .map((genre) => TextSpan(
                          text: '$genre, ',
                          style: textStyle,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
