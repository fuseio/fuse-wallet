import 'package:peepl/models/transactions/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fiat_deposit.g.dart';

@JsonSerializable(explicitToJson: true)
class FiatDeposit extends Transaction {
  FiatDeposit({
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
    String actionType,
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
          actionType: actionType,
          isSwap: isSwap ?? false,
        );

  FiatDeposit copyWith({
    String status,
    String txHash,
    String text,
    int timestamp,
    String failReason,
  }) {
    return FiatDeposit(
      isSwap: this.isSwap,
      txHash: txHash ?? this.txHash,
      type: this.type,
      timestamp: timestamp ?? this.timestamp,
      failReason: failReason ?? this.failReason,
      status: status ?? this.status,
      text: text ?? this.text,
      blockNumber: this.blockNumber,
      jobId: this.jobId,
      tokenAddress: this.tokenAddress,
      from: this.from,
      to: this.to,
      value: this.value,
      actionType: this.actionType,
    );
  }

  @override
  String getText() {
    if (isFailed()) {
      return 'FUSD - deposit failed';
    } else if (isConfirmed()) {
      return 'FUSD - deposit';
    } else {
      return 'Waiting for your deposit to arrive';
    }
  }

  factory FiatDeposit.fromJson(Map<String, dynamic> json) =>
      _$FiatDepositFromJson(json);

  Map<String, dynamic> toJson() => _$FiatDepositToJson(this);
}
