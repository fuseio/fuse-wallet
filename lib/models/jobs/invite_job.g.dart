// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteJob _$InviteJobFromJson(Map<String, dynamic> json) {
  return InviteJob(
    id: json['id'],
    jobType: json['jobType'],
    name: json['name'],
    status: json['status'],
    data: json['data'],
    arguments: json['arguments'],
    lastFinishedAt: json['lastFinishedAt'],
  );
}

Map<String, dynamic> _$InviteJobToJson(InviteJob instance) => <String, dynamic>{
      'status': instance.status,
      'arguments': instance.arguments,
      'id': instance.id,
      'jobType': instance.jobType,
      'name': instance.name,
      'data': instance.data,
      'lastFinishedAt': instance.lastFinishedAt,
    };
