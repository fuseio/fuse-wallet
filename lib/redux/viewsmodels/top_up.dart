import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community/community.dart';

class TopUpViewModel extends Equatable {
  final Function setDepositBanner;
  final Plugins plugins;
  final void Function()? dismiss;
  final bool showDismiss;
  final String walletAddress;
  final String countryCode;
  final String isoCode;

  TopUpViewModel({
    required this.isoCode,
    required this.countryCode,
    required this.setDepositBanner,
    required this.plugins,
    required this.dismiss,
    required this.showDismiss,
    required this.walletAddress,
  });

  static TopUpViewModel fromStore(Store<AppState> store) {
    final Map<String, Token> tokens = store.state.cashWalletState.tokens;
    final String communityAddress =
        store.state.cashWalletState.communityAddress;
    final Community? community =
        store.state.cashWalletState.communities[communityAddress];
    final Plugins plugins = community?.plugins ?? Plugins();
    final num homeBalance = double.parse(
        (tokens[community?.homeTokenAddress.toLowerCase()]?.getBalance(true) ??
            '0'));
    return TopUpViewModel(
      plugins: plugins,
      isoCode: store.state.userState.isoCode,
      countryCode: store.state.userState.countryCode,
      walletAddress: store.state.userState.walletAddress,
      showDismiss: homeBalance.compareTo(0) == 1,
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
        countryCode,
        isoCode,
        showDismiss,
        walletAddress,
        plugins,
      ];
}
