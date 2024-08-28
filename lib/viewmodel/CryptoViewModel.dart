import 'dart:async';
import 'package:elrond/settings/param.dart';
import 'package:elrond/storage/SharedPreferencesUtil.dart';
import 'package:elrond/wallet/WalletUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoViewModel extends ChangeNotifier {
  double? elrondPrice;
  double? elrondPercent;
  double? balance;
  double? usd;
  Timer? timer;

  CryptoViewModel() {
    startFetching();
  }

  Future<void> _fetchCurrentBalance() async {
    try {
      var phrase = PARAM.user?.phrase;
      if (phrase == null) throw Exception("User not authenticated");

      var fetchedBalance = await WalletUtils().getBalance(phrase);
      String balanceString = fetchedBalance.toString().trim();
      double balance;

      try {
        balance = parseBalance(balanceString);
      } catch (e) {
        balance = 0.0;
      }

      if (elrondPrice != null) {
        usd = balance * elrondPrice!;
      } else {
        usd = 0.0;
      }

      if (this.balance != balance) {
        this.balance = balance;
        notifyListeners(); // Сповіщення слухачів про зміни
      }
    } catch (error) {
      print('Error fetching balance: $error');
    }
  }

  double parseBalance(String balanceString) {
    try {
      String cleanedString = balanceString.replaceAll(RegExp(r'[^0-9.]'), '').trim();
      return double.parse(cleanedString);
    } catch (e) {
      print('Error parsing balance to double: $e');
      return 0.0;
    }
  }

  Future<void> _fetchElrondPrice() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.coingecko.com/api/v3/simple/price?ids=elrond-erd-2&vs_currencies=usd&include_24hr_change=true'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double? newPrice = data['elrond-erd-2']['usd'];
        double? newPercent = data['elrond-erd-2']['usd_24h_change'];

        if (elrondPrice != newPrice || elrondPercent != newPercent) {
          elrondPrice = newPrice;
          elrondPercent = newPercent;

          if (balance != null) {
            usd = balance! * elrondPrice!;
          } else {
            usd = 0.0;
          }
          notifyListeners(); // Сповіщення слухачів про зміни
        }
      } else {
        throw Exception('Failed to load price');
      }
    } catch (error) {
      print('Error fetching price: $error');
    }
  }

  Future<void> startFetching() async {
    _fetchElrondPrice();
    _fetchCurrentBalance();
    timer = Timer.periodic(Duration(minutes: 1), (timer) async{
       _fetchCurrentBalance();
       _fetchElrondPrice();
    });
  }

  void stopFetching() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
