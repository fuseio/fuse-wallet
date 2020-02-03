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
    plugins: json['plugins'] == null
        ? null
        : Plugins.fromJson(json['plugins'] as Map<String, dynamic>),
    transactions: json['transactions'] == null
        ? null
        : Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
    token: json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
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
  );
}

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'tokenBalance': instance.tokenBalance?.toString(),
      'isMember': instance.isMember,
      'businesses': instance.businesses?.map((e) => e?.toJson())?.toList(),
      'transactions': instance.transactions?.toJson(),
      'token': instance.token?.toJson(),
      'plugins': instance.plugins?.toJson(),
      'metadata': instance.metadata?.toJson(),
      'jobs': Community._jobsToJson(instance.jobs),
    };
