import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

String funderAddress = DotEnv().env['FUNDER_ADDRESS'];

@JsonSerializable(explicitToJson: true)
class Transaction {
  final String txHash;
  final String type;
  String status;
  final String text;
  final int blockNumber;
  final String jobId;

  Transaction(
      {this.txHash,
      this.type,
      this.status,
      this.text,
      this.blockNumber,
      this.jobId});

  Transaction copyWith({String status}) {
    return Transaction(
        txHash: this.txHash,
        type: this.type,
        status: status ?? this.status,
        text: this.text,
        blockNumber: this.blockNumber,
        jobId: this.jobId);
  }

  bool isPending() => this.status == 'PENDING';
  bool isFailed() => this.status == 'FAILED';
  bool isConfirmed() => this.status == 'CONFIRMED';

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}


class TransactionFactory {
  static fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'RECEIVE' || json['type'] == 'SEND') {
      return Transfer.fromJson(json);
    }
    return Transaction.fromJson(json);
  }
}

