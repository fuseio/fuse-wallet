import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  final String address;
  final String name;
  final String symbol;
  final int decimals;

  Token({
    this.address,
    this.name,
    this.symbol,
    this.decimals
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

}