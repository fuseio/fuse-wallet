import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_bonus_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class InviteBonusJob extends Job {
  InviteBonusJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
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
    if (this.isFunderJob == null || !this.isFunderJob) {
      return api.getJob(this.id);
    } else {
      return api.getFunderJob(this.id);
    }
  }

  @override
  onDone(store, dynamic fetchedData) async {
    final logger = await AppFactory().getLogger('Job');
    if (isReported == true) {
      this.status = 'FAILED';
      logger.info('InviteBonusJob FAILED');
      store.dispatch(transactionFailed(arguments['inviteBonus']));
      store.dispatch(segmentTrackCall('Wallet: InviteBonusJob FAILED'));
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
      logger.info('InviteBonusJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      store.dispatch(transactionFailed(arguments['inviteBonus']));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      return;
    }

    if (fetchedData['data']['funderJobId'] != null) {
      String funderJobId = fetchedData['data']['funderJobId'];
      dynamic response = await api.getFunderJob(funderJobId);
      dynamic data = response['data'];
      String responseStatus = data['status'];
      if (responseStatus == 'SUCCEEDED') {
        this.status = 'DONE';
        store.dispatch(inviteBonusSuccessCall(data['txHash'], arguments['inviteBonus']));
        store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
        logger.info('InviteBonusJob SUCCEEDED');
        return;
      } else if (responseStatus == 'FAILED') {
        this.status = 'FAILED';
        logger.info('InviteBonusJob FAILED');
      }
    }
  }

  @override
  dynamic argumentsToJson() => {
      'inviteBonus': arguments['inviteBonus'].toJson(),
      'jobType': arguments['jobType']
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('inviteBonus')) {
      if (arguments['inviteBonus'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['inviteBonus'] = TransactionFactory.fromJson(arguments['inviteBonus']);
        return nArgs;
      }
    }
    return arguments;
  }

  static InviteBonusJob fromJson(dynamic json) => _$InviteBonusJobFromJson(json);
}