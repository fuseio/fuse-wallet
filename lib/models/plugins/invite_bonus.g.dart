// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_bonus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InviteBonusPlugin _$_$_InviteBonusPluginFromJson(Map<String, dynamic> json) {
  return _$_InviteBonusPlugin(
    type: json['type'] as String? ?? 'inviteBonus',
    amount: json['amount'] as String?,
    name: json['name'] as String?,
    isActive: json['isActive'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_InviteBonusPluginToJson(
        _$_InviteBonusPlugin instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'name': instance.name,
      'isActive': instance.isActive,
    };
