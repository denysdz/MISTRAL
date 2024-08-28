import 'dart:async'; // Import the Timer class
import 'dart:convert';
import 'package:elrond/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionViewModel extends ChangeNotifier {
  List<Transaction> _transactionsSend = [];
  List<Transaction> _transactionsReceive = [];
  bool _isLoadingSend = true;
  bool _isLoadingReceive = true;
  String? _errorMessage;
  Timer? timer = null;

  List<Transaction> get transactionsSend => _transactionsSend;
  List<Transaction> get transactionsReceive => _transactionsReceive;
  bool get isLoadingSend => _isLoadingSend;
  bool get isLoadingReceive => _isLoadingReceive;
  String? get errorMessage => _errorMessage;

  // Private method to fetch transactions from the API
  Future<void> _fetchTransactions(String endpoint, String address, bool isSend) async {
    final url = Uri.parse('https://api.multiversx.com/transactions?from=0&${endpoint}=${address}');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final transactions = jsonData.map((json) => Transaction.fromJson(json)).toList();

        if (isSend) {
          _transactionsSend = transactions;
          _isLoadingSend = false;
        } else {
          _transactionsReceive = transactions;
          _isLoadingReceive = false;
        }
      } else {
        _errorMessage = 'Failed to load transactions';
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }
  }


  // Method to start fetching transactions every 10 seconds
  void startFetchingTransactions(String address) {
    _fetchTransactions("sender", address, true);
    _fetchTransactions("receiver", address, false);
    timer = Timer.periodic(const Duration(seconds: 10), (_) {
        _fetchTransactions("sender", address, true);
        _fetchTransactions("receiver", address, false);
    });
  }

  // Method to stop fetching transactions
  void stopSend() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
