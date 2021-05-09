// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Token _$_$_TokenFromJson(Map<String, dynamic> json) {
  return _$_Token(
    address: json['address'] as String?,
    name: json['name'] as String?,
    isNative: json['isNative'] as bool? ?? false,
    symbol: json['symbol'] as String?,
    imageUrl: json['imageUrl'] as String?,
    decimals: json['decimals'] as int?,
    amount:
        json['amount'] == null ? null : BigInt.parse(json['amount'] as String),
    timestamp: json['timestamp'] as int?,
    priceInfo: json['priceInfo'] == null
        ? null
        : Price.fromJson(json['priceInfo'] as Map<String, dynamic>),
    communityAddress: json['communityAddress'] as String?,
    originNetwork: json['originNetwork'] as String?,
    priceChange: json['priceChange'] as num?,
    stats: (json['stats'] as List<dynamic>?)
        ?.map((e) => Stats.fromJson(e as Map<String, dynamic>))
        .toList(),
    walletActions:
        walletActionsFromJson(json['walletActions'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_TokenToJson(_$_Token instance) => <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'isNative': instance.isNative,
      'symbol': instance.symbol,
      'imageUrl': instance.imageUrl,
      'decimals': instance.decimals,
      'amount': instance.amount?.toString(),
      'timestamp': instance.timestamp,
      'priceInfo': instance.priceInfo?.toJson(),
      'communityAddress': instance.communityAddress,
      'originNetwork': instance.originNetwork,
      'priceChange': instance.priceChange,
      'stats': instance.stats?.map((e) => e.toJson()).toList(),
      'walletActions': instance.walletActions?.toJson(),
    };
