import 'package:fusecash/models/transactions/transactions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(explicitToJson: true)
class Token {
  final String address;
  final String name;
  final String symbol;
  final String imageUrl;
  final int decimals;
  final num amount;
  @JsonKey(fromJson: _transactionsFromJson)
  final Transactions transactions;

  static Transactions _transactionsFromJson(Map<String, dynamic> json) =>
      json == null ? Transactions.initial() : Transactions.fromJson(json);

  Token(
      {this.address,
      this.name,
      this.symbol,
      this.decimals,
      this.amount,
      this.imageUrl,
      this.transactions});

  Token copyWith({
    String address,
    String name,
    String symbol,
    String imageUrl,
    int decimals,
    num amount,
    Transactions transactions
  }) {
    return Token(
        address: address ?? this.address,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        imageUrl: imageUrl ?? this.imageUrl,
        decimals: decimals ?? this.decimals,
        amount: amount ?? this.amount,
        transactions: transactions ?? this.transactions,);
  }

  factory Token.initial() {
    return new Token(
        address: '',
        imageUrl: null,
        name: '',
        amount: 0,
        decimals: 0,
        symbol: '',
        transactions: Transactions.initial());
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
