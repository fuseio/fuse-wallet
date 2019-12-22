import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:contacts_service/contacts_service.dart';
import '../token.dart';
import '../transfer.dart';


class CashWalletViewModel {
  final String accountAddress;
  final String walletAddress;
  final String communityAddress;
  final String branchAddress;
  final bool isCommunityLoading;
  final bool isCommunityFetched;
  final bool isBalanceFetchingStarted;
  final bool isTransfersFetchingStarted;
  final bool isListeningToBranch;
  final String walletStatus;
  final String fullName;
  final BigInt tokenBalance;
  final Token token;
  final List<Transfer> tokenTransfers;
  final List<Transfer> pendingTransfers;
  final List<Contact> contacts;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final Function(String) createWallet;
  final Function() getWallet;
  final Function() firstName;
  final Function() getTokenBalance;
  final Function(String) switchCommunity;
  final Function() startBalanceFetching;
  final Function() startTransfersFetching;
  final Function() listenToBranch;
  final Function(List<Contact>) syncContacts;
  final Function() branchCommunityUpdate;


  CashWalletViewModel({
    this.accountAddress,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.branchAddress,
    this.isCommunityLoading,
    this.isCommunityFetched,
    this.isBalanceFetchingStarted,
    this.isListeningToBranch,
    this.isTransfersFetchingStarted,
    this.fullName,
    this.tokenBalance,
    this.token,
    this.tokenTransfers,
    this.pendingTransfers,
    this.contacts,
    this.countryCode,
    this.reverseContacts,
    this.createWallet,
    this.getWallet,
    this.firstName,
    this.getTokenBalance,
    this.switchCommunity,
    this.startBalanceFetching,
    this.startTransfersFetching,
    this.listenToBranch,
    this.syncContacts,
    this.branchCommunityUpdate
  });

  static CashWalletViewModel fromStore(Store<AppState> store) {
    return CashWalletViewModel(
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.cashWalletState.walletAddress,
      walletStatus: store.state.cashWalletState.walletStatus,
      communityAddress: store.state.cashWalletState.communityAddress,
      branchAddress: store.state.cashWalletState.branchAddress,
      isCommunityLoading: store.state.cashWalletState.isCommunityLoading,
      isCommunityFetched: store.state.cashWalletState.isCommunityFetched,
      isBalanceFetchingStarted: store.state.cashWalletState.isBalanceFetchingStarted,
      isTransfersFetchingStarted: store.state.cashWalletState.isTransfersFetchingStarted,
      isListeningToBranch: store.state.cashWalletState.isListeningToBranch,
      fullName: store.state.userState.fullName,
      tokenBalance: store.state.cashWalletState.tokenBalance,
      token: store.state.cashWalletState.token,
      tokenTransfers: store.state.cashWalletState.tokenTransfers,
      pendingTransfers: store.state.cashWalletState.pendingTransfers,
      contacts: store.state.userState.contacts,
      reverseContacts: store.state.userState.reverseContacts,
      countryCode: store.state.userState.countryCode,
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
      switchCommunity: (String communityAddress) {
        store.dispatch(switchCommunityCall(communityAddress));
      },
      startBalanceFetching: () {
        store.dispatch(startBalanceFetchingCall());
      },
      startTransfersFetching: () {
        store.dispatch(startTransfersFetchingCall());
      },
      listenToBranch: () {
        store.dispatch(listenToBranchCall());
      },
      syncContacts: (List<Contact> contacts) {
        store.dispatch(syncContactsCall(contacts));
      },
      branchCommunityUpdate: () {
        store.dispatch(BranchCommunityUpdate());
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