// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_credential_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueCredentialOptions _$IssueCredentialOptionsFromJson(
        Map<String, dynamic> json) =>
    IssueCredentialOptions(
      proofPurpose: json['proofPurpose'] as String,
      verificationMethod: json['verificationMethod'] as String,
    );

Map<String, dynamic> _$IssueCredentialOptionsToJson(
        IssueCredentialOptions instance) =>
    <String, dynamic>{
      'proofPurpose': instance.proofPurpose,
      'verificationMethod': instance.verificationMethod,
    };
