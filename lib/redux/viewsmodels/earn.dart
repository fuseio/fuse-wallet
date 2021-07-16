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
  final Function claimReward;
  EarnViewModel({
    this.rewardClaim,
    required this.hasFUSD,
    required this.token,
    required this.claimReward,
  });

  static EarnViewModel fromStore(Store<AppState> store) {
    final Token? token = fuseDollarToken; // store.state.cashWalletState.tokens[fuseDollarToken.address.toLowerCase()];
    final bool hasFUSD = num.parse(token!.getBalance(true)).compareTo(0) == 1;
    return EarnViewModel(
      token: token,
      hasFUSD: hasFUSD,
      rewardClaim: store.state.cashWalletState.rewardClaim,
      claimReward: () {
        store.dispatch(claimUserReward());
      },
    );
  }
}
