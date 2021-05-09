// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moonpay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoonpayPlugin _$_$_MoonpayPluginFromJson(Map<String, dynamic> json) {
  return _$_MoonpayPlugin(
    name: json['name'] as String,
    widgetUrl: json['widgetUrl'] as String,
    type: json['type'] as String? ?? 'deposit',
    isActive: json['isActive'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_MoonpayPluginToJson(_$_MoonpayPlugin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'widgetUrl': instance.widgetUrl,
      'type': instance.type,
      'isActive': instance.isActive,
    };
