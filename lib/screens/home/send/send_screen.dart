import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_error_send.dart';
import 'text_field_amount.dart';
import 'text_field_code.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final ctrlCode = TextEditingController();
  final ctrlAmount = TextEditingController();
  bool isActivityBtn = false;

  @override
  void initState() {
    ctrlCode.addListener(checkBtn);
    ctrlAmount.addListener(checkBtn);
    super.initState();
  }

  @override
  void dispose() {
    ctrlCode.dispose();
    ctrlAmount.dispose();
    super.dispose();
  }

  void checkBtn() => setState(() => isActivityBtn =
      ctrlCode.text.trim().length >= 20 && ctrlAmount.text.trim().isNotEmpty
          ? true
          : false);

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
                  SizedBox(height: 33.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text("Send EGLD",
                          style: ST.my(21, 600,
                              color: const Color(0xFF4A55C1))),
                      Positioned(
                        left: -10,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset('assets/images/back.png', width: 17.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const LogoImage("logo_send"),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      "To send the EGLD please fill out all the fields",
                      style: ST.my(18, 500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 45.h),
                  TextFieldCode(
                    controller: ctrlCode,
                    title: "Enter recipient's address",
                    hintText: "Enter address",
                  ),
                  SizedBox(height: 20.h),
                  TextFieldAmount(
                    controller: ctrlAmount,
                    title: "Enter Amount (EGLD)",
                    hintText: "Enter Amount",
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text("0.0000", style: ST.my(18, 600)),
                      Text(
                        " EGLD",
                        style:
                            ST.my(18, 600, color: const Color(0xFF4A55C1)),
                      ),
                      const Spacer(),
                      Text(
                        "Fee: ",
                        style:
                            ST.my(18, 600, color: const Color(0xFF4A55C1)),
                      ),
                      Text("0.0000", style: ST.my(18, 600)),
                    ],
                  ),
                  const Spacer(),
                  BtnGradient(
                    onPressed: isActivityBtn
                        ? () => showDialog(
                              context: context,
                              builder: (_) => const DialogErrorSend("", ""),
                            )
                        : null,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    text: "Send",
                  ),
                  SizedBox(height: 70.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
