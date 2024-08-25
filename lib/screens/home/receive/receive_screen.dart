import 'package:clipboard/clipboard.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'timer_dialog.dart';

class ReceiveScreen extends StatelessWidget {
  const ReceiveScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<CryptoViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 33.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text("Receive EGLD",
                          style: ST.my(21, 600, color: const Color(0xFF4A55C1))),
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
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const LogoImage("logo_receive"),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      "Your address for receiving Elrond EGLD",
                      style: ST.my(18, 500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF4A55C1), width: 2),
                    ),
                    child: Text(
                      PARAM.user?.address != null ? extractAddress(PARAM.user!.address) : "",
                      style: ST.my(18, 500, height: 1.33),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 11.h),
                  BtnGradient(
                    onPressed: () =>
                        FlutterClipboard.copy(PARAM.user?.address != null ? extractAddress(PARAM.user!.address) : "").then(
                      (_) {
                        if (context.mounted) {
                          return showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => const TimerDialog(),
                          );
                        }
                      },
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    text: "Copy",
                  ),
                  SizedBox(height: 43.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(viewModel.balance == null
                          ? "Loading..."
                          : "${viewModel.balance?.toStringAsFixed(6)}", style: ST.my(29, 600)),
                      Text("  EGLD",
                          style: ST.my(25, 400, color: const Color(0xFF4A55C1))),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(viewModel.usd == null
                                  ? "\$ 0.00"
                                  : "\$ ${viewModel.usd!.toStringAsFixed(2)}", style: ST.my(22, 400)),
                      Text(" USD",
                          style: ST.my(20, 400, color: const Color(0xFF4A55C1))),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
