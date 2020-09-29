import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generate_wallet_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class GenerateWalletJob extends Job {
  GenerateWalletJob(
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
            isReported: isReported,
            lastFinishedAt: lastFinishedAt,
            timeStart: timeStart ?? new DateTime.now().millisecondsSinceEpoch,
            isFunderJob: isFunderJob);

  @override
  fetch() async {
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int timeFromStart = current - jobTime;
    if (timeFromStart > 10000) {
      return api.getWallet();
    } else {
      return Map.from({'data': {}});
    }
  }

  @override
  onDone(store, dynamic fetchedData) async {
    final logger = await AppFactory().getLogger('Job');
    if (isReported == true) {
      logger.info('GenerateWalletJob FAILED');
      store.dispatch(segmentTrackCall('Wallet: GenerateWalletJob FAILED'));
      store.dispatch(UpdateJob(tokenAddress: arguments['tokenAddress'], job: this));
      return;
    }
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({'id': id, 'name': name})));
      this.isReported = true;
      store.dispatch(UpdateJob(tokenAddress: arguments['tokenAddress'], job: this));
    }

    String walletAddress = fetchedData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(CreateAccountWalletSuccess());
      store.dispatch(generateWalletSuccessCall(fetchedData, arguments['accountAddress']));
      final String communityAddress = store.state.cashWalletState.communityAddress ?? defaultCommunityAddress;
      store.dispatch(switchCommunityCall(communityAddress));
      this.status = 'DONE';
      store.dispatch(UpdateJob(tokenAddress: arguments['tokenAddress'], job: this));
    }
  }

  static GenerateWalletJob fromJson(dynamic json) => _$GenerateWalletJobFromJson(json);
}
