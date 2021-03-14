import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/addresses.dart' as util;

class FeedViewModel extends Equatable {
  final List<WalletAction> walletActions;
  final Function() startFetching;
  final Function() refreshFeed;
  final bool showDepositBanner;

  FeedViewModel({
    this.startFetching,
    this.refreshFeed,
    this.walletActions,
    this.showDepositBanner,
  });

  static FeedViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    final bool showDepositBanner =
        !(store?.state?.userState?.depositBannerShowed ?? false) &&
            util.isDefaultCommunity(communityAddress) &&
            token != null;
    return FeedViewModel(
      showDepositBanner: showDepositBanner,
      walletActions: List.from(
              store.state.cashWalletState?.walletActions?.list?.reversed) ??
          [],
      startFetching: () {
        store.dispatch(startFetchingCall());
        store.dispatch(startFetchTokensBalances());
      },
      refreshFeed: () {
        store.dispatch(fetchListOfTokensByAddress());
        store.dispatch(ResetTokenTxs());
      },
    );
  }

  @override
  List<Object> get props => [
        walletActions,
        showDepositBanner,
      ];
}
