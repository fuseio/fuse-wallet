// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_bonus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BackupBonusPlugin _$$_BackupBonusPluginFromJson(Map<String, dynamic> json) =>
    _$_BackupBonusPlugin(
      type: json['type'] as String? ?? 'backupBonus',
      amount: json['amount'] as String?,
      name: json['name'] as String?,
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$_BackupBonusPluginToJson(
        _$_BackupBonusPlugin instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'name': instance.name,
      'isActive': instance.isActive,
    };
