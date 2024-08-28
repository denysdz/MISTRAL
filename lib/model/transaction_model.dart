class Transaction {
  final String txHash;
  final int gasLimit;
  final int gasPrice;
  final int gasUsed;
  final String miniBlockHash;
  final int nonce;
  final String receiver;
  final int receiverShard;
  final int round;
  final String sender;
  final int senderShard;
  final String signature;
  final String status;
  final String value;
  final String fee;
  final int timestamp;
  final String function;

  Transaction({
    required this.txHash,
    required this.gasLimit,
    required this.gasPrice,
    required this.gasUsed,
    required this.miniBlockHash,
    required this.nonce,
    required this.receiver,
    required this.receiverShard,
    required this.round,
    required this.sender,
    required this.senderShard,
    required this.signature,
    required this.status,
    required this.value,
    required this.fee,
    required this.timestamp,
    required this.function,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      txHash: json['txHash'],
      gasLimit: json['gasLimit'],
      gasPrice: json['gasPrice'],
      gasUsed: json['gasUsed'],
      miniBlockHash: json['miniBlockHash'],
      nonce: json['nonce'],
      receiver: json['receiver'],
      receiverShard: json['receiverShard'],
      round: json['round'],
      sender: json['sender'],
      senderShard: json['senderShard'],
      signature: json['signature'],
      status: json['status'],
      value: json['value'],
      fee: json['fee'],
      timestamp: json['timestamp'],
      function: json['function'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'txHash': txHash,
      'gasLimit': gasLimit,
      'gasPrice': gasPrice,
      'gasUsed': gasUsed,
      'miniBlockHash': miniBlockHash,
      'nonce': nonce,
      'receiver': receiver,
      'receiverShard': receiverShard,
      'round': round,
      'sender': sender,
      'senderShard': senderShard,
      'signature': signature,
      'status': status,
      'value': value,
      'fee': fee,
      'timestamp': timestamp,
      'function': function,
    };
  }
}
