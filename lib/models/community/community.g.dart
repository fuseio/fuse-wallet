// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Community _$_$_CommunityFromJson(Map<String, dynamic> json) {
  return _$_Community(
    name: json['name'] as String,
    address: json['address'] as String,
    isMultiBridge: json['isMultiBridge'] as bool ?? false,
    isClosed: json['isClosed'] as bool ?? false,
    isMember: json['isMember'] as bool ?? false,
    homeTokenAddress: json['homeTokenAddress'] as String,
    metadata: json['metadata'] == null
        ? null
        : CommunityMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    webUrl: json['webUrl'] as String,
    bridgeType: json['bridgeType'] as String,
    bridgeDirection: json['bridgeDirection'] as String,
    homeBridgeAddress: json['homeBridgeAddress'] as String,
    foreignBridgeAddress: json['foreignBridgeAddress'] as String,
    foreignTokenAddress: json['foreignTokenAddress'] as String,
    plugins: pluginsFromJson(json['plugins']),
    businesses: (json['businesses'] as List)
        ?.map((e) =>
            e == null ? null : Business.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$_$_CommunityToJson(_$_Community instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'address': instance.address,
    'isMultiBridge': instance.isMultiBridge,
    'isClosed': instance.isClosed,
    'isMember': instance.isMember,
    'homeTokenAddress': instance.homeTokenAddress,
    'metadata': instance.metadata?.toJson(),
    'webUrl': instance.webUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bridgeType', instance.bridgeType);
  writeNotNull('bridgeDirection', instance.bridgeDirection);
  writeNotNull('homeBridgeAddress', instance.homeBridgeAddress);
  writeNotNull('foreignBridgeAddress', instance.foreignBridgeAddress);
  writeNotNull('foreignTokenAddress', instance.foreignTokenAddress);
  writeNotNull('plugins', instance.plugins?.toJson());
  writeNotNull(
      'businesses', instance.businesses?.map((e) => e?.toJson())?.toList());
  val['description'] = instance.description;
  return val;
}
