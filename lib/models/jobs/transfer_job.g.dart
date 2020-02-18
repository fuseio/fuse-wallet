// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferJob _$TransferJobFromJson(Map<String, dynamic> json) {
  return TransferJob(
    id: json['id'],
    jobType: json['jobType'],
    name: json['name'],
    status: json['status'],
    data: json['data'],
    arguments: json['arguments'],
    lastFinishedAt: json['lastFinishedAt'],
  );
}

Map<String, dynamic> _$TransferJobToJson(TransferJob instance) =>
    <String, dynamic>{
      'status': instance.status,
      'arguments': instance.arguments,
      'id': instance.id,
      'jobType': instance.jobType,
      'name': instance.name,
      'data': instance.data,
      'lastFinishedAt': instance.lastFinishedAt,
    };
