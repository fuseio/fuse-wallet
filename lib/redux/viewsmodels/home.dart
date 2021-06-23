import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class HomeViewModel extends Equatable {
  final Function() onStart;
  final bool showDepositBanner;

  HomeViewModel({
    required this.onStart,
    required this.showDepositBanner,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    bool isCommunityLoading = store.state.cashWalletState.isCommunityLoading;
    final bool isCommunityFetched =
        store.state.cashWalletState.isCommunityFetched;
    final String walletAddress = store.state.userState.walletAddress;
    final List<WalletAction>? walletActions =
        store.state.cashWalletState.walletActions?.list ?? [];
    final WalletAction? walletAction = walletActions?.firstWhere(
      (element) => element.map(
        createWallet: (_) => true,
        fiatDeposit: (_) => false,
        joinCommunity: (_) => false,
        bonus: (_) => false,
        send: (_) => false,
        receive: (_) => false,
        swap: (_) => false,
      ),
    );
    final bool isDepositBanner =
        [true, null].contains(store.state.cashWalletState.isDepositBanner);
    final bool showDepositBanner =
        (walletAction != null && walletAction.isConfirmed()) && isDepositBanner;

    return HomeViewModel(
      showDepositBanner: showDepositBanner,
      onStart: () {
        if (store.state.cashWalletState.tokens.isEmpty &&
            !isCommunityLoading &&
            isCommunityFetched) {
          store.dispatch(switchCommunityCall(defaultCommunityAddress));
        }
        if (!isCommunityLoading &&
            !isCommunityFetched &&
            ![null, ''].contains(walletAddress)) {
          store.dispatch(refetchCommunityData());
        }
      },
    );
  }

  @override
  List<Object> get props => [
        showDepositBanner,
      ];
}
