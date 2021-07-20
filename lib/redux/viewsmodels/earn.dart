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
  final Function(VoidCallback onSuccess) claimReward;
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
    final bool hasFUSD = num.parse(token!.getBalance(true)).compareTo(0) == 1;
    final RewardClaim? rewardClaim = store.state.cashWalletState.rewardClaim;
    return EarnViewModel(
      token: token,
      hasFUSD: hasFUSD,
      rewardClaim: rewardClaim,
      claimReward: (onSuccess) {
        store.dispatch(claimUserReward(onSuccess));
      },
      updateReward: () {
        store.dispatch(getRewardData());
      },
    );
  }
}
