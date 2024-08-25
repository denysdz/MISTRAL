import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'start_third_screen.dart';

class StartSecondScreen extends StatelessWidget {
  const StartSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Text(
              "Your security is paramount to us",
              style: ST.my(21, 500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          const LogoImage("logo_start_second"),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Text(
              "With this great power comes great responsibility, so it is very important to understand that",
              style: ST.my(18, 500, height: 1.2),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset('assets/images/text_start_second.png',
                height: 210.h, width: 335.w),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              "Please be very careful to save your secret phrase and backup your private keys. Your funds will depend on it.",
              style: ST.my(16, 500, height: 1.2),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          BtnGradient(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StartThirdScreen()),
                (_) => false),
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "Continue",
          ),
          SizedBox(height: 70.h + AppSetting.sBottom),
        ],
      ),
    );
  }
}
