import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community/community.dart';

class TopUpViewModel extends Equatable {
  final Function setDepositBanner;
  final Plugins plugins;
  final Function dismiss;
  final bool showDismiss;

  TopUpViewModel({
    this.setDepositBanner,
    this.plugins,
    this.dismiss,
    this.showDismiss,
  });

  static TopUpViewModel fromStore(Store<AppState> store) {
    final List<WalletAction> walletActions =
        List.from(store.state.cashWalletState?.walletActions?.list) ?? [];
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];

    List<Token> homeTokens = store.state.cashWalletState?.tokens?.values
        ?.where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        ?.toList();

    return TopUpViewModel(
      showDismiss: (walletActions?.any(
                (element) =>
                    element is Swap ||
                    element.map(
                      createWallet: (value) => false,
                      fiatDeposit: (value) => true,
                      joinCommunity: (value) => false,
                      bonus: (value) => false,
                      send: (value) => null,
                      receive: (value) =>
                          value.tokenAddress.toLowerCase() ==
                          fuseDollarToken.address.toLowerCase(),
                      swap: (value) => false,
                    ),
              ) ??
              false) ||
          (homeTokens?.any((element) =>
                  element?.address?.toLowerCase() ==
                  fuseDollarToken?.address?.toLowerCase()) ??
              false),
      plugins: community?.plugins ?? Plugins(),
      setDepositBanner: () {
        store.dispatch(DepositBannerShowed());
      },
      dismiss: () {
        store.dispatch(SetShowDepositBanner());
      },
    );
  }

  @override
  List get props => [
        showDismiss,
        plugins,
      ];
}
