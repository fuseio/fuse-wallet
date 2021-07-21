// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Price _$_$_PriceFromJson(Map<String, dynamic> json) {
  return _$_Price(
    currency: json['currency'] as String? ?? 'usd',
    quote: json['quote'] as String? ?? '0',
  );
}

Map<String, dynamic> _$_$_PriceToJson(_$_Price instance) => <String, dynamic>{
      'currency': instance.currency,
      'quote': instance.quote,
    };
