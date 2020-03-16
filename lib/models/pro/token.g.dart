// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    address: json['address'] as String,
    name: json['name'] as String,
    symbol: json['symbol'] as String,
    decimals: json['decimals'] as int,
    amount: json['amount'] as num,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'imageUrl': instance.imageUrl,
      'decimals': instance.decimals,
      'amount': instance.amount,
    };
