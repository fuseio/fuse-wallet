import 'package:esol/models/jobs/base.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/redux/state/store.dart';
import 'package:esol/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'join_bonus_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class JoinBonusJob extends Job {
  JoinBonusJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
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
    if (this.isFunderJob == true) {
      return api.getFunderJob(this.id);
    }
    return api.getJob(this.id);
  }

  @override
  onDone(store, dynamic fetchedData) async {
    final logger = await AppFactory().getLogger('Job');
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      this.isReported = true;
      store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
    }

    if (isFunderJob == true) {
      dynamic data = fetchedData['data'];
      String responseStatus = data['status'];
      Transfer transfer = arguments['joinBonus'];
      String txHash = data['txHash'];
      Transfer confirmedTx = transfer.copyWith(txHash: txHash);
      if (![null, ''].contains(txHash)) {
        logger.info('isFunderJob JoinBonusJob txHash txHash txHash $txHash');
        store.dispatch(new ReplaceTransaction(
            transaction: transfer,
            transactionToReplace: confirmedTx,
            communityAddress: arguments['communityAddress']));
        store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
      }
      if (responseStatus == 'SUCCEEDED') {
        this.status = 'DONE';
        store.dispatch(ReplaceTransaction(
            transaction: transfer,
            transactionToReplace: confirmedTx.copyWith(status: 'CONFIRMED',),
            communityAddress: arguments['communityAddress']));
        store.dispatch(joinBonusSuccessCall(arguments['communityAddress']));
        store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
        store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
        logger.info('JoinBonusJob SUCCEEDED');
        return;
      } else if (responseStatus == 'FAILED') {
        this.status = 'FAILED';
        logger.info('JoinBonusJob FAILED');
        store.dispatch(transactionFailed(confirmedTx, arguments['communityAddress'], fetchedData['failReason']));
        store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id })));
        store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
        return;
      }
    } else {
      if (fetchedData['data']['funderJobId'] != null) {
        String funderJobId = fetchedData['data']['funderJobId'];
        dynamic response = await api.getFunderJob(funderJobId);
        dynamic data = response['data'];
        String responseStatus = data['status'];
        Transfer transfer = arguments['joinBonus'];
        String txHash = data['txHash'];
        Transfer confirmedTx = transfer.copyWith(txHash: txHash);
        if (![null, ''].contains(txHash)) {
          logger.info('JoinBonusJob txHash txHash txHash $txHash');
          store.dispatch(new ReplaceTransaction(
              transaction: transfer,
              transactionToReplace: confirmedTx,
              communityAddress: arguments['communityAddress']));
          store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
        }
        if (responseStatus == 'SUCCEEDED') {
          this.status = 'DONE';
          store.dispatch(ReplaceTransaction(
            transaction: transfer,
            transactionToReplace: confirmedTx.copyWith(status: 'CONFIRMED',),
            communityAddress: arguments['communityAddress']));
          store.dispatch(joinBonusSuccessCall(arguments['communityAddress']));
          store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
          logger.info('JoinBonusJob SUCCEEDED');
          store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
          return;
        } else if (responseStatus == 'FAILED') {
          this.status = 'FAILED';
          logger.info('JoinBonusJob FAILED');
          store.dispatch(transactionFailed(arguments['joinBonus'], arguments['communityAddress'], response['failReason']));
          store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
          return;
        }
      } else {
        this.status = 'FAILED';
        logger.info('JoinBonusJob FAILED');
        store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
        return;
      }
    }
  }

  @override
  dynamic argumentsToJson() => {
      'joinBonus': arguments['joinBonus'].toJson(),
      'jobType': arguments['jobType'],
      'communityAddress': arguments['communityAddress']
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('joinBonus')) {
      if (arguments['joinBonus'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['joinBonus'] = TransactionFactory.fromJson(arguments['joinBonus']);
        return nArgs;
      }
    }
    return arguments;
  }

  static JoinBonusJob fromJson(dynamic json) => _$JoinBonusJobFromJson(json);
}