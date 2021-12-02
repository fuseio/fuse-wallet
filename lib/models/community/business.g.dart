// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Business _$$_BusinessFromJson(Map<String, dynamic> json) => _$_Business(
      metadata:
          BusinessMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      account: json['account'] as String? ?? '',
      id: json['id'] as String? ?? '',
      area: json['area'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$$_BusinessToJson(_$_Business instance) =>
    <String, dynamic>{
      'metadata': instance.metadata.toJson(),
      'account': instance.account,
      'id': instance.id,
      'area': instance.area,
      'name': instance.name,
    };
