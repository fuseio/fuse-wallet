// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertJob _$ConvertJobFromJson(Map<String, dynamic> json) {
  return ConvertJob(
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
