// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Community _$_$_CommunityFromJson(Map<String, dynamic> json) {
  return _$_Community(
    name: json['name'] as String? ?? '',
    address: json['address'] as String? ?? '',
    isMultiBridge: json['isMultiBridge'] as bool? ?? false,
    isClosed: json['isClosed'] as bool? ?? false,
    isMember: json['isMember'] as bool? ?? false,
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
    businesses: (json['businesses'] as List<dynamic>)
        .map((e) => Business.fromJson(e as Map<String, dynamic>))
        .toList(),
    description: json['description'] as String?,
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
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata?.toJson());
  val['webUrl'] = instance.webUrl;
  val['bridgeType'] = instance.bridgeType;
  val['bridgeDirection'] = instance.bridgeDirection;
  val['homeBridgeAddress'] = instance.homeBridgeAddress;
  val['foreignBridgeAddress'] = instance.foreignBridgeAddress;
  val['foreignTokenAddress'] = instance.foreignTokenAddress;
  writeNotNull('plugins', instance.plugins?.toJson());
  val['businesses'] = instance.businesses.map((e) => e.toJson()).toList();
  writeNotNull('description', instance.description);
  return val;
}
