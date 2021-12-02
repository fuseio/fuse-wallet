// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_bonus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JoinBonusPlugin _$$_JoinBonusPluginFromJson(Map<String, dynamic> json) =>
    _$_JoinBonusPlugin(
      type: json['type'] as String? ?? 'joinBonus',
      amount: json['amount'] as String?,
      name: json['name'] as String?,
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$_JoinBonusPluginToJson(_$_JoinBonusPlugin instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'name': instance.name,
      'isActive': instance.isActive,
    };
