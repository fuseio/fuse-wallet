import 'package:fusecash/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transactions.g.dart';

@JsonSerializable(explicitToJson: true)
class Transactions {
  @JsonKey(name: 'list', fromJson: _listFromJson, toJson: _listToJson)
  final List<Transaction> list;
  @JsonKey(ignore: true)
  final Map<String, Transaction> invites;
  final num blockNumber;

  Transactions({this.list, this.invites, this.blockNumber = 0});

  Transactions copyWith(
      {List<Transaction> list,
      Map<String, Transaction> invites,
      num blockNumber}) {
    return Transactions(
        list: list ?? this.list,
        invites: invites ?? this.invites,
        blockNumber: blockNumber ?? this.blockNumber);
  }

  static List<Transaction> _listFromJson(Map<String, dynamic> json) =>
    List<Transaction>.from(json['list'].map((transaction) => TransactionFactory.fromJson(transaction)));

  static Map<String, dynamic> _listToJson(List<Transaction> list) =>
      new Map.from(
          {'list': list.map((transaction) => transaction.toJson()).toList()});

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        list: List<Transaction>.from(json['list']
            .map((transaction) => TransactionFactory.fromJson(transaction))),
        blockNumber: json['blockNumber'],
        // list: new List<Transaction>(),
        // blockNumber: 0
      );

  Map<String, dynamic> toJson() => {
        'list': list.map((transaction) => transaction.toJson()).toList(),
        'blockNumber': blockNumber
      };

  // factory Transactions.fromJson(Map<String, dynamic> json) =>
  //     _$TransactionsFromJson(json);

  // Map<String, dynamic> toJson() => _$TransactionsToJson(this);
}
