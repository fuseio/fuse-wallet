// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationResult _$VerificationResultFromJson(Map<String, dynamic> json) =>
    VerificationResult(
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$VerificationResultToJson(VerificationResult instance) =>
    <String, dynamic>{
      'warnings': instance.warnings,
      'errors': instance.errors,
    };
