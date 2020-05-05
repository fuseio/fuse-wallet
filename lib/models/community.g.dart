// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return Community(
    name: json['name'] as String,
    isClosed: json['isClosed'] as bool,
    isMember: json['isMember'] as bool,
    address: json['address'] as String,
    plugins: json['plugins'] == null ? null : Plugins.fromJson(json['plugins']),
    transactions: json['transactions'] == null
        ? null
        : Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
    token: json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
    secondaryToken: json['secondaryToken'] == null
        ? null
        : Token.fromJson(json['secondaryToken'] as Map<String, dynamic>),
    tokenBalance: json['tokenBalance'] == null
        ? null
        : BigInt.parse(json['tokenBalance'] as String),
    businesses: (json['businesses'] as List)
        ?.map((e) =>
            e == null ? null : Business.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    jobs: Community._jobsFromJson(json['jobs'] as Map<String, dynamic>),
    metadata: json['metadata'] == null
        ? null
        : CommunityMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    homeBridgeAddress: json['homeBridgeAddress'] as String,
    webUrl: json['webUrl'] as String,
    foreignBridgeAddress: json['foreignBridgeAddress'] as String,
    secondaryTokenAddress: json['secondaryTokenAddress'] as String,
    secondaryTokenBalance: json['secondaryTokenBalance'] == null
        ? null
        : BigInt.parse(json['secondaryTokenBalance'] as String),
  );
}

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'homeBridgeAddress': instance.homeBridgeAddress,
      'foreignBridgeAddress': instance.foreignBridgeAddress,
      'secondaryTokenAddress': instance.secondaryTokenAddress,
      'tokenBalance': instance.tokenBalance?.toString(),
      'secondaryTokenBalance': instance.secondaryTokenBalance?.toString(),
      'isMember': instance.isMember,
      'businesses': instance.businesses?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.toJson(),
      'token': instance.token?.toJson(),
      'secondaryToken': instance.secondaryToken?.toJson(),
      'plugins': instance.plugins?.toJson(),
      'metadata': instance.metadata?.toJson(),
      'isClosed': instance.isClosed,
      'webUrl': instance.webUrl,
      'jobs': Community._jobsToJson(instance.jobs),
    };
