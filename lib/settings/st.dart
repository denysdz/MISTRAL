import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ST {
  static TextStyle my(
    double fontSize,
    int weight, {
    Color? color = Colors.white,
    double opacity = 1,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
    double? height,
  }) {
    final fontWeight = weight == 0
        ? FontWeight.bold
        : weight == 100
            ? FontWeight.w100
            : weight == 200
                ? FontWeight.w200
                : weight == 300
                    ? FontWeight.w300
                    : weight == 400
                        ? FontWeight.w400
                        : weight == 500
                            ? FontWeight.w500
                            : weight == 600
                                ? FontWeight.w600
                                : weight == 700
                                    ? FontWeight.w700
                                    : weight == 800
                                        ? FontWeight.w800
                                        : weight == 900
                                            ? FontWeight.w900
                                            : FontWeight.normal;
    return GoogleFonts.radioCanada(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: height,
      color: color?.withOpacity(opacity),
    );
  }
}
