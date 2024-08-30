import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DialogCode extends StatelessWidget {
  final String address;
  const DialogCode(this.address, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "QR-Code\nYour address in the Elrond network",
        textAlign: TextAlign.center, // Center the title text
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Padding(
        padding: EdgeInsets.all(7.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimize the height of the column
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
          children: [
            SizedBox(
              width: 200.h,  // Adjust width according to your requirements
              height: 200.h, // Adjust height according to your requirements
              child: QrImageView(
                data: address,
                version: QrVersions.auto,
                size: 200.0,
                gapless: false,
              ),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
