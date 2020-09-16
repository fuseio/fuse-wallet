import 'package:esol/models/transactions/transaction.dart';
import 'package:esol/utils/addresses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable(explicitToJson: true)
class Transfer extends Transaction {
  final String to;
  final String from;
  final BigInt value;
  final String tokenAddress;
  final String receiverName;
  final String note;

  Transfer(
      {String txHash,
      String type,
      String status,
      String text,
      String jobId,
      int blockNumber,
      String failReason,
      int timestamp,
      bool isSwap,
      this.to,
      this.from,
      this.value,
      this.tokenAddress,
      this.receiverName,
      this.note})
      : super(
            timestamp: timestamp,
            txHash: txHash,
            type: type,
            status: status,
            text: text,
            jobId: jobId,
            blockNumber: blockNumber,
            isSwap: isSwap ?? false);

  bool isJoinBonus() =>
      this.from != null && funderAddresses.containsValue(this.from);
  bool isGenerateWallet() =>
      this.jobId != null && this.jobId == 'generateWallet';
  bool isJoinCommunity() => this.text != null && this.text.contains('Join');

  Transfer copyWith(
      {String status,
      String txHash,
      String text,
      int timestamp,
      String failReason}) {
    return Transfer(
        failReason: failReason ?? this.failReason,
        isSwap: this.isSwap,
        note: note ?? this.note,
        receiverName: receiverName ?? this.receiverName,
        txHash: txHash ?? this.txHash,
        type: this.type,
        status: status ?? this.status,
        text: text ?? this.text,
        jobId: this.jobId,
        blockNumber: this.blockNumber,
        timestamp: timestamp ?? this.timestamp,
        to: this.to,
        from: this.from,
        value: this.value,
        tokenAddress: this.tokenAddress);
  }

  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);

  Map<String, dynamic> toJson() => _$TransferToJson(this);
}

class TransactionFactory {
  static fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'RECEIVE' || json['type'] == 'SEND') {
      return Transfer.fromJson(json);
    }
    return Transaction.fromJson(json);
  }
}
