import 'dart:async';
import 'dart:ffi';
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
  Timer? _timer;
  Timer? _timer2;

  CryptoViewModel() {
    //_fetchCurrentBalance();
    //_fetchElrondPrice();
    //startFetching();
  }

  Future<void> _fetchCurrentBalance() async {
    try {
      var phrase = PARAM.user?.phrase;
      if (phrase == null) throw Exception("User not authenticated");

      var fetchedBalance = await WalletUtils().getBalance(phrase);

      print("Fetched balance type: ${fetchedBalance.runtimeType}");
      print("Fetched balance value: $fetchedBalance");

      String balanceString = fetchedBalance.toString().trim();
      double balance;
      
      try {
        balance = parseBalance(balanceString);
      } catch (e) {
        print('Error parsing balance to double: $e');
        balance = 0.0;
      }

      if (this.balance != null && elrondPrice != null) {
        double percentAsDecimal = elrondPrice!;

        if (balance != null) {
          usd = balance! * percentAsDecimal;
        } else {
          usd = 0.0;
        }
      } else {
        usd = 0.0;
      }

      this.balance = balance;
      print("Balance: $balance");

      notifyListeners();
    } catch (error) {
      print('Error fetching balance: $error');
    }
  }

  double parseBalance(String balanceString) {
    try {
      String cleanedString = balanceString
          .replaceAll(RegExp(r'[^0-9.]'), '')
          .trim();

      double balance = double.parse(cleanedString);

      return balance;
    } catch (e) {
      print('Error parsing balance to double: $e');
      return 0.0;
    }
  }

  void startFetching() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      _fetchElrondPrice();
    });
    _timer2 = Timer.periodic(Duration(seconds: 3), (timer) {
      _fetchCurrentBalance();
    });
  }

  void stopFetching() {
    _timer?.cancel();
    _timer2?.cancel();
  }

  Future<void> _fetchElrondPrice() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.coingecko.com/api/v3/simple/price?ids=elrond-erd-2&vs_currencies=usd&include_24hr_change=true'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      elrondPrice = data['elrond-erd-2']['usd'];
      elrondPercent = data['elrond-erd-2']['usd_24h_change'];

      // Ensure elrondPercent is not null and is a valid number
      if (elrondPrice != null) {
        // Convert elrondPercent from percentage to decimal
        double percentAsDecimal = elrondPrice!;

        // Ensure balance is not null
        if (balance != null) {
          usd = balance! * percentAsDecimal;
        } else {
          usd = 0.0; // Or handle as needed
        }
      } else {
        usd = 0.0; // Handle case where elrondPercent is null
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load price');
    }
  } catch (error) {
    print('Error fetching price: $error');
  }
}
  

  @override
  void dispose() {
    _timer?.cancel();
     _timer2?.cancel();
    super.dispose();
  }
}
