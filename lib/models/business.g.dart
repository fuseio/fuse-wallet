// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return Business(
    account: json['account'] as String,
    id: json['id'] as String,
    metadata: Business._businessMetadataFromJson(
        json['metadata'] as Map<String, dynamic>),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'account': instance.account,
      'id': instance.id,
      'name': instance.name,
      'metadata': Business._businessMetadataToJson(instance.metadata),
    };
