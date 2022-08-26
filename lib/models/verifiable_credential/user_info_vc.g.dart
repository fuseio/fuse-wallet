// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_vc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoVC _$UserInfoVCFromJson(Map<String, dynamic> json) => UserInfoVC(
      context: json['@context'] as List<dynamic>? ??
          [
            'https://www.w3.org/2018/credentials/v1',
            {
              'name': 'https://schema.org/name',
              'description': 'https://schema.org/description',
              'SelfIssued': {
                '@context': {
                  '@protected': true,
                  '@version': 1.1,
                  'id': '@id',
                  'schema': 'https://schema.org/',
                  'telephone': 'schema:telephone',
                  'type': '@type'
                },
                '@id': 'https://github.com/TalaoDAO/context/blob/main/README.md'
              }
            }
          ],
      id: json['id'] as String,
      type:
          (json['type'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              ['VerifiableCredential', 'SelfIssued'],
      issuer: json['issuer'] as String,
      issuanceDate: json['issuanceDate'] as String,
      userInfoCredentialSubject: UserInfoCredentialSubject.fromJson(
          json['credentialSubject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoVCToJson(UserInfoVC instance) =>
    <String, dynamic>{
      '@context': instance.context,
      'id': instance.id,
      'type': instance.type,
      'issuer': instance.issuer,
      'issuanceDate': instance.issuanceDate,
      'credentialSubject': instance.userInfoCredentialSubject.toJson(),
    };
