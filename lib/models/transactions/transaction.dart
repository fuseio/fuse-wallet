import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction extends Equatable {
  final String tokenAddress;
  final String txHash;
  final int timestamp;
  final String type;
  final String status;
  final String text;
  final int blockNumber;
  final String jobId;
  final String to;
  final String from;
  final BigInt value;
  final bool isSwap;
  final String failReason;
  final String actionType;

  String getText() => text;

  bool isFiatProccesing() => false;

  @override
  List<Object> get props => [txHash, status, timestamp, failReason, jobId];

  Transaction({
    this.txHash,
    this.type,
    this.isSwap = false,
    this.status,
    this.text,
    this.blockNumber,
    this.timestamp,
    this.jobId,
    this.failReason,
    this.tokenAddress,
    this.from,
    this.to,
    this.value,
    this.actionType,
  });

  Transaction copyWith({
    String status,
    String txHash,
    String text,
    int timestamp,
    String failReason,
  }) {
    return Transaction(
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

  bool isPending() => this.status == 'PENDING';
  bool isFailed() => this.status == 'FAILED';
  bool isConfirmed() => this.status == 'CONFIRMED';

  bool isJoinBonus() =>
      this.from != null &&
      this.from?.toLowerCase() == DotEnv().env['FUNDER_ADDRESS'];
  bool isGenerateWallet() =>
      this.jobId != null && this.jobId == 'generateWallet';
  bool isJoinCommunity() => this.text != null && this.text.contains('Join');

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
