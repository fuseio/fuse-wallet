import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_core/wallet_core.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final String txHash;
  final String type;
  String status;
  final String text;
  final int blockNumber;
  final String jobId;

  Transaction({
    this.txHash,
    this.type,
    this.status,
    this.text,
    this.blockNumber,
    this.jobId
  });

  bool isPending() => this.status == 'PENDING';

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}


@JsonSerializable()
class Transfer extends Transaction {
  final String to;
  final String from;
  final BigInt value;
  final String tokenAddress;

  Transfer({
    String txHash,
    String type,
    String status,
    String text,
    String jobId,
    int blockNumber,
    this.to,
    this.from,
    this.value,
    this.tokenAddress,
  }) : super(txHash: txHash, type: type, status: status, text: text, jobId: jobId, blockNumber: blockNumber);

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);

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

List<Transaction> l = new List<Transaction>();

class Transactions {
  final List<Transaction> list;
  final Map<String, Transaction> invites;
  final num blockNumber;

  Transactions({this.list, this.invites, this.blockNumber = 0});
  

  Transactions copyWith({
    List<Transaction> list,
    Map<String, Transaction> invites,
    num blockNumber
  }) {
    return Transactions(
      list: list ?? this.list,
      invites: invites ?? this.invites,
      blockNumber: blockNumber ?? this.blockNumber
      );
  }

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    // list: List<Transaction>.from(json['list'].map((transaction) => TransactionFactory.fromJson(transaction))),
    list: new List<Transaction>(),
    blockNumber: json['blockNumber'] 
  );
  
  Map<String, dynamic> toJson() => {
    'list': list.map((transaction) => transaction.toJson()).toList(),
    'blockNumber': blockNumber
  };
}