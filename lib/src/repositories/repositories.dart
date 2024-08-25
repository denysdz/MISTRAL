import 'package:elrond/multiversx.dart';
import 'package:elrond/src/models/response/response.dart';

class Repositories {
  final AddressRepository address;
  final TransactionRepository transaction;

  const Repositories({required this.address, required this.transaction});
}

class ApiException implements Exception {
  final ProxyResponseGeneric response;

  const ApiException(this.response);
}
