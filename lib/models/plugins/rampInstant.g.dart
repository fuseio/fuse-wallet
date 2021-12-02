// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rampInstant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RampInstantPlugin _$$_RampInstantPluginFromJson(Map<String, dynamic> json) =>
    _$_RampInstantPlugin(
      name: json['name'] as String? ?? 'rampInstant',
      widgetUrl: json['widgetUrl'] as String?,
      type: json['type'] as String? ?? 'deposit',
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$_RampInstantPluginToJson(
        _$_RampInstantPlugin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'widgetUrl': instance.widgetUrl,
      'type': instance.type,
      'isActive': instance.isActive,
    };
