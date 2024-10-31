import 'package:flutter/material.dart';

class CustomTextPainter extends CustomPainter {
  final String labelText;
  final String subText;
  final TextStyle labelTextStyle;
  final TextStyle subTextStyle;
  final double stringWidth;

  CustomTextPainter({
    super.repaint,
    required this.labelText,
    required this.subText,
    required this.stringWidth,
    required this.labelTextStyle,
    required this.subTextStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        children: [
          TextSpan(
            text: labelText,
            style: labelTextStyle,
          ),
          TextSpan(
            text: '\n$subText',
            style: subTextStyle,
          ),
        ],
      ),
    );

    textPainter.layout(maxWidth: stringWidth);
    textPainter.paint(canvas, const Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}