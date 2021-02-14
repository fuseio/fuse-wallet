import 'package:auto_route/auto_route.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable(explicitToJson: true)
class Transfer extends Transaction {
  final String receiverName;
  final String note;

  Transfer({
    String txHash,
    String type,
    String status,
    String text,
    String jobId,
    int blockNumber,
    String failReason,
    int timestamp,
    bool isSwap,
    String to,
    String from,
    BigInt value,
    String tokenAddress,
    this.receiverName,
    this.note,
  }) : super(
          timestamp: timestamp,
          txHash: txHash,
          type: type,
          status: status,
          text: text,
          jobId: jobId,
          blockNumber: blockNumber,
          failReason: failReason,
          to: to,
          from: from,
          value: value,
          tokenAddress: tokenAddress,
          isSwap: isSwap ?? false,
        );

  Transfer copyWith({
    String status,
    String txHash,
    String text,
    int timestamp,
    String failReason,
  }) {
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
      tokenAddress: this.tokenAddress,
    );
  }

  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);

  Map<String, dynamic> toJson() => _$TransferToJson(this);

  @override
  String getText() {
    if (this.isJoinBonus()) {
      return I18n.of(ExtendedNavigator.root.context).join_bonus ?? text;
    }
    return receiverName ?? text;
  }
}
