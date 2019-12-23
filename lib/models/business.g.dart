// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return Business(
    account: json['account'] as String,
    metadata: json['metadata'] == null
        ? null
        : BusinessMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'account': instance.account,
      'id': instance.id,
      'name': instance.name,
      'metadata': instance.metadata,
    };
