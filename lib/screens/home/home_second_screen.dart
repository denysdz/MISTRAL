import 'package:elrond/screens/password/password_input_screen.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/btn_image.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'dialog_code.dart';
import 'dialog_delete_account.dart';
import 'receive/receive_screen.dart';
import 'send/send_screen.dart';

class HomeSecondScreen extends StatefulWidget {
  const HomeSecondScreen({super.key});

  @override
  State<HomeSecondScreen> createState() => _HomeSecondScreenState();
}

 String extractAddress(String addr) {
    // Regular expression to match the text inside "Address{ ... }"
    RegExp regExp = RegExp(r'Address\{\s*(.*?)\s*\}');
    Match? match = regExp.firstMatch(addr);
    
    // Check if a match is found and extract the address
    if (match != null) {
      return match.group(1)!;  // Extracted address without unnecessary characters
    }
    
    // Return an empty string or error message if no match is found
    return ''; // Or you could return addr if you prefer the original input in case of no match
  }

class _HomeSecondScreenState extends State<HomeSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<CryptoViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    height: 41.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("Elrond",
                            style: ST.my(25, 600, color: const Color(0xFF4A55C1))),
                        Positioned(
                          left: -10,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  Image.asset('assets/images/back.png', width: 17.w),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: BtnImage(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PasswordInputScreen()),
                                  (_) => false);
                            },
                            padding: const EdgeInsets.all(0),
                            width: 76.w,
                            height: 41.w,
                            image: 'assets/images/lock.png',
                            imagePressed: 'assets/images/lock_act.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 77.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("My available deposit",
                                    style: ST.my(18, 400, height: 1)),
                                const SizedBox(width: 5),
                                BtnImage(
                                  onPressed: () =>
                                      setState(() => PARAM.switchBtn = !PARAM.switchBtn),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  width: 18.h,
                                  height: 18.h,
                                  image: PARAM.switchBtn
                                      ? 'assets/images/eye_off.png'
                                      : 'assets/images/eye_on.png',
                                  imagePressed: PARAM.switchBtn
                                      ? 'assets/images/eye_off_act.png'
                                      : 'assets/images/eye_on_act.png',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                PARAM.switchBtn
                                    ? Text(viewModel.balance == null
                                        ? "0.0000"
                                        : viewModel.balance!.toStringAsFixed(4),
                                        style: ST.my(27, 600, height: 1))
                                    : Text("Balance",
                                        style: ST.my(23, 400, height: 1)),
                                Text("  EGLD",
                                    style: ST.my(25, 400,
                                        color: const Color(0xFF4A55C1))),
                              ],
                            ),
                          ],
                        ),
                        Image.asset('assets/images/logo_start_third.png',
                            width: 55.h, height: 55.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 40.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PARAM.switchBtn
                            ? Text(viewModel.usd == null
                                ? "\$ 0.00"
                                : "\$ ${viewModel.usd!.toStringAsFixed(2)}",
                                style: ST.my(22, 400))
                            : Text("Hidden", style: ST.my(25, 400)),
                        Text(
                          "  USD",
                          style: ST.my(20, 400, color: const Color(0xFF4A55C1)),
                        ),
                        const Spacer(),
                        Text(
                          viewModel.elrondPrice == null
                            ? "Loading..."
                            : "\$ ${viewModel.elrondPrice?.toStringAsFixed(2)}",
                          style: ST.my(14, 400, height: 1.1),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          viewModel.elrondPercent == null
                              ? "" // Default value while loading
                              : "${viewModel.elrondPercent!.toStringAsFixed(2)}%",
                          style: ST.my(
                            12,
                            400,
                            height: 1.1,
                            color: viewModel.elrondPercent != null
                                ? viewModel.elrondPercent! >= 0
                                    ? const Color(0xFF00C314)
                                    : Colors.red
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      Expanded(
                        child: BtnGradient(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SendScreen())),
                          height: 82.h,
                          padding: EdgeInsets.zero,
                          radius: 10,
                          image: Image.asset(
                            'assets/images/send_btn.png',
                            height: 45.h,
                            width: 56.w,
                          ),
                        ),
                      ),
                      BtnImage(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (_) => DialogCode(PARAM.user?.address != null ? extractAddress(PARAM.user!.address) : ""),
                          );
                        },
                        image: 'assets/images/history_btn.png',
                        imagePressed: 'assets/images/history_btn_act.png',
                        width: 73.w,
                        height: 82.h,
                        padding: EdgeInsets.zero,
                      ),
                      Expanded(
                        child: BtnGradient(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReceiveScreen())),
                          height: 82.h,
                          padding: EdgeInsets.zero,
                          radius: 10,
                          image: Image.asset(
                            'assets/images/receive_btn.png',
                            height: 45.h,
                            width: 80.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "My transactions",
                    style:
                        ST.my(18, 400, height: 1.33, color: const Color(0xFF4A55C1)),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF4A55C1), width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LogoImage("logo_home"),
                          SizedBox(height: 15.h),
                          Text(
                            "Transactions are not found",
                            style: ST.my(14, 600, color: const Color(0xFF958A8A)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => const DialogDeleteAccount(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delete Account",
                              style: ST.my(15, 600, color: const Color(0xFFE43737)),
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/delete_account.png',
                                height: 20.h)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
