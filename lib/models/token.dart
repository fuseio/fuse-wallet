import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(explicitToJson: true)
class Token {
  final String address;
  final String name;
  final String symbol;
  final int decimals;
  final String originNetwork;

  Token({
    this.address,
    this.name,
    this.symbol,
    this.decimals,
    this.originNetwork
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

}