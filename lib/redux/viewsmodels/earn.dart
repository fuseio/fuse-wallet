import 'package:dio/dio.dart';
import 'package:fusecash/models/reward/reward_claim.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class EarnViewModel {
  final bool hasFUSD;
  final Token? token;
  final RewardClaim? rewardClaim;
  final VoidCallback claimReward;
  final VoidCallback updateReward;
  EarnViewModel({
    this.rewardClaim,
    required this.hasFUSD,
    required this.token,
    required this.claimReward,
    required this.updateReward,
  });

  static EarnViewModel fromStore(Store<AppState> store) {
    final Token? token = store
        .state.cashWalletState.tokens[fuseDollarToken.address.toLowerCase()];
    // final Token? token = fuseDollarToken;
    final bool hasFUSD = num.parse(token!.getBalance(true)).compareTo(0) == 1;
    return EarnViewModel(
      token: token,
      hasFUSD: hasFUSD,
      // rewardClaim: RewardClaim.fromJson({
      //   "amount": "200000000000000000",
      //   "humanAmount": 2.09393365126e-7,
      //   "isClaimed": false,
      //   "_id": "60f0336b33663e001495eab6",
      //   "walletAddress": "0x862Bd4208b2F6ed64Ce92AAdA2669d3c5CC705d9",
      //   "tokenAddress": "0x249BE57637D8B013Ad64785404b24aeBaE9B098B",
      //   "syncTimestamp": 1626354535,
      //   "syncBlockNumber": 11997127,
      //   "nextClaimTimestamp": 1626092001,
      //   "createdAt": "2021-07-15T13:08:59.244Z",
      //   "updatedAt": "2021-07-15T13:08:59.244Z",
      // }),
      // rewardClaim: store.state.cashWalletState.rewardClaim
      //     ?.copyWith(amount: '200000000000000000'),
      rewardClaim: store.state.cashWalletState.rewardClaim,
      claimReward: () {
        store.dispatch(claimUserReward());
      },
      updateReward: () {
        store.dispatch(getRewardData());
      },
    );
  }
}
