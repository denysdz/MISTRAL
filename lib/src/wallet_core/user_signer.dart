import 'package:elrond/multiversx.dart';

class UserSigner extends ISigner {
  final UserSecretKey secretKey;

  const UserSigner(this.secretKey);

  @override
  Address getAddress() => secretKey.generatePublicKey().toAddress();

  @override
  Transaction sign(ISignable signable) {
    final signedBy = getAddress();
    final bytesToSign = signable.serializeForSigning(signedBy);
    final signatureBytes = secretKey.sign(bytesToSign);
    final signature = Signature.fromBytes(signatureBytes);
    return signable.applySignature(signature, signedBy);
  }
}
