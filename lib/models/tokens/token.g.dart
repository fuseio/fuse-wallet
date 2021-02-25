// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Token _$_$_TokenFromJson(Map<String, dynamic> json) {
  return _$_Token(
    address: json['address'] as String,
    name: json['name'] as String,
    symbol: json['symbol'] as String,
    imageUrl: json['imageUrl'] as String,
    decimals: json['decimals'] as int,
    amount:
        json['amount'] == null ? null : BigInt.parse(json['amount'] as String),
    timestamp: json['timestamp'] as int,
    priceInfo: json['priceInfo'] == null
        ? null
        : Price.fromJson(json['priceInfo'] as Map<String, dynamic>),
    transactions:
        transactionsFromJson(json['transactions'] as Map<String, dynamic>),
    communityAddress: json['communityAddress'] as String,
    originNetwork: json['originNetwork'] as String,
  );
}

Map<String, dynamic> _$_$_TokenToJson(_$_Token instance) => <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'imageUrl': instance.imageUrl,
      'decimals': instance.decimals,
      'amount': instance.amount?.toString(),
      'timestamp': instance.timestamp,
      'priceInfo': instance.priceInfo?.toJson(),
      'transactions': instance.transactions?.toJson(),
      'communityAddress': instance.communityAddress,
      'originNetwork': instance.originNetwork,
    };
