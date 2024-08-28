import 'package:elrond/model/user_model.dart';
import 'package:elrond/screens/password/password_create_screen.dart';
import 'package:elrond/settings/app_enum.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/wallet/WalletUtils.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/custom_back.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth_text_field.dart';
import 'dialog_invalid_phrase.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ctrl = TextEditingController();
  TypeState isCheckBtn = TypeState.none;
  bool isActivityBtn = false;

  @override
  void dispose() {
    ctrl.dispose();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 33.h),
                const CustomBack(title: "Recover Account"),
                SizedBox(height: 40.h),
                switch (isCheckBtn) {
                  TypeState.none => const LogoImage("logo_auth_none"),
                  TypeState.error => const LogoImage("logo_auth_error"),
                  TypeState.good => const LogoImage("logo_auth_good"),
                },
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Text(
                    "Enter the words of the Secret Phrase in the correct order.",
                    style: ST.my(18, 500, height: 1.39),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27.w),
                  child: AuthTextField(
                    controller: ctrl,
                    onChanged: (p0) => setState(() {
                      if (p0.length >= 30) {
                        isCheckBtn = TypeState.good;
                        isActivityBtn = true;
                      } else {
                        isCheckBtn = TypeState.none;
                        isActivityBtn = false;
                      }
                    }),
                  ),
                ),
                const Spacer(),
                BtnGradient(
                  onPressed: isActivityBtn
                      ? () async {
                          try {
                            
                            String address = await WalletUtils().getAddress(ctrl.text.toString());
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PasswordCreateScreen(
                                      true,
                                      ctrl.text.toString(),
                                    ),
                                  ),
                                (_) => false);
                          } catch (e) {
                            setState(() {
                              isCheckBtn = TypeState.error;
                              isActivityBtn = false;
                              showDialog(
                                context: context,
                                builder: (_) => const DialogInvalidPhrase(),
                              );
                            });
                          }
                        }
                      : null,
                  margin: EdgeInsets.symmetric(horizontal: 37.w),
                  text: "Login",
                ),
                SizedBox(height: 70.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
