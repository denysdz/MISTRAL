import 'dart:async';

import 'package:elrond/screens/password/password_input_screen.dart';
import 'package:elrond/screens/start/start_first_screen.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoader = false;

  @override
  void initState() {
    super.initState();
    print("PARAM.user: ${PARAM.user}");
    Timer(
      const Duration(seconds: 3),
      () {
        if (PARAM.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordInputScreen(),
              ),
              (_) => false);
        } else {
          setState(() => isLoader = true);
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartFirstScreen(),
                ),
                (_) => false),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(80.w, 0.h, 80.w, 50.h),
              child: Image.asset('assets/images/logo_launch.png'),
            ),
          ),
          if (isLoader)
            Positioned(
              bottom: 170.h + AppSetting.sBottom,
              child: const SpinKitFadingCircle(color: Colors.white, size: 50),
            ),
          if (isLoader)
            Positioned(
              bottom: 45.h + AppSetting.sBottom,
              left: 45.w,
              right: 45.w,
              child: Text(
                "Connecting to the Elrond Secure Network",
                style: ST.my(25, 300),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
