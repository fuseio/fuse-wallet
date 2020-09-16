import 'package:esol/models/community/community.dart';
import 'package:esol/models/jobs/base.dart';
import 'package:esol/models/plugins/join_bonus.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/redux/state/store.dart';
import 'package:esol/services.dart';
import 'package:esol/widgets/snackbars.dart';
import 'package:json_annotation/json_annotation.dart';

part 'join_community_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class JoinCommunityJob extends Job {
  JoinCommunityJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
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
    final Community community = (arguments['community'] as Community);
    final String communityAddress = community.address;
    if (isReported == true) {
      logger.info('JoinCommunityJob FAILED');
      // store.dispatch(transactionFailed(confirmedTx, communityAddress, fetchedData['failReason']));
      store.dispatch(segmentTrackCall('Wallet: JoinCommunityJob FAILED'));
      store.dispatch(UpdateJob(communityAddress: communityAddress, job: this));
      return;
    }
    Job job = JobFactory.create(fetchedData);
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    Transfer transfer = arguments['transfer'];
    String txHash = job.data['txHash'];
    final String communityName = community.name;
    final JoinBonusPlugin joinBonusPlugin = community.plugins.joinBonus;
    final Token token = community.token;
    Transfer confirmedTx = transfer.copyWith(txHash: txHash);
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      this.isReported = true;
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
      store.dispatch(UpdateJob(communityAddress: communityAddress, job: this));
    }

    if (fetchedData['failReason'] != null && fetchedData['failedAt'] != null) {
      logger.info('JoinCommunityJob FAILED');
      this.status = 'FAILED';
      String failReason = fetchedData['failReason'];
      transactionFailedSnack(failReason);
      store.dispatch(transactionFailed(confirmedTx, communityAddress, failReason));
      store.dispatch(segmentTrackCall('Wallet: job failed', properties: new Map<String, dynamic>.from({ 'id': id, 'failReason': failReason, 'name': name })));
      store.dispatch(UpdateJob(communityAddress: communityAddress, job: this));
      return;
    }

    if (![null, ''].contains(txHash)) {
      logger.info('JoinCommunityJob txHash txHash txHash $txHash');
      store.dispatch(new ReplaceTransaction(
          transaction: transfer,
          transactionToReplace: confirmedTx,
          communityAddress: communityAddress));
      store.dispatch(UpdateJob(communityAddress: communityAddress, job: this));
    }

    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      logger.info('JoinCommunityJob not done');
      return;
    }
    this.status = 'DONE';
    store.dispatch(new ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: confirmedTx.copyWith(status: 'CONFIRMED', text: 'Joined ' + (communityName ?? '') + ' community',),
        communityAddress: communityAddress));
    store.dispatch(joinCommunitySuccessCall(job.id, fetchedData['data']['funderJobId'], communityAddress, joinBonusPlugin, token));
    store.dispatch(segmentTrackCall('Wallet: job succeeded', properties: new Map<String, dynamic>.from({ 'id': id, 'name': name })));
    store.dispatch(UpdateJob(communityAddress: communityAddress, job: this));
  }

  @override
  dynamic argumentsToJson() => {
      'transfer': arguments['transfer'].toJson(),
      'community': arguments['community'].toJson(),
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('transfer') || arguments.containsKey('community')) {
      Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
      if (arguments['transfer'] is Map) {
        nArgs['transfer'] = TransactionFactory.fromJson(arguments['transfer']);
      }
      if (arguments['community'] is Map) {
        nArgs['community'] = Community.fromJson(arguments['community']);
      }
      return nArgs;
    }
    return arguments;
  }

  static JoinCommunityJob fromJson(dynamic json) => _$JoinCommunityJobFromJson(json);
}