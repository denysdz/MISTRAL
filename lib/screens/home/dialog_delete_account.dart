import 'package:elrond/screens/start/start_first_screen.dart';
import 'package:elrond/screens/start/start_third_screen.dart';
import 'package:elrond/settings/param.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogDeleteAccount extends StatelessWidget {
  const DialogDeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "Delete Account",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      content: const Text(
        "Do you really want to delete your account?",
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
            PARAM.user = null;
            PARAM.tempUser = null;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const StartThirdScreen()),
              (_) => false,
            );
          },
          isDestructiveAction: true,
          child: const Text(
            "Delete",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
