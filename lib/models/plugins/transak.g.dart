// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransakPlugin _$$_TransakPluginFromJson(Map<String, dynamic> json) =>
    _$_TransakPlugin(
      name: json['name'] as String? ?? 'transak',
      widgetUrl: json['widgetUrl'] as String?,
      type: json['type'] as String? ?? 'deposit',
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TransakPluginToJson(_$_TransakPlugin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'widgetUrl': instance.widgetUrl,
      'type': instance.type,
      'isActive': instance.isActive,
    };
