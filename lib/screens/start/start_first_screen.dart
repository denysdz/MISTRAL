import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'start_second_screen.dart';

class StartFirstScreen extends StatelessWidget {
  const StartFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 53.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 41.w),
            child: Text(
              "Key advantages of our decentralized digital platform",
              style: ST.my(21, 500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 35.h),
          const LogoImage("logo_start_first"),
          SizedBox(height: 34.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset('assets/images/text_start_first.png',
                height: 209.h, width: 335.w),
          ),
          const Spacer(),
          BtnGradient(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const StartSecondScreen()),
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
