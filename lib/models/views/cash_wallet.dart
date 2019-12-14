import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import '../token.dart';
import '../transfer.dart';

class CashWalletViewModel {
  final String accountAddress;
  final String walletAddress;
  final String communityAddress;
  final bool isCommunityLoading;
  final bool isCommunityFetched;
  final bool isBalanceFetchingStarted;
  final bool isTransfersFetchingStarted;
  final String walletStatus;
  final String fullName;
  final BigInt tokenBalance;
  final Token token;
  final List<Transfer> tokenTransfers;
  final Function(String) createWallet;
  final Function() getWallet;
  final Function() firstName;
  final Function() getTokenBalance;
  final Function() switchCommunity;
  final Function() startBalanceFetching;
  final Function() startTransfersFetching;

  CashWalletViewModel({
    this.accountAddress,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.isCommunityLoading,
    this.isCommunityFetched,
    this.isBalanceFetchingStarted,
    this.isTransfersFetchingStarted,
    this.fullName,
    this.tokenBalance,
    this.token,
    this.tokenTransfers,
    this.createWallet,
    this.getWallet,
    this.firstName,
    this.getTokenBalance,
    this.switchCommunity,
    this.startBalanceFetching,
    this.startTransfersFetching
  });

  static CashWalletViewModel fromStore(Store<AppState> store) {
    return CashWalletViewModel(
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.cashWalletState.walletAddress,
      walletStatus: store.state.cashWalletState.walletStatus,
      communityAddress: store.state.cashWalletState.communityAddress,
      isCommunityLoading: store.state.cashWalletState.isCommunityLoading,
      isCommunityFetched: store.state.cashWalletState.isCommunityFetched,
      isBalanceFetchingStarted: store.state.cashWalletState.isBalanceFetchingStarted,
      isTransfersFetchingStarted: store.state.cashWalletState.isTransfersFetchingStarted,
      fullName: store.state.userState.fullName,
      tokenBalance: store.state.cashWalletState.tokenBalance,
      token: store.state.cashWalletState.token,
      tokenTransfers: store.state.cashWalletState.tokenTransfers,
      createWallet: (accountAddress) {
        store.dispatch(createAccountWalletCall(accountAddress));
      },
      getWallet: () {
        store.dispatch(getWalletAddressCall());
      },
      firstName: () {
        String fullName = store.state.userState.fullName;
        return fullName.split(' ')[0];
      },
      // getTokenBalance: () {
      //   store.dispatch(getTokenBalanceCall());
      // },
      switchCommunity: () {
        store.dispatch(switchCommunityCall());
      },
      startBalanceFetching: () {
        store.dispatch(startBalanceFetchingCall());
      },
      startTransfersFetching: () {
        store.dispatch(startTransfersFetchingCall());
      }
    );
  }

  bool operator == (other) {
    if (other is CashWalletViewModel) {
      if (
        accountAddress == other.accountAddress &&
        walletAddress == other.walletAddress &&
        walletStatus == other.walletStatus &&
        communityAddress == other.communityAddress &&
        isCommunityLoading == other.isCommunityLoading &&
        fullName == other.fullName &&
        tokenBalance == other.tokenBalance &&
        token == other.token &&
        tokenTransfers == other.tokenTransfers
      )
      return true;
    }
    return false;
  }
}