import 'package:elrond/settings/st.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key, this.title = "Create Account"});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(title, style: ST.my(21, 500)),
        Positioned(
          left: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/images/back.png', width: 17.w),
            ),
          ),
        ),
      ],
    );
  }
}
