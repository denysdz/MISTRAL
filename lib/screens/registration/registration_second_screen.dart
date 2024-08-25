import 'dart:math';

import 'package:elrond/settings/app_enum.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/model/user_model.dart';
import 'package:elrond/wallet/WalletUtils.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/btn_image.dart';
import 'package:elrond/widgets/custom_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clipboard/clipboard.dart';

import 'dialog_copy.dart';
import 'registration_third_screen.dart';

class RegistrationSecondScreen extends StatefulWidget {
  const RegistrationSecondScreen({super.key});

  @override
  State<RegistrationSecondScreen> createState() => _RegistrationSecondScreenState();
}

class _RegistrationSecondScreenState extends State<RegistrationSecondScreen> {
  TypeState isCheckBtn = TypeState.none;
  List<String> listPhrase = [];

  @override
  void initState() {
    final rnd = Random();
    final UserModel userRnd = AppSetting.LIST_USERS[rnd.nextInt(1)];
    PARAM.tempUser = userRnd;
    //listPhrase = userRnd.phrase.trim().split(" ");
    listPhrase = WalletUtils().generateMnemonic().toString().trim().split(" ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 33.h),
          const CustomBack(),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                    "Write down these words in this exact order. You can "
                    "use them to access your wallet, make sure you protect them.",
                    style: ST.my(18, 500, height: 1.39),
                  ),
                ),
              ],
            ),
          ),
          BtnImage(
            onPressed: () {
              String textCopy = "";
              for (var i = 0; i < listPhrase.length; i++) {
                textCopy += "${i+1}.${listPhrase[i]} ";
              }
              FlutterClipboard.copy(textCopy.trim()).then(
              (_) {
                if (context.mounted) {
                  return showDialog(
                    context: context,
                    builder: (_) => const DialogCopy(),
                  );
                }
              },
            );
            },
            image: "assets/images/copy_btn.png",
            imagePressed: "assets/images/copy_btn_pressed.png",
            width: 18.r,
            height: 18.r,
          ),
          SizedBox(height: 8.h),
          Container(
            height: AppSetting.sScreenHeight - 460.h - AppSetting.sBottom,
            margin: EdgeInsets.symmetric(horizontal: 27.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF4A55C1), width: 2),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Кількість по горизонталі
                mainAxisSpacing: 2.h, // spacing between rows
                crossAxisSpacing: 23.w, // spacing between columns
                mainAxisExtent: 25.0.h, // Висота кожного елемента
              ),
              itemCount: listPhrase.length,
              itemBuilder: (_, index) {
                int column = index % 2;
                int row = index ~/ 2;
                int verticalIndex = row + column * 12;
                return Row(
                  children: [
                    Text(
                      "${verticalIndex + 1}. ",
                      style: ST.my(15, 600,
                          height: 1.39, color: const Color(0xFF958A8A)),
                    ),
                    Text(
                      listPhrase[verticalIndex],
                      style: ST.my(18, 600),
                    ),
                  ],
                );
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
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
                    "I confirm I have written down and safely stored my secret phrase.",
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
          SizedBox(height: 10.h),
          BtnGradient(
            onPressed: () {
              if (isCheckBtn == TypeState.good) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationThirdScreen(listPhrase)),
                );
              } else {
                setState(() => isCheckBtn = TypeState.error);
              }
            },
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "Continue",
          ),
          SizedBox(height: 70.h + AppSetting.sBottom),
        ],
      ),
    );
  }
}
