import 'package:elrond/screens/auth/auth_screen.dart';
import 'package:elrond/settings/app_enum.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/btn_text.dart';
import 'package:elrond/widgets/custom_back.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'registration_second_screen.dart';

class RegistrationFirstScreen extends StatefulWidget {
  const RegistrationFirstScreen({super.key});

  @override
  State<RegistrationFirstScreen> createState() => _RegistrationFirstScreenState();
}

class _RegistrationFirstScreenState extends State<RegistrationFirstScreen> {
  TypeState isCheckBtn = TypeState.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 33.h),
          const CustomBack(),
          SizedBox(height: 40.h),
          switch (isCheckBtn) {
            TypeState.none => const LogoImage("logo_regist_first_none"),
            TypeState.error => const LogoImage("logo_regist_first_error"),
            TypeState.good => const LogoImage("logo_regist_first_good"),
          },
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Image.asset('assets/images/warning.png',
                      width: 15.r, height: 15.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Elrond do not have a “Reset Password” feature. All you get is a Secret Phrase - make sure to keep it safe.",
                    style: ST.my(18, 500, height: 1.39),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => isCheckBtn =
                      (isCheckBtn == TypeState.good)
                          ? TypeState.none
                          : TypeState.good),
                  child: Image.asset(
                      switch (isCheckBtn) {
                        TypeState.none => "assets/images/check_btn_none.png",
                        TypeState.error => "assets/images/check_btn_error.png",
                        TypeState.good => "assets/images/check_btn_good.png",
                      },
                      width: 23.r,
                      height: 23.r),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "I Understand That I Need To Be Extra Careful To "
                    "Save The Passphrase And Back Up The Private Keys. "
                    "The Safety Of My Assets Will Depend On This",
                    style: GoogleFonts.pridi(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                      color: const Color(0xFF958A8A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          BtnGradient(
            onPressed: () {
              if (isCheckBtn == TypeState.good) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationSecondScreen()));
              } else {
                setState(() => isCheckBtn = TypeState.error);
              }
            },
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "Continue",
          ),
          SizedBox(height: 11.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have a account? ",
                style: ST.my(15, 400, height: 1.6),
              ),
              BtnText(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AuthScreen()));
                  },
                  text: "Access it",
                  style: ST.my(15, 600, height: 1.6)),
            ],
          ),
          SizedBox(height: 35.h + AppSetting.sBottom),
        ],
      ),
    );
  }
}
