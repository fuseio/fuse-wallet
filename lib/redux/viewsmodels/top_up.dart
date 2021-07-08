import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community/community.dart';

class TopUpViewModel extends Equatable {
  final void Function() dismiss;
  final bool showDismiss;
  final String walletAddress;

  TopUpViewModel({
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
    final num homeBalance = double.parse(
        (tokens[community?.homeTokenAddress.toLowerCase()]?.getBalance(true) ??
            '0'));
    return TopUpViewModel(
      walletAddress: store.state.userState.walletAddress,
      showDismiss: homeBalance.compareTo(0) == 1,
      dismiss: () {
        store.dispatch(SetShowDepositBanner());
      },
    );
  }

  @override
  List get props => [
        showDismiss,
        walletAddress,
      ];
}
