import 'package:bip39/bip39.dart' as bip39;
import 'package:dio/dio.dart';
import 'package:elrond/multiversx.dart';

class WalletUtils {
  final Dio dio;
  late final ProxyProvider proxy; // Use late final

  WalletUtils() : dio = Dio() {
    // Initialize proxy after dio has been initialized
    proxy = ProxyProvider(
      addressRepository: AddressRepository(dio,
          baseUrl: 'https://gateway.multiversx.com/'),
      networkRepository: NetworkRepository(dio,
          baseUrl: 'https://gateway.multiversx.com/'),
      transactionRepository: TransactionRepository(dio,
          baseUrl: 'https://gateway.multiversx.com/'),
      vmValuesRepository: VmValuesRepository(dio,
          baseUrl: 'https://gateway.multiversx.com'),
    );
  }

  String generateMnemonic() {
    return bip39.generateMnemonic(strength: 256);
  }

  Future<String> getAddress(String mnemonic) async {
    try {
      if (!bip39.validateMnemonic(mnemonic)) throw("Invalid mnemonic");
      var wallet = await Wallet.fromSeed(mnemonic);
      await wallet.synchronize(proxy);
      final address = wallet.account.address.toString();
      return address;
    } catch (e) {
      print('Error generating address. $e');
      rethrow;
    }
  }

  Future<String> getBalance(String mnemonic) async {
    try {
      var wallet = await Wallet.fromSeed(mnemonic);
      await wallet.synchronize(proxy);
      final balance = wallet.account.balance.toString();
      return balance;
    } catch (e) {
      print('Error generating balance. $e');
      rethrow;
    }
  }

  

/*
  Future<List<Transaction>> getTransaction(String mnemonic) async {
    try {
      var wallet = await Wallet.fromSeed(mnemonic);
      final transactions = await proxy.transactionRepository!.getTransactions(wallet.account.address.toString());
      return transactions;
    } catch (e) {
      print('Error fetching transactions. $e');
      rethrow;
    }
  }*/
}
