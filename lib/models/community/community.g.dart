// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Community _$$_CommunityFromJson(Map<String, dynamic> json) => _$_Community(
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      isMultiBridge: json['isMultiBridge'] as bool? ?? false,
      isClosed: json['isClosed'] as bool? ?? false,
      isMember: json['isMember'] as bool? ?? false,
      homeTokenAddress: json['homeTokenAddress'] as String? ?? '',
      metadata: json['metadata'] == null
          ? null
          : CommunityMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>),
      webUrl: json['webUrl'] as String?,
      bridgeType: json['bridgeType'] as String?,
      bridgeDirection: json['bridgeDirection'] as String?,
      homeBridgeAddress: json['homeBridgeAddress'] as String?,
      foreignBridgeAddress: json['foreignBridgeAddress'] as String?,
      foreignTokenAddress: json['foreignTokenAddress'] as String?,
      plugins: const PluginsConverter()
          .fromJson(json['plugins'] as Map<String, dynamic>?),
      businesses: (json['businesses'] as List<dynamic>?)
          ?.map((e) => Business.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_CommunityToJson(_$_Community instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'address': instance.address,
    'isMultiBridge': instance.isMultiBridge,
    'isClosed': instance.isClosed,
    'isMember': instance.isMember,
    'homeTokenAddress': instance.homeTokenAddress,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata?.toJson());
  writeNotNull('webUrl', instance.webUrl);
  writeNotNull('bridgeType', instance.bridgeType);
  writeNotNull('bridgeDirection', instance.bridgeDirection);
  writeNotNull('homeBridgeAddress', instance.homeBridgeAddress);
  writeNotNull('foreignBridgeAddress', instance.foreignBridgeAddress);
  writeNotNull('foreignTokenAddress', instance.foreignTokenAddress);
  writeNotNull('plugins', const PluginsConverter().toJson(instance.plugins));
  writeNotNull(
      'businesses', instance.businesses?.map((e) => e.toJson()).toList());
  writeNotNull('description', instance.description);
  return val;
}
