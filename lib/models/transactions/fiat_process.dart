import 'package:fusecash/models/transactions/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fiat_process.g.dart';

@JsonSerializable(explicitToJson: true)
class FiatProcess extends Transaction {
  FiatProcess({
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

  FiatProcess copyWith({
    String status,
    String txHash,
    String text,
    int timestamp,
    String failReason,
    String actionType,
  }) {
    return FiatProcess(
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
  bool isFiatProccesing() => true;

  @override
  String getText() {
    if (isFailed()) {
      return 'Payment faild';
    } else if (isConfirmed()) {
      return 'Payment Done';
    } else {
      return 'Waiting for payment';
    }
  }

  factory FiatProcess.fromJson(Map<String, dynamic> json) =>
      _$FiatProcessFromJson(json);

  Map<String, dynamic> toJson() => _$FiatProcessToJson(this);
}
