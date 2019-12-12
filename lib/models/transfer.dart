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