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
    timeStart: json['timeStart'],
    isReported: json['isReported'],
    isFunderJob: json['isFunderJob'],
  );
}
