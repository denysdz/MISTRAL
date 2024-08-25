import 'package:elrond/multiversx.dart';
import 'package:elrond/src/models/request/vm_values/vm_values.dart';
import 'package:elrond/src/models/response/response.dart';
import 'package:elrond/src/models/response/transaction/transaction.dart';

abstract class IProvider {
  const IProvider();

  Future<Account> getAccount(Address address);

  Future<NetworkConfiguration> getNetworkConfiguration();

  Future<TransactionHash> sendTransaction(Transaction transaction);

  Future<TransactionStatus> getTransactionStatus(
      TransactionHash transactionHash);

  Future<GetTransactionInformationsWithSmartContractResultData>
      getTransactionInformationsWithResults(
    TransactionHash transactionHash,
  );

  Future<VmValuesQuery> vmValuesQuery(VmValuesRequest request);
}

abstract class ISignable {
  List<int> serializeForSigning(Address signedBy);

  Transaction applySignature(Signature signature, Address signedBy);
}

abstract class ISigner {
  const ISigner();

  Address getAddress();

  Transaction sign(ISignable signable);
}
