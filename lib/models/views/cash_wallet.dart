import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class CashWalletViewModel {
  final String accountAddress;
  final String walletAddress;
  final String communityAddress;
  final String walletStatus;
  final Function(String) createWallet;
  final Function() getWallet;

  CashWalletViewModel({
    this.accountAddress,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.createWallet,
    this.getWallet
  });

  static CashWalletViewModel fromStore(Store<AppState> store) {
    return CashWalletViewModel(
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.cashWalletState.walletAddress,
      walletStatus: store.state.cashWalletState.walletStatus,
      communityAddress: store.state.cashWalletState.communityAddress,
      createWallet: (accountAddress) {
        store.dispatch(createAccountWalletCall(accountAddress));
      },
      getWallet: () {
        store.dispatch(getWalletAddressCall());
      }
    );
  }
}