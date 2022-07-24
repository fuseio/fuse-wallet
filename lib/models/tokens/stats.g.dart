// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IntervalStats _$$_IntervalStatsFromJson(Map<String, dynamic> json) =>
    _$_IntervalStats(
      timestamp: json['timestamp'] as num,
      priceChange: (json['priceChange'] as num).toDouble(),
      previousPrice: (json['previousPrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$_IntervalStatsToJson(_$_IntervalStats instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'priceChange': instance.priceChange,
      'previousPrice': instance.previousPrice,
      'currentPrice': instance.currentPrice,
    };
