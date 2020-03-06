import 'package:paywise/models/jobs/base.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:paywise/redux/actions/user_actions.dart';
import 'package:paywise/redux/state/store.dart';
import 'package:paywise/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backup_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class BackupJob extends Job {
  BackupJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
      : super(
            id: id,
            jobType: jobType,
            name: name,
            status: status,
            data: data,
            arguments: arguments,
            lastFinishedAt: lastFinishedAt,
            isReported: isReported,
            timeStart: timeStart ?? DateTime.now().millisecondsSinceEpoch,
            isFunderJob: isFunderJob);

  @override
  fetch() async {
    return api.getJob(this.id);
  }

  @override
  onDone(store, dynamic fetchedData) async {
    final logger = await AppFactory().getLogger('Job');
    if (isReported == true) {
      this.status = 'FAILED';
      logger.info('BackupJob FAILED');
      store.dispatch(transactionFailed(arguments['backupBonus']));
      store.dispatch(segmentTrackCall('Wallet: BackupJob FAILED'));
      return;
    }
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      this.isReported = true;
    }

    if (fetchedData['failReason'] != null && fetchedData['failedAt'] != null) {
      logger.info('BackupJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      store.dispatch(transactionFailed(arguments['backupBonus']));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      return;
    }

    if (fetchedData['data']['funderJobId'] != null) {
      String funderJobId = fetchedData['data']['funderJobId'];
      dynamic response = await api.getFunderJob(funderJobId);
      dynamic data = response['data'];
      if (data['status'] == 'SUCCEEDED') {
        this.status = 'DONE';
        store.dispatch(backupSuccessCall(data['txHash'], arguments['backupBonus']));
        store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
        return;
      } else if (status == 'FAILED') {
        this.status = 'FAILED';
        store.dispatch(segmentTrackCall('Wallet: FAILED job $id $name'));
      } else if (status == 'STARTED') {
        logger.info('BackupJob job not done');
      }
    }
  }

  @override
  dynamic argumentsToJson() => {
      'backupBonus': arguments['backupBonus'],
      'jobType': arguments['jobType']
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('backupBonus')) {
      if (arguments['backupBonus'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['backupBonus'] = TransactionFactory.fromJson(arguments['backupBonus']);
        return nArgs;
      }
    }
    return arguments;
  }

  static BackupJob fromJson(dynamic json) => _$BackupJobFromJson(json);
}