// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackupJob _$BackupJobFromJson(Map<String, dynamic> json) {
  return BackupJob(
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
