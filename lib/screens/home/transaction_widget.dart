import 'package:elrond/screens/transaction_item.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/wallet/WalletUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elrond/widgets/logo_image.dart';
import 'package:elrond/settings/st.dart';
import 'package:provider/provider.dart';
import 'package:elrond/viewmodel/TransactionViewModel.dart';

class TransactionContainer extends StatefulWidget {
  final bool isSend;

  const TransactionContainer({Key? key, required this.isSend}) : super(key: key);

  @override
  _TransactionContainerState createState() => _TransactionContainerState();
}

class _TransactionContainerState extends State<TransactionContainer> {
  late TransactionViewModel viewModel;
  late final AppLifecycleListener _listener;

 String extractAddress(String addr) {
    RegExp regExp = RegExp(r'Address\{\s*(.*?)\s*\}');
    Match? match = regExp.firstMatch(addr);
    if (match != null) {
      return match.group(1)!;
    }
    return '';
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.timer == null) {
          viewModel.startFetchingTransactions(extractAddress(PARAM.user!.address));
        }
        if ((widget.isSend && viewModel.isLoadingSend) || (!widget.isSend && viewModel.isLoadingReceive)) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF4A55C1)));
        } if ((widget.isSend && viewModel.transactionsSend.isEmpty) || (!widget.isSend && viewModel.transactionsReceive.isEmpty)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoImage(widget.isSend ? "logo_send" : "logo_receive"),
              SizedBox(height: 15.h),
              Text(
                widget.isSend
                    ? "Send transactions are not found"
                    : "Receive transactions are not found",
                style: ST.my(14, 600, color: const Color(0xFF958A8A)),
              ),
            ],
          );
        } else {
          // Ensure Expanded is inside a Column or Row
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.isSend == true ? viewModel.transactionsSend.length : viewModel.transactionsReceive.length,
                    itemBuilder: (context, index) {
                      final transaction = widget.isSend == true ? viewModel.transactionsSend[index] : viewModel.transactionsReceive[index];
                      return TransactionItem(
                        txHash: transaction.txHash,
                        amount: transaction.value,
                        isSended: widget.isSend,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
