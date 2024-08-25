import 'package:elrond/settings/param.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/storage/SharedPreferencesUtil.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';
import 'package:elrond/wallet/WalletUtils.dart';
import 'package:elrond/widgets/btn_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'home_second_screen.dart';

class HomeFirstScreen extends StatefulWidget {
  const HomeFirstScreen({super.key});

  @override
  State<HomeFirstScreen> createState() => _HomeFirstScreenState();
}

class _HomeFirstScreenState extends State<HomeFirstScreen> {
  late CryptoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    someFunction();
    viewModel = Provider.of<CryptoViewModel>(context, listen: false);
    viewModel.startFetching();
    PARAM.switchBtn = true;
  }

  @override
  void dispose() {
    viewModel.stopFetching();
    super.dispose();
  }

 Future<void> someFunction() async {
  try {
    print("Fetching mnemonic phrase...");
    var seed = await SharedPreferencesUtil.getMnemonicPhrase();
    print("Fetched mnemonic phrase: $seed");

    if (seed != null) {
      var address = await WalletUtils().getAddress(seed);
      print("Address: $address");
    } else {
      print("Mnemonic phrase is null.");
    }
  } catch (e) {
    print("Error occurred while retrieving mnemonic phrase: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<CryptoViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 33.h),
                SizedBox(
                  height: 55.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text("Elrond",
                          style: ST.my(25, 600, color: const Color(0xFF4A55C1))),
                      Positioned(
                        right: 0,
                        child: BtnImage(
                          onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeSecondScreen()))
                              .then((_) => setState(() {})),
                          width: 55.h,
                          height: 55.h,
                          image: 'assets/images/plus.png',
                          imagePressed: 'assets/images/plus_act.png',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                Text("TOTAL BALANCE",
                    style: ST.my(22, 400), textAlign: TextAlign.center),
                SizedBox(height: 15.h),
                Image.asset('assets/images/logo_start_third.png',
                    width: 55.w, height: 55.w),
                SizedBox(height: 17.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "    EGLD",
                      style: ST.my(35, 600,
                          height: 1.29, color: const Color(0xFF4A55C1)),
                    ),
                    BtnImage(
                      onPressed: () => setState(() => PARAM.switchBtn = !PARAM.switchBtn),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      width: 18,
                      height: 18,
                      image: PARAM.switchBtn
                          ? 'assets/images/eye_off.png'
                          : 'assets/images/eye_on.png',
                      imagePressed: PARAM.switchBtn
                          ? 'assets/images/eye_off_act.png'
                          : 'assets/images/eye_on_act.png',
                    ),
                  ],
                ),
                PARAM.switchBtn
                    ? Text(
                        viewModel.balance == null
                        ? "Loading..."
                        : "${viewModel.balance?.toStringAsFixed(6)}",
                        style: ST.my(35, 600, height: 1.29),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "Balance Hidden",
                        style: ST.my(25, 400, height: 1.8),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(height: 33.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
              ],
            );
          },
        ),
    );
  }
}
