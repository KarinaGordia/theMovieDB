import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressBarWidget extends StatelessWidget {
  CircleProgressBarWidget(
      {super.key,
      this.margin,
      this.showPercentValue = true,
      required this.percent,
      required this.backgroundColor,
      required this.indicatorColor,
      required this.backgroundIndicatorColor,
      required this.lineWidth});

  final int percent;
  final Color backgroundColor;
  final Color indicatorColor;
  final Color backgroundIndicatorColor;
  final double lineWidth;
  double? margin;
  final bool showPercentValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: theMovieDBRatingPainter(
            percent: percent,
            backgroundColor: backgroundColor,
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
                '$percent',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: (lineWidth / 2 + (margin ??= 0)) * 3,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    );
  }
}

class theMovieDBRatingPainter extends CustomPainter {
  final int percent;
  final Color backgroundColor;
  final Color indicatorColor;
  final Color backgroundIndicatorColor;
  final double lineWidth;
  double? margin = 0;

  theMovieDBRatingPainter(
      {this.margin,
      required this.percent,
      required this.backgroundColor,
      required this.indicatorColor,
      required this.backgroundIndicatorColor,
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
    paint.color = backgroundColor;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateIndicatorRect(Size size) {
    final offset = lineWidth / 2 + (margin ??= 0);
    final indicatorRect = Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);
    return indicatorRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
