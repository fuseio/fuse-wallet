import 'package:wiki_bank/models/jobs/base.dart';
import 'package:wiki_bank/redux/actions/cash_wallet_actions.dart';
import 'package:wiki_bank/redux/state/store.dart';
import 'package:wiki_bank/services.dart';
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
      this.status = 'FAILED';
      logger.info('GenerateWalletJob FAILED');
      store.dispatch(segmentTrackCall('Wallet: GenerateWalletJob FAILED'));
      return;
    }
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job', properties: new Map<String, dynamic>.from({'id': id, 'name': name})));
      this.isReported = true;
    }

    String walletAddress = fetchedData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
      this.status = 'DONE';
      store.dispatch(new CreateAccountWalletSuccess(arguments['accountAddress']));
      store.dispatch(generateWalletSuccessCall(fetchedData, arguments['accountAddress']));
    }
  }

  static GenerateWalletJob fromJson(dynamic json) => _$GenerateWalletJobFromJson(json);
}
