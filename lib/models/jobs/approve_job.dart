import 'package:BIM/models/jobs/base.dart';
import 'package:BIM/redux/actions/cash_wallet_actions.dart';
import 'package:BIM/redux/state/store.dart';
import 'package:BIM/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;

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
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      return;
    }

    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      logger.info('ApproveJob not done');
      return;
    }
    wallet_core.Web3 web3 = store.state.proWalletState.web3;
    if (web3 != null) {
      this.status = 'DONE';
      logger.info('start tokenTransfer job');
      String walletAddress = store.state.userState.walletAddress;
      await api.tokenTransfer(web3, walletAddress, arguments['tokenAddress'], arguments['receiverAddress'], arguments['tokensAmount'], network: arguments['network']);
      store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
    }
  }

  @override
  dynamic argumentsToJson() => {
      'jobType': arguments['jobType'],
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
      if (arguments['tokensAmount'] is String) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['tokensAmount'] = num.parse(arguments['tokensAmount']);
        return nArgs;
      }
    }
    return arguments;
  }

  static ApproveJob fromJson(dynamic json) => _$ApproveJobFromJson(json);
}