import 'package:elrond/screens/home/home_first_screen.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthDoneScreen extends StatelessWidget {
  const AuthDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 33.h),
          Text("You’re awesome!",
              style: ST.my(25, 500), textAlign: TextAlign.center),
          SizedBox(height: 60.h),
          const LogoImage("logo_start_first"),
          SizedBox(height: 36.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            child: Text("You are now ready to enter the Elrond portal",
                style: ST.my(20, 500), textAlign: TextAlign.center),
          ),
          SizedBox(height: 22.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset('assets/images/text_auth_done.png'),
          ),
          SizedBox(height: 30.h),
          const Spacer(),
          BtnGradient(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeFirstScreen()),
                  (_) => false);
            },
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "Done",
          ),
          SizedBox(height: 70.h + AppSetting.sBottom),
        ],
      ),
    );
  }
}
