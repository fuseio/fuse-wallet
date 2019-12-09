class Transfer {
  final String to;
  final String from;
  final BigInt value;
  final String tokenAddress;
  final String txHash;
  final String type;

  Transfer({
    this.to,
    this.from,
    this.value,
    this.txHash,
    this.tokenAddress,
    this.type
  });

  static Transfer fromJson(json) => new Transfer(
    to: json['to'],
    from: json['from'],
    value: json['value'],
    txHash: json['txHash'],
    tokenAddress: json['tokenAddress'],
    type: json['type']
  );
}