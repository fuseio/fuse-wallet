import 'package:esol/models/jobs/base.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/redux/actions/user_actions.dart';
import 'package:esol/redux/state/store.dart';
import 'package:esol/services.dart';
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
      // store.dispatch(transactionFailed(arguments['backupBonus'], arguments['communityAddress']));
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
      store.dispatch(transactionFailed(arguments['backupBonus'], arguments['communityAddress'], failReason));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      return;
    }

    if (fetchedData['data']['funderJobId'] != null) {
      String funderJobId = fetchedData['data']['funderJobId'];
      dynamic response = await api.getFunderJob(funderJobId);
      dynamic data = response['data'];
      Transfer transfer = arguments['backupBonus'];
      String txHash = data['txHash'];
      Transfer confirmedTx = transfer.copyWith(txHash: txHash);
      if (![null, ''].contains(txHash)) {
        logger.info('BackupJob txHash txHash txHash $txHash');
        store.dispatch(new ReplaceTransaction(
            transaction: transfer,
            transactionToReplace: confirmedTx,
            communityAddress: arguments['communityAddress']));
        store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
      }
      if (data['status'] == 'SUCCEEDED') {
        store.dispatch(backupSuccessCall(confirmedTx, arguments['communityAddress']));
        store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
        return;
      } else if (status == 'FAILED') {
        dynamic failReason = response['failReason'];
        store.dispatch(transactionFailed(arguments['backupBonus'], arguments['communityAddress'], failReason));
        store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id })));
      }
    }
  }

  @override
  dynamic argumentsToJson() => {
      'backupBonus': arguments['backupBonus'],
      'jobType': arguments['jobType'],
      'communityAddress': arguments['communityAddress']
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