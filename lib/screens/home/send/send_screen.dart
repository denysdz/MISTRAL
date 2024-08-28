import 'dart:async';

import 'package:dio/dio.dart';
import 'package:elrond/multiversx.dart';
import 'package:elrond/screens/home/home_second_screen.dart';
import 'package:elrond/screens/home/send/dialog_confirm.dart';
import 'package:elrond/screens/home/send/dialog_success_send.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/storage/SharedPreferencesUtil.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' as ViewModelProvider;

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
  var _key = GlobalKey();

  var balanceDisplay = "0.0000";

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

    final denomination = 18;
    final oneEGLD = BigInt.from(1000000000000000000);

    String bigIntToEGLD(BigInt value) {
      final integerPart = value ~/ oneEGLD; // Integer part
      final fractionalPart = value % oneEGLD; // Fractional part
      final fractionalStr = fractionalPart.toString().padLeft(denomination, '0').substring(0, 5); // Format to 2 decimal places
      
      return '$integerPart.$fractionalStr';
    }

  Future<void> fetchBalance() async {
      try {
        final dio = Dio();
        final proxy = ProxyProvider(
         addressRepository: AddressRepository(dio, baseUrl: 'https://gateway.multiversx.com/'),
         networkRepository: NetworkRepository(dio, baseUrl: 'https://gateway.multiversx.com/'),
         transactionRepository: TransactionRepository(dio, baseUrl: 'https://gateway.multiversx.com/'),
        );
        final seed = await SharedPreferencesUtil.getMnemonicPhrase();
        final wallet = await Wallet.fromSeed(seed!);
        await wallet.synchronize(proxy);

        final balance = wallet.account.balance; // Fetch wallet balance
        setState(() {
          balanceDisplay = double.parse(balance.toDenominated).toStringAsFixed(4); // Update balance display
        });
      } catch (e) {
        print("Failed to fetch balance: $e");
      }
    }

  void onSend() async {
  try {
    final dio = Dio();
    final proxy = ProxyProvider(
      addressRepository: AddressRepository(dio, baseUrl: 'https://gateway.multiversx.com/'),
      networkRepository: NetworkRepository(dio, baseUrl: 'https://gateway.multiversx.com/'),
      transactionRepository: TransactionRepository(dio, baseUrl: 'https://gateway.multiversx.com/'),
    );
    final networkConfiguration = await proxy.getNetworkConfiguration();
    var seed = await SharedPreferencesUtil.getMnemonicPhrase();
    final wallet = await Wallet.fromSeed(seed!);
    await wallet.synchronize(proxy);

    try {
      var address = Address.fromBech32(ctrlCode.text.toString());

      try {
        var amount = Balance.fromEgld(double.parse(ctrlAmount.text.toString()));

        final transaction = Transaction(
          chainId: networkConfiguration.chainId,
          gasLimit: networkConfiguration.minGasLimit,
          gasPrice: networkConfiguration.minGasPrice,
          transactionVersion: networkConfiguration.minTransactionVersion,
          data: TransactionPayload.empty(),
          signature: Signature.empty(),
          nonce: wallet.account.nonce,
          sender: wallet.account.address,
          receiver: address,
          balance: amount,
        );

        BigInt fee = BigInt.from(transaction.fee);

        if (wallet.account.balance.value + fee < amount.value) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (_) => const DialogErrorSend("", "Insufficient balance!"),
            );
          }
          return;
        }

        if (mounted) {
          await showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogConfirmSend(
                address: extractAddress(address.toString()),
                amount: double.parse(amount.toDenominated).toStringAsFixed(5),
                fee: double.parse(bigIntToEGLD(fee)).toStringAsFixed(5),
                onConfirm: () async {
                  try {
                    if (mounted) {
                        final txHash = await wallet.sendEgld(
                          provider: proxy,
                          to: address,
                          amount: amount,
                        );
                        if (mounted) {
                            await Future.delayed(Duration(milliseconds: 500), () async {
                              if (mounted) {
                                showDialog(
                                  context: _key.currentContext!,
                                  builder: (_) => const DialogSuccessSend("", "Transaction sent successfully!"),
                                );
                              }
                            });
                          }
                    }
                    ctrlCode.text = "";
                    ctrlAmount.text = "";
                  } catch (e) {
                    if (mounted) {
                      await showDialog(
                        context: _key.currentContext!,
                        builder: (_) => const DialogErrorSend("", "Something went wrong. Please try again later!"),
                      );
                    }
                  }
                },
              );
            },
          );
        }
      } catch (e) {
        print(e);
        if (mounted) {
          await showDialog(
            context: context,
            builder: (_) => const DialogErrorSend("", "Incorrect amount!"),
          );
        }
      }
    } catch (e) {
      await showDialog(
            context: _key.currentContext!,
            builder: (_) => const DialogErrorSend("", "Incorrect address!"),
          );
    }
  } catch (e) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => const DialogErrorSend("", "Failed to send. Check your internet connection and try again!"),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ViewModelProvider.Consumer<CryptoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
          key: _key,
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
                        Text(viewModel.balance == null
                        ? "Loading..."
                        : "${viewModel.balance?.toStringAsFixed(6)}", style: ST.my(18, 600)),
                        Text(
                          " EGLD",
                          style:
                              ST.my(18, 600, color: const Color(0xFF4A55C1)),
                        ),
                        const Spacer(),
                        // Text(
                        //   "Fee: ",
                        //   style:
                        //       ST.my(18, 600, color: const Color(0xFF4A55C1)),
                        // ),
                        // Text("0.0000", style: ST.my(18, 600)),
                      ],
                    ),
                    const Spacer(),
                    BtnGradient(
                      onPressed: isActivityBtn
                          ? () => onSend()
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
          );
        }
      ),
    );
  }
}
