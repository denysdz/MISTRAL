import 'package:elrond/screens/auth/auth_screen.dart';
import 'package:elrond/screens/registration/registration_first_screen.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartThirdScreen extends StatelessWidget {
  const StartThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 107.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Elrond is a highly scalable, secure and decentralized network",
              style: ST.my(21, 500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50.h),
          const LogoImage("logo_start_third"),
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              "Created to enable radically new applications for users, businesses, society, and the new metaverse frontier.",
              style: ST.my(21, 500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.h),
          const Spacer(),
          BtnGradient(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationFirstScreen())),
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "Create a new account",
          ),
          SizedBox(height: 20.h),
          BtnGradient(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
            ),
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "I already have a account",
          ),
          SizedBox(height: 11.h),
          RichText(
            text: TextSpan(
              text: "I accept ",
              style: ST.my(15, 400, height: 1.6),
              children: [
                TextSpan(
                  text: "Terms Of Use",
                  style: ST.my(15, 600, height: 1.6),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 35.h + AppSetting.sBottom),
        ],
      ),
    );
  }
}
