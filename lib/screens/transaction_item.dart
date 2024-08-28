import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionItem extends StatelessWidget {
  final String txHash;
  final String amount;
  final bool isSended;

  const TransactionItem({
    Key? key,
    required this.txHash,
    required this.amount,
    required this.isSended,
  }) : super(key: key);

  Future<void> _launchURL() async {
    String url = "https://explorer.multiversx.com/transactions/$txHash";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String correctAmount = amount;
    correctAmount = (double.parse(amount)/1000000000000000000).toStringAsFixed(4);
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        padding: const EdgeInsets.all(8.0), // Adjust for your design
        margin: const EdgeInsets.symmetric(vertical: 4.0), // Adjust for your design
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/ic_received.png',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 10),
            Text(
              isSended == true ? "Sent to:  " : "Received From:  ",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: isSended == true ? const Color(0xFFD42D69) : const Color(0xFF4A55C1),
                decorationThickness: 0.5,
                color: isSended == true ? const Color(0xFFD42D69) : const Color(0xFF4A55C1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Expanded(
              child: Text(
                txHash,
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 0.5,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(width: 10),
            Text(
              !correctAmount.contains("-") ? "+$correctAmount" : correctAmount,
              style: TextStyle(
                color: isSended == true ? const Color(0xFFD42D69) : const Color(0xFF1F93D0),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
