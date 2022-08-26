// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_credential_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoCredentialSubject _$UserInfoCredentialSubjectFromJson(
        Map<String, dynamic> json) =>
    UserInfoCredentialSubject(
      id: json['id'] as String,
      type: json['type'] as String? ?? "SelfIssued",
      name: json['name'] as String,
      phoneNumber: json['telephone'] as String,
    );

Map<String, dynamic> _$UserInfoCredentialSubjectToJson(
        UserInfoCredentialSubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'telephone': instance.phoneNumber,
    };
