// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Token _$$_TokenFromJson(Map<String, dynamic> json) => _$_Token(
      address: json['address'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      amount: BigInt.parse(json['amount'] as String),
      decimals: json['decimals'] as int,
      isNative: json['isNative'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
      timestamp: json['timestamp'] as int?,
      priceInfo: json['priceInfo'] == null
          ? null
          : Price.fromJson(json['priceInfo'] as Map<String, dynamic>),
      communityAddress: json['communityAddress'] as String?,
      originNetwork: json['originNetwork'] as String?,
      priceChange: json['priceChange'] as num? ?? 0,
      walletActions:
          walletActionsFromJson(json['walletActions'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_TokenToJson(_$_Token instance) => <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'amount': instance.amount.toString(),
      'decimals': instance.decimals,
      'isNative': instance.isNative,
      'imageUrl': instance.imageUrl,
      'timestamp': instance.timestamp,
      'priceInfo': instance.priceInfo?.toJson(),
      'communityAddress': instance.communityAddress,
      'originNetwork': instance.originNetwork,
      'priceChange': instance.priceChange,
      'walletActions': instance.walletActions?.toJson(),
    };
