import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
// import 'package:fusecash/utils/addresses.dart' as util;

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
    List<Token> tokens = store.state.cashWalletState.tokens.values
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList();
    final String communityAddress =
        store.state.cashWalletState.communityAddress;
    final Community community =
        store.state.cashWalletState.communities[communityAddress];
    final Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];

    final WalletAction walletAction =
        store.state.cashWalletState?.walletActions?.list?.firstWhere(
      (element) => element.name == 'createWallet',
      orElse: () => null,
    );
    final List<WalletAction> walletActions =
        List.from(store.state.cashWalletState?.walletActions?.list) ?? [];
    final bool showDepositBanner = token != null &&
        (walletAction != null && walletAction.isConfirmed()) &&
        (walletActions.isNotEmpty && walletActions.length < 2) &&
        tokens != null &&
        tokens.isEmpty;
    return FeedViewModel(
      showDepositBanner: showDepositBanner,
      walletActions: showDepositBanner
          ? [
              ...walletActions,
              WalletAction.depositYourFirstDollar(
                tokenAddress: token?.address,
                timestamp: walletActions[0].timestamp,
              ),
            ]
          : walletActions,
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
