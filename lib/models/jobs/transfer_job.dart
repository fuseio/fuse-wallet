import 'package:esol/models/jobs/base.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/redux/state/store.dart';
import 'package:esol/services.dart';
import 'package:esol/widgets/snackbars.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class TransferJob extends Job {
  TransferJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
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
    if (this.isFunderJob == true) {
      return api.getFunderJob(this.id);  
    }
    return api.getJob(this.id);
  }

  @override
  onDone(store, dynamic fetchedData) async {
    final logger = await AppFactory().getLogger('Job');
    if (isReported == true) {
      this.status = 'FAILED';
      logger.info('TransferJob FAILED');
      // store.dispatch(transactionFailed(arguments['transfer'], arguments['communityAddress']));
      store.dispatch(segmentTrackCall('Wallet: TransferJob FAILED'));
      return;
    }
    Job job = JobFactory.create(fetchedData);
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    String txHash = job?.data['txHash'];
    Transfer transfer = arguments['transfer'];
    Transfer confirmedTx = transfer.copyWith(txHash: txHash);
    if (![null, ''].contains(txHash)) {
      logger.info('TransferJob txHash txHash txHash $txHash');
      store.dispatch(new ReplaceTransaction(
          transaction: transfer,
          transactionToReplace: confirmedTx,
          communityAddress: arguments['communityAddress']));
      store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
    }

    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      this.isReported = true;
      store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
    }

    if (fetchedData['failReason'] != null && fetchedData['failedAt'] != null) {
      logger.info('TransferJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      transactionFailedSnack(failReason);
      store.dispatch(transactionFailed(transfer, arguments['communityAddress'], failReason));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
      return;
    }

    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      logger.info('TransferJob not done');
      return;
    }
    this.status = 'DONE';
    store.dispatch(new ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: confirmedTx.copyWith(status: 'CONFIRMED'),
        communityAddress: arguments['communityAddress']));
    store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
    store.dispatch(UpdateJob(communityAddress: arguments['communityAddress'], job: this));
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
    if (arguments.containsKey('transfer')) {
      if (arguments['transfer'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['transfer'] = TransactionFactory.fromJson(arguments['transfer']);
        return nArgs;
      }
    }
    return arguments;
  }

  static TransferJob fromJson(dynamic json) => _$TransferJobFromJson(json);
}