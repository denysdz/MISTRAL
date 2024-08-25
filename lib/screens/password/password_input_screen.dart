import 'package:elrond/screens/home/home_first_screen.dart';
import 'package:elrond/screens/start/start_third_screen.dart';
import 'package:elrond/settings/app_enum.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/btn_text.dart';
import 'package:elrond/widgets/custom_text_field.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_invalid_password.dart';

class PasswordInputScreen extends StatefulWidget {
  const PasswordInputScreen({super.key});

  @override
  State<PasswordInputScreen> createState() => _PasswordCreateScreenState();
}

class _PasswordCreateScreenState extends State<PasswordInputScreen> {
  TypeState isCheckBtn = TypeState.none;
  final ctrlPass = TextEditingController();
  bool isActivityBtn = false;

  @override
  void dispose() {
    ctrlPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height:
                AppSetting.sScreenHeight - AppSetting.sBottom - AppSetting.sTop,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 76.h),
                  Text("Enter your password",
                      style: ST.my(21, 500), textAlign: TextAlign.center),
                  SizedBox(height: 50.h),
                  switch (isCheckBtn) {
                    TypeState.none => const LogoImage("logo_psw_none"),
                    TypeState.error => const LogoImage("logo_psw_error"),
                    TypeState.good => const LogoImage("logo_psw_good"),
                  },
                  SizedBox(height: 50.h),
                  CustomTextField(
                    title: "Password",
                    hintText: "Enter your password",
                    controller: ctrlPass,
                    onChanged: onChange,
                  ),
                  SizedBox(height: 23.h),
                  Center(
                    child: BtnText(
                      onPressed: () {
                        PARAM.tempUser = null;
                        PARAM.user = null;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StartThirdScreen()),
                            (_) => false);
                      },
                      text: "I forgot my password",
                      style: ST.my(15, 500, color: const Color(0xFF4A55C1)),
                    ),
                  ),
                  const Spacer(),
                  BtnGradient(
                    onPressed: isActivityBtn
                        ? () {
                            if (PARAM.user?.password == ctrlPass.text.trim()) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeFirstScreen()),
                                  (_) => false);
                            } else {
                              setState(() {
                                isCheckBtn = TypeState.error;
                                isActivityBtn = false;
                                showDialog(
                                  context: context,
                                  builder: (_) => const DialogInvalidPassword(),
                                );
                              });
                            }
                          }
                        : null,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    text: "Unlock",
                  ),
                  SizedBox(height: 70.h + AppSetting.sBottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onChange(String v) => setState(() {
        isActivityBtn = ctrlPass.text.isNotEmpty;
        isCheckBtn = isActivityBtn ? TypeState.good : TypeState.none;
      });
}
