import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class InviteJob extends Job {
  InviteJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
      : super(
            id: id,
            jobType: jobType,
            name: name,
            status: status,
            data: data,
            arguments: arguments,
            lastFinishedAt: lastFinishedAt,
            isReported: isReported,
            timeStart: timeStart ?? new DateTime.now().millisecondsSinceEpoch,
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
      logger.info('InviteJob FAILED');
      store.dispatch(transactionFailed(arguments['inviteTransfer']));
      store.dispatch(segmentTrackCall('Wallet: InviteJob FAILED'));
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
      logger.info('InviteJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      store.dispatch(transactionFailed(arguments['inviteTransfer']));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      return;
    }

    Job job = JobFactory.create(fetchedData);
    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      final logger = await AppFactory().getLogger('Job');
      logger.info('InviteJob job not done');
      return;
    }
    this.status = 'DONE';
    if (arguments['tokenAddress'] != null) {
      store.dispatch(inviteProAndSendSuccessCall(
          job,
          fetchedData['data'],
          arguments['tokensAmount'],
          arguments['receiverName'],
          arguments['inviteTransfer'],
          arguments['sendSuccessCallback'],
          arguments['sendFailureCallback']));
    } else {
      store.dispatch(inviteAndSendSuccessCall(
          job,
          fetchedData['data'],
          arguments['tokensAmount'],
          arguments['receiverName'],
          arguments['inviteTransfer'],
          arguments['sendSuccessCallback'],
          arguments['sendFailureCallback']));
    }
    store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
  }

  @override
  dynamic argumentsToJson() => {
      'tokensAmount': arguments['tokensAmount'],
      'receiverName': arguments['receiverName'],
      'inviteTransfer': arguments['inviteTransfer'].toJson()
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('inviteTransfer')) {
      if (arguments['inviteTransfer'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['inviteTransfer'] = TransactionFactory.fromJson(arguments['inviteTransfer']);
        return nArgs;
      }
    }
    return arguments;
  }

  static InviteJob fromJson(dynamic json) => _$InviteJobFromJson(json);
}