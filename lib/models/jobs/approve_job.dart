import 'package:esol/models/jobs/base.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/redux/actions/pro_mode_wallet_actions.dart';
import 'package:esol/redux/state/store.dart';
import 'package:esol/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'approve_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class ApproveJob extends Job {
  ApproveJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
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
      logger.info('ApproveJob FAILED');
      store.dispatch(proTransactionFailed(arguments['tokenAddress'], arguments['transfer']));
      store.dispatch(segmentTrackCall('Wallet: ApproveJob FAILED', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      return;
    }
    Job job = JobFactory.create(fetchedData);
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      this.isReported = true;
    }

    if (fetchedData['failReason'] != null && fetchedData['failedAt'] != null) {
      logger.info('ApproveJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      store.dispatch(proTransactionFailed(arguments['tokenAddress'], arguments['transfer']));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      return;
    }

    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      logger.info('ApproveJob not done');
      return;
    }

    if (fetchedData['data']['nextRealyJobId'] != null) {
      String nextRealyJobId = fetchedData['data']['nextRealyJobId'];
      dynamic response = await api.getJob(nextRealyJobId);
      dynamic data = response['data'];

      if (response['failReason'] != null && response['failedAt'] != null) {
        logger.info('ApproveJob FAILED');
        this.status = 'FAILED';
        String failReason = response['failReason'];
        store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
        store.dispatch(proTransactionFailed(arguments['tokenAddress'], arguments['transfer']));
        return;
      }

      if (response['lastFinishedAt'] == null || response['lastFinishedAt'].isEmpty) {
        logger.info('ApproveJob not done');
        return;
      }

      this.status = 'DONE';
      String txHash = data['txHash'];
      store.dispatch(sendErc20TokenSuccessCall(txHash, arguments['tokenAddress'], arguments['transfer']));
      store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      store.dispatch(ProJobDone(job: this, tokenAddress: arguments['tokenAddress']));
    }
  }

  @override
  dynamic argumentsToJson() => {
      'jobType': arguments['jobType'],
      'transfer': arguments['transfer'].toJson(),
      'network': arguments['network'],
      'tokensAmount': arguments['tokensAmount'].toString(),
      'receiverAddress': arguments['receiverAddress'],
      'tokenAddress': arguments['tokenAddress']
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('tokensAmount')) {
      if (arguments['tokensAmount'] is String && arguments['transfer'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['tokensAmount'] = num.parse(arguments['tokensAmount']);
        nArgs['transfer'] = Transfer.fromJson(arguments['transfer']);
        return nArgs;
      }
    }
    return arguments;
  }

  static ApproveJob fromJson(dynamic json) => _$ApproveJobFromJson(json);
}