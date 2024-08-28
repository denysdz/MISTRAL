import 'package:flutter/cupertino.dart';

class DialogConfirmSend extends StatelessWidget {
  final String address;
  final String amount;
  final String fee;
  final VoidCallback onConfirm;

  const DialogConfirmSend({
    required this.address,
    required this.amount,
    required this.fee,
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        'Confirm Transaction',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Address: $address',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8), // Space between lines
          Text(
            'Amount: $amount EGLD',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8), // Space between lines
          Text(
            'Transaction fee: $fee EGLD',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            onConfirm(); // Call the confirm callback
          },
          child: const Text(
            "Confirm",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF007AFF),
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context), // Close the dialog
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF007AFF),
            ),
          ),
        ),
      ],
    );
  }
}
