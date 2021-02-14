// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return Community(
    name: json['name'] as String,
    bridgeType: json['bridgeType'] as String,
    bridgeDirection: json['bridgeDirection'] as String,
    isMultiBridge: json['isMultiBridge'] as bool ?? false,
    isClosed: json['isClosed'] as bool ?? true,
    isMember: json['isMember'] as bool ?? false,
    address: json['address'] as String,
    plugins: json['plugins'] == null ? null : Plugins.fromJson(json['plugins']),
    homeTokenAddress: json['homeTokenAddress'] as String,
    businesses: (json['businesses'] as List)
            ?.map((e) =>
                e == null ? null : Business.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
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

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'homeBridgeAddress': instance.homeBridgeAddress,
      'foreignBridgeAddress': instance.foreignBridgeAddress,
      'isMember': instance.isMember,
      'businesses': instance.businesses?.map((e) => e?.toJson())?.toList(),
      'homeTokenAddress': instance.homeTokenAddress,
      'plugins': instance.plugins?.toJson(),
      'metadata': instance.metadata?.toJson(),
      'isClosed': instance.isClosed,
      'webUrl': instance.webUrl,
      'foreignTokenAddress': instance.foreignTokenAddress,
      'description': instance.description,
      'bridgeType': instance.bridgeType,
      'bridgeDirection': instance.bridgeDirection,
      'isMultiBridge': instance.isMultiBridge,
    };
