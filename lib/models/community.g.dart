// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return Community(
    name: json['name'] as String,
    isMember: json['isMember'] as bool,
    address: json['address'] as String,
    plugins:
        Community._pluginsFromJson(json['plugins'] as Map<String, dynamic>),
    transactions: json['transactions'] == null
        ? null
        : Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
    token: Community._tokenFromJson(json['token'] as Map<String, dynamic>),
    tokenBalance: json['tokenBalance'] == null
        ? null
        : BigInt.parse(json['tokenBalance'] as String),
    businesses: (json['businesses'] as List)
        ?.map((e) =>
            e == null ? null : Business.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    jobs: Community._jobsFromJson(json['jobs'] as Map<String, dynamic>),
    metadata: Community._communityMetadataFromJson(
        json['metadata'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'tokenBalance': instance.tokenBalance?.toString(),
      'isMember': instance.isMember,
      'businesses': instance.businesses?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.toJson(),
      'token': Community._tokenToJson(instance.token),
      'jobs': Community._jobsToJson(instance.jobs),
      'plugins': Community._pluginsToJson(instance.plugins),
      'metadata': Community._communityMetadataToJson(instance.metadata),
    };
