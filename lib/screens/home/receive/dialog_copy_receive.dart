import 'package:flutter/cupertino.dart';

class DialogCopyReceive extends StatelessWidget {
  const DialogCopyReceive({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "Address Copied",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onPressed,
          child: const Text(
            "OK",
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
