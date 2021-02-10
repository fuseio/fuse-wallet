// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Community _$_$_CommunityFromJson(Map<String, dynamic> json) {
  return _$_Community(
    name: json['name'] as String,
    address: json['address'] as String,
    plugins: const PluginsConverter()
        .fromJson(json['plugins'] as Map<String, dynamic>),
    businesses: (json['businesses'] as List)
        ?.map((e) =>
            e == null ? null : Business.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isMultiBridge: json['isMultiBridge'] as bool ?? false,
    isClosed: json['isClosed'] as bool ?? false,
    isMember: json['isMember'] as bool ?? false,
    bridgeType: json['bridgeType'] as String,
    bridgeDirection: json['bridgeDirection'] as String,
    homeTokenAddress: json['homeTokenAddress'] as String,
    metadata: json['metadata'] == null
        ? null
        : CommunityMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    homeBridgeAddress: json['homeBridgeAddress'] as String,
    webUrl: json['webUrl'] as String,
    foreignBridgeAddress: json['foreignBridgeAddress'] as String,
    foreignTokenAddress: json['foreignTokenAddress'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$_$_CommunityToJson(_$_Community instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'plugins': const PluginsConverter().toJson(instance.plugins),
      'businesses': instance.businesses?.map((e) => e?.toJson())?.toList(),
      'isMultiBridge': instance.isMultiBridge,
      'isClosed': instance.isClosed,
      'isMember': instance.isMember,
      'bridgeType': instance.bridgeType,
      'bridgeDirection': instance.bridgeDirection,
      'homeTokenAddress': instance.homeTokenAddress,
      'metadata': instance.metadata?.toJson(),
      'homeBridgeAddress': instance.homeBridgeAddress,
      'webUrl': instance.webUrl,
      'foreignBridgeAddress': instance.foreignBridgeAddress,
      'foreignTokenAddress': instance.foreignTokenAddress,
      'description': instance.description,
    };
