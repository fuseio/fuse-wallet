// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Stats _$_$_StatsFromJson(Map<String, dynamic> json) {
  return _$_Stats(
    volume: json['volume'] as String?,
    price: json['price'] as String?,
    timestamp: json['timestamp'] as int?,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$_$_StatsToJson(_$_Stats instance) => <String, dynamic>{
      'volume': instance.volume,
      'price': instance.price,
      'timestamp': instance.timestamp,
      'date': instance.date?.toIso8601String(),
    };
