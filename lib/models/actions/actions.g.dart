// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletActions _$_$_WalletActionsFromJson(Map<String, dynamic> json) {
  return _$_WalletActions(
    list: listFromJson(json['list'] as Map<String, dynamic>),
    updatedAt: json['updatedAt'] as num ?? 0,
  );
}

Map<String, dynamic> _$_$_WalletActionsToJson(_$_WalletActions instance) =>
    <String, dynamic>{
      'list': listToJson(instance.list),
      'updatedAt': instance.updatedAt,
    };
