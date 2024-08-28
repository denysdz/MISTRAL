import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final double underlineOffset;

  UnderlinedText({
    required this.text,
    required this.color,
    required this.fontSize,
    this.underlineOffset = 2.0, // Default offset
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: UnderlinePainter(
        text: text,
        color: color,
        fontSize: fontSize,
        underlineOffset: underlineOffset,
      ),
      child: Container(),
    );
  }
}

class UnderlinePainter extends CustomPainter {
  final String text;
  final Color color;
  final double fontSize;
  final double underlineOffset;

  UnderlinePainter({
    required this.text,
    required this.color,
    required this.fontSize,
    required this.underlineOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    textPainter.paint(canvas, Offset.zero);

    final underlinePaint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    final yOffset = textPainter.height + underlineOffset;
    canvas.drawLine(
      Offset(0, yOffset),
      Offset(textPainter.width, yOffset),
      underlinePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}