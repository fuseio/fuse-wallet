import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable()
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

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);

  Map<String, dynamic> toJson() => _$TransferToJson(this);
}

@JsonSerializable()
class PendingTransfer extends Transfer {
  final String jobId;

  PendingTransfer({
    String to,
    String from,
    BigInt value,
    String txHash,
    String tokenAddress,
    String type,
    this.jobId
  }) : super(to: to, from: from, value: value, txHash: txHash, tokenAddress: tokenAddress, type: type);

  factory PendingTransfer.fromJson(Map<String, dynamic> json) => _$PendingTransferFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTransferToJson(this);
}