import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressBarWidget extends StatelessWidget {
  CircleProgressBarWidget(
      {super.key,
      this.margin = 0,
      this.showPercentValue = true,
      required this.percent,
      required this.lineWidth}) {
    switch (percent) {
      case == 0: {
        backgroundIndicatorColor = const Color.fromRGBO(102, 102, 102, 1);
        indicatorColor = Colors.transparent;
      }
      case >= 1 && < 40:
        {
          backgroundIndicatorColor = const Color.fromRGBO(87, 20, 53, 1);
          indicatorColor = const Color.fromRGBO(219, 35, 96, 1);
        }
      case >= 40 && < 70:
        {
          backgroundIndicatorColor = const Color.fromRGBO(66, 61, 15, 1);
          indicatorColor = const Color.fromRGBO(210, 213, 49, 1);
        }
      case >= 70:
        {
          backgroundIndicatorColor = const Color.fromRGBO(32, 69, 41, 1);
          indicatorColor = const Color.fromRGBO(33, 208, 122, 1);
        }
    }
  }

  final int percent;
  late final Color indicatorColor;
  late final Color backgroundIndicatorColor;
  final double lineWidth;
  final double margin;
  final bool showPercentValue;

  double calculateFontSize(
    double lineWidth,
    double margin,
  ) {
    return (lineWidth / 2 + margin) * 3;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MovieRatingPainter(
            percent: percent,
            indicatorColor: indicatorColor,
            backgroundIndicatorColor: backgroundIndicatorColor,
            lineWidth: lineWidth,
            margin: margin,
          ),
        ),
        if (showPercentValue)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                percent == 0 ? 'NR' : '$percent',
                style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: calculateFontSize(lineWidth, margin),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    );
  }
}

class MovieRatingPainter extends CustomPainter {
  final int percent;
  final Color indicatorColor;
  final Color backgroundIndicatorColor;
  final double lineWidth;
  final double margin;

  const MovieRatingPainter(
      {this.margin = 0,
  required this.backgroundIndicatorColor,
  required this.indicatorColor,
      required this.percent,
      required this.lineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Rect indicatorRect = calculateIndicatorRect(size);

    drawBackground(canvas, size);

    drawBackgroundIndicator(canvas, indicatorRect);

    drawIndicator(canvas, indicatorRect);
  }

  void drawIndicator(Canvas canvas, Rect indicatorRect) {
    final paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(
        indicatorRect, -pi / 2, pi * 2 * percent / 100, false, paint);
  }

  void drawBackgroundIndicator(Canvas canvas, Rect indicatorRect) {
    final paint = Paint();
    paint.color = backgroundIndicatorColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    canvas.drawOval(indicatorRect, paint);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = const Color.fromRGBO(8, 28, 34, 1);
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateIndicatorRect(Size size) {
    final offset = lineWidth / 2 + margin;
    final indicatorRect = Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);
    return indicatorRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
