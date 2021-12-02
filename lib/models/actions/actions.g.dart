// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletActions _$$_WalletActionsFromJson(Map<String, dynamic> json) =>
    _$_WalletActions(
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => WalletAction.fromJson(e))
              .toList() ??
          [],
      updatedAt: json['updatedAt'] as num? ?? 0,
      currentPage: json['currentPage'] as int? ?? 1,
    );

Map<String, dynamic> _$$_WalletActionsToJson(_$_WalletActions instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
      'updatedAt': instance.updatedAt,
      'currentPage': instance.currentPage,
    };
