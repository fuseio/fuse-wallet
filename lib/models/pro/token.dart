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

  Token({
    this.address,
    this.name,
    this.symbol,
    this.decimals,
    this.amount,
    this.imageUrl
  });

  factory Token.initial() {
    return new Token(
      address: '',
      imageUrl: null,
      name: '',
      amount: 0,
      decimals: 0,
      symbol: ''
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

}