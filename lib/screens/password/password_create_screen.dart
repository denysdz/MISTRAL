import 'package:elrond/model/user_model.dart';
import 'package:elrond/screens/auth/auth_done_screen.dart';
import 'package:elrond/screens/home/home_first_screen.dart';
import 'package:elrond/settings/app_enum.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/storage/SharedPreferencesUtil.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';
import 'package:elrond/wallet/WalletUtils.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/custom_text_field.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PasswordCreateScreen extends StatefulWidget {
  final bool isAuthUser;
  final String phrase;
  const PasswordCreateScreen(this.isAuthUser, this.phrase, {Key? key}) : super(key: key);
 // Accept the phrase as a parameter

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreenState();
}

class _PasswordCreateScreenState extends State<PasswordCreateScreen> {
  TypeState isCheckBtn = TypeState.none;
  final ctrlPass = TextEditingController();
  final ctrlConfirm = TextEditingController();
  bool isActivityBtn = false;

  @override
  void dispose() {
    ctrlPass.dispose();
    ctrlConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Future.sync(computation)
    final viewModel = Provider.of<CryptoViewModel>(context, listen: false);
    if (viewModel.balance == null || viewModel.timer == null) viewModel.startFetching();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: AppSetting.sScreenHeight - AppSetting.sBottom - AppSetting.sTop,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 33.h),
                  Text("Awesome, now create a password",
                      style: ST.my(21, 500), textAlign: TextAlign.center),
                  SizedBox(height: 20.h),
                  isActivityBtn
                      ? const LogoImage("logo_psw_good")
                      : const LogoImage("logo_psw_none"),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text("Protect your account with a password.",
                        style: ST.my(18, 500, height: 1.39),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    title: "Password",
                    hintText: "Enter your password",
                    controller: ctrlPass,
                    onChanged: onChange,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    title: "Confirm Password",
                    hintText: "Confirm your password",
                    controller: ctrlConfirm,
                    onChanged: onChange,
                  ),
                  const Spacer(),
                  BtnGradient(
                    onPressed: isActivityBtn
                        ? () async {  // Use async for asynchronous operations
                            if (PARAM.tempUser != null) {
                              PARAM.user = PARAM.tempUser!
                                  .copyWith(password: ctrlConfirm.text.trim());
                            }
                            
                            await SharedPreferencesUtil.saveMnemonicPhrase(widget.phrase);
                            var address = await WalletUtils().getAddress(widget.phrase);
                            PARAM.user = UserModel(id: 0, phrase: widget.phrase, address: address, password: ctrlConfirm.text.trim());

                            if (widget.isAuthUser) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AuthDoneScreen(),
                                ),
                                (_) => false,
                              );
                            } else {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeFirstScreen(),
                                ),
                                (_) => false,
                              );
                            }
                          }
                        : null,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    text: "Continue",
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

  void onChange(String v) => setState(() => isActivityBtn =
      ctrlPass.text.isNotEmpty && ctrlPass.text == ctrlConfirm.text);
}
