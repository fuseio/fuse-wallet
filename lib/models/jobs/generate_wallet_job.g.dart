// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_wallet_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateWalletJob _$GenerateWalletJobFromJson(Map<String, dynamic> json) {
  return GenerateWalletJob(
    id: json['id'],
    jobType: json['jobType'],
    name: json['name'],
    status: json['status'],
    data: json['data'],
    arguments: json['arguments'],
    lastFinishedAt: json['lastFinishedAt'],
  );
}

Map<String, dynamic> _$GenerateWalletJobToJson(GenerateWalletJob instance) =>
    <String, dynamic>{
      'status': instance.status,
      'arguments': instance.arguments,
      'id': instance.id,
      'jobType': instance.jobType,
      'name': instance.name,
      'data': instance.data,
      'lastFinishedAt': instance.lastFinishedAt,
    };
