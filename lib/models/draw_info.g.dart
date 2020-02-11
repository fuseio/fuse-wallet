// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrawInfo _$DrawInfoFromJson(Map<String, dynamic> json) {
  return DrawInfo(
    endTimestamp: json['endTimestamp'] as int,
    reward: json['reward'] as Map<String, dynamic>,
    blockNumber: json['blockNumber'] as int,
    possibleWinnersCount: json['possibleWinnersCount'] as int,
    previous: json['previous'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$DrawInfoToJson(DrawInfo instance) => <String, dynamic>{
      'endTimestamp': instance.endTimestamp,
      'reward': instance.reward,
      'blockNumber': instance.blockNumber,
      'possibleWinnersCount': instance.possibleWinnersCount,
      'previous': instance.previous,
    };
