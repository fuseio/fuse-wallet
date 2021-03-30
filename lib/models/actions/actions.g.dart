// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletActions _$_$_WalletActionsFromJson(Map<String, dynamic> json) {
  return _$_WalletActions(
    list: (json['list'] as List)
        ?.map((e) => e == null ? null : WalletAction.fromJson(e))
        ?.toList(),
    updatedAt: json['updatedAt'] as num ?? 0,
  );
}

Map<String, dynamic> _$_$_WalletActionsToJson(_$_WalletActions instance) =>
    <String, dynamic>{
      'list': instance.list?.map((e) => e?.toJson())?.toList(),
      'updatedAt': instance.updatedAt,
    };
