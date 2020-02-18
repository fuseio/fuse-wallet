// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_community_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinCommunityJob _$JoinCommunityJobFromJson(Map<String, dynamic> json) {
  return JoinCommunityJob(
    id: json['id'],
    jobType: json['jobType'],
    name: json['name'],
    status: json['status'],
    data: json['data'],
    arguments: json['arguments'],
    lastFinishedAt: json['lastFinishedAt'],
  );
}

Map<String, dynamic> _$JoinCommunityJobToJson(JoinCommunityJob instance) =>
    <String, dynamic>{
      'status': instance.status,
      'arguments': instance.arguments,
      'id': instance.id,
      'jobType': instance.jobType,
      'name': instance.name,
      'data': instance.data,
      'lastFinishedAt': instance.lastFinishedAt,
    };
