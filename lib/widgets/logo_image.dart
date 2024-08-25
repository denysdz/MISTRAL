import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoImage extends StatelessWidget {
  const LogoImage(this.nameImage, {super.key});

  final String nameImage;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$nameImage.png',
      width: 113.r,
      height: 113.r,
    );
  }
}
