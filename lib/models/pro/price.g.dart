// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
    currency: json['currency'] as String,
    quote: json['quote'] as String,
    total: json['total'] as String,
  );
}

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'currency': instance.currency,
      'quote': instance.quote,
      'total': instance.total,
    };
