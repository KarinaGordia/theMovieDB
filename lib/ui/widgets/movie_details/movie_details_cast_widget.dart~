import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/library/widgets/inherited/provider.dart';
import 'package:the_movie_db/ui/painters/custom_text_painter.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsCastWidget extends StatelessWidget {
  const MovieDetailsCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Top Billed Cast',
              style: TextStyle(
                fontSize: 19.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _ActorsListView(),
          // TextButton(
          //   onPressed: () {},
          //   style: ButtonStyle(
          //     padding: WidgetStateProperty.all(
          //       const EdgeInsets.symmetric(horizontal: 20),
          //     ),
          //   ),
          //   child: const Text(
          //     'Full Cast & Crew',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 19.2,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

const double posterHeight = 175;
const double cardWidth = 150;
const double hiddenCardPadding = 8;
const double textPadding = 10.0 * 2;
const double textHeight = 1.45;
const double additionalHeight = posterHeight + hiddenCardPadding + textPadding;
const double textWidth = cardWidth - textPadding - hiddenCardPadding;
const nameTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Roboto',
  height: 1.45,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
const characterTextStyle = TextStyle(
  height: 1.45,
  fontFamily: 'Roboto',
  fontSize: 14.4,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

class _ActorsListView extends StatelessWidget {
  const _ActorsListView();

  double _calculateTextHeight(
      BuildContext context, String text, TextStyle style, double stringWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: stringWidth);
    return textPainter.size.height;
  }

  double _calculateCardHeight(
      BuildContext context, List<CastMember> members, double stringWidth, double additionalHeight) {
    final maxNameHeight = members
        .map((member) =>
            _calculateTextHeight(
                context, member.name, nameTextStyle, stringWidth) +
            _calculateTextHeight(
                context, member.character, characterTextStyle, stringWidth))
        .reduce((a, b) => a > b ? a : b);

    final height = additionalHeight + maxNameHeight;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    var cast = NotifierProvider.watch<MovieDetailsModel>(context)
        ?.movieDetails
        ?.credits
        .cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    if (cast.length > 9) {
      cast = cast.sublist(0, 9);
    }

    final cardHeight = _calculateCardHeight(context, cast, textWidth, additionalHeight);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cast
              .map((member) => _ActorCard(
                    castMember: member,
                    height: cardHeight,
                    width: cardWidth,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard({
    required this.castMember,
    required this.height,
    required this.width,
  });

  final CastMember castMember;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final poster = castMember.profilePath;
    return ConstrainedBox(
      constraints: const BoxConstraints().tighten(width: width, height: height),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            poster != null
                ? Image.network(
                    ApiClient.imageUrl(poster),
                    height: posterHeight,
                    width: width,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: posterHeight,
                    alignment: Alignment.center,
                    child: const Text(
                      '?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomPaint(
                painter: CustomTextPainter(
                    labelText: castMember.name,
                    subText: castMember.character,
                    labelTextStyle: nameTextStyle,
                    subTextStyle: characterTextStyle,
                    stringWidth: textWidth,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


