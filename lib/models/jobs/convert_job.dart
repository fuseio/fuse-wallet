import 'package:json_annotation/json_annotation.dart';
import 'package:seedbed/models/jobs/base.dart';
import 'package:seedbed/models/transactions/transfer.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';
import 'package:seedbed/redux/state/store.dart';
import 'package:seedbed/services.dart';

part 'convert_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class ConvertJob extends Job {
  ConvertJob(
      {id,
      jobType,
      name,
      status,
      data,
      arguments,
      lastFinishedAt,
      timeStart,
      isReported,
      isFunderJob})
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
      logger.info('ConvertJob FAILED');
      store.dispatch(segmentTrackCall('Wallet: ConvertJob FAILED',
          properties: new Map<String, dynamic>.from({'id': id, 'name': name})));
      return;
    }
    Job job = JobFactory.create(fetchedData);
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin &&
        isReported != null &&
        !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job',
          properties: new Map<String, dynamic>.from({'id': id, 'name': name})));
      this.isReported = true;
    }

    if (fetchedData['failReason'] != null && fetchedData['failedAt'] != null) {
      logger.info('ConvertJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      store.dispatch(transactionFailed(
          arguments['transfer'], arguments['communityAddress']));
      store.dispatch(segmentTrackCall('Wallet: job failed',
          properties: new Map<String, dynamic>.from(
              {'id': id, 'failReason': failReason, 'name': name})));
      return;
    }

    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      logger.info('ConvertJob not done');
      return;
    }

    if (fetchedData['data']['nextRealyJobId'] != null) {
      String nextRealyJobId = fetchedData['data']['nextRealyJobId'];
      dynamic response = await api.getJob(nextRealyJobId);
      dynamic data = response['data'];

      if (response['failReason'] != null && response['failedAt'] != null) {
        logger.info('ConvertJob FAILED');
        this.status = 'FAILED';
        String failReason = response['failReason'];
        store.dispatch(transactionFailed(
            arguments['transfer'], arguments['communityAddress']));
        store.dispatch(segmentTrackCall('Wallet: job failed',
            properties: new Map<String, dynamic>.from(
                {'id': id, 'failReason': failReason, 'name': name})));
        return;
      }

      if (response['lastFinishedAt'] == null ||
          response['lastFinishedAt'].isEmpty) {
        logger.info('ConvertJob not done');
        return;
      }

      Transfer transfer = arguments['transfer'];
      String txHash = data['txHash'];
      Transfer confirmedTx = transfer.copyWith(txHash: txHash);
      if (data['txHash'] != null && [null, ''].contains(transfer.txHash)) {
        logger.info('ConvertJob txHash txHash txHash $txHash');
        store.dispatch(new ReplaceTransaction(
            transaction: transfer,
            transactionToReplace: confirmedTx,
            communityAddress: arguments['communityAddress']));
        arguments['transfer'] = confirmedTx.copyWith();
        store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
      }

      this.status = 'DONE';
      store.dispatch(sendTokenSuccessCall(confirmedTx, arguments['communityAddress']));
      store.dispatch(segmentTrackCall('Wallet: job succeeded',
          properties: new Map<String, dynamic>.from({'id': id, 'name': name})));
    }
  }

  @override
  dynamic argumentsToJson() => {
        'transfer': arguments['transfer'].toJson(),
        'communityAddress': arguments['communityAddress']
      };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('tokensAmount')) {
      if (arguments['transfer'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['transfer'] = Transfer.fromJson(arguments['transfer']);
        return nArgs;
      }
    }
    return arguments;
  }

  static ConvertJob fromJson(dynamic json) => _$ConvertJobFromJson(json);
}
