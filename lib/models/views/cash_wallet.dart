import 'package:equatable/equatable.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/transactions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/models/transaction.dart';

import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:contacts_service/contacts_service.dart';

class CashHeaderViewModel extends Equatable {
  final Community community;
  final Function() firstName;

  CashHeaderViewModel({this.community, this.firstName});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return CashHeaderViewModel(
      community: community,
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      });
  }

  @override
  List<Object> get props => [community];
}

class CashWalletViewModel extends Equatable {
  final String accountAddress;
  final String walletAddress;
  final String communityAddress;
  final String branchAddress;
  final bool isCommunityLoading;
  final bool isCommunityFetched;
  final bool isCommunityBusinessesFetched;
  final bool isBalanceFetchingStarted;
  final bool isTransfersFetchingStarted;
  final bool isListeningToBranch;
  final bool isBranchDataReceived;
  final String walletStatus;
  final String displayName;
  final BigInt tokenBalance;
  final Token token;
  // final List<Transfer> tokenTransfers;
  // final List<Transfer> pendingTransfers;
  final Transactions transactions;
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
  final List<Business> businesses;
  final Function() loadBusinesses;
  final Function() syncContactsRejected;
  final Function() startProcessingJobs;
  final bool isContactsSynced;
  final bool isJobProcessingStarted;
  final Community community;

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
    this.isBranchDataReceived,
    this.isTransfersFetchingStarted,
    this.displayName,
    this.tokenBalance,
    this.token,
    // this.tokenTransfers,
    // this.pendingTransfers,
    this.transactions,
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
    this.branchCommunityUpdate,
    this.businesses,
    this.loadBusinesses,
    this.syncContactsRejected,
    this.isCommunityBusinessesFetched,
    this.startProcessingJobs,
    this.isContactsSynced,
    this.isJobProcessingStarted,
    this.community
  });

  static CashWalletViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    bool isCommunityLoading = store.state.cashWalletState.isCommunityLoading;
    String branchAddress = store.state.cashWalletState.branchAddress;
    return CashWalletViewModel(
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.cashWalletState.walletAddress,
      walletStatus: store.state.cashWalletState.walletStatus,
      communityAddress: communityAddres,
      branchAddress: branchAddress,
      isCommunityLoading: isCommunityLoading ?? false,
      isCommunityFetched: store.state.cashWalletState.isCommunityFetched,
      isBalanceFetchingStarted: store.state.cashWalletState.isBalanceFetchingStarted,
      isTransfersFetchingStarted: store.state.cashWalletState.isTransfersFetchingStarted,
      isListeningToBranch: store.state.cashWalletState.isListeningToBranch,
      isBranchDataReceived: store.state.cashWalletState.isBranchDataReceived,
      displayName: store.state.userState.displayName,
      tokenBalance: community?.tokenBalance ?? BigInt.from(0),
      token: community?.token,
      // tokenTransfers: store.state.cashWalletState.tokenTransfers,
      // pendingTransfers: store.state.cashWalletState.pendingTransfers,
      transactions: community?.transactions ?? new Transactions(list: new List<Transaction>()),
      contacts: store.state.userState.contacts,
      reverseContacts: store.state.userState.reverseContacts,
      countryCode: store.state.userState.countryCode,
      businesses: community?.businesses ?? [],
      isCommunityBusinessesFetched: store.state.cashWalletState.isCommunityBusinessesFetched,
      isContactsSynced: store.state.userState.isContactsSynced ?? false,
      isJobProcessingStarted: store.state.cashWalletState.isJobProcessingStarted ?? false,
      community: community,
      createWallet: (accountAddress) {
        store.dispatch(createAccountWalletCall(accountAddress));
      },
      getWallet: () {
        store.dispatch(getWalletAddressCall());
      },
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      },
      switchCommunity: (String communityAddress) {
        store.dispatch(switchCommunityCall(communityAddress));
      },
      startBalanceFetching: () {
        if (isCommunityLoading) return;
        store.dispatch(startBalanceFetchingCall());
      },
      startTransfersFetching: () {
        if (isCommunityLoading) return;
        store.dispatch(startTransfersFetchingCall());
      },
      listenToBranch: () {
        store.dispatch(listenToBranchCall());
      },
      syncContacts: (List<Contact> contacts) {
        store.dispatch(syncContactsCall(contacts));
      },
      syncContactsRejected: () {
        store.dispatch(new SyncContactsRejected());
      },
      branchCommunityUpdate: () {
        store.dispatch(switchCommunityCall(branchAddress));
      },
      loadBusinesses: () {
        store.dispatch(getBusinessListCall());
      },
      startProcessingJobs: () {
        store.dispatch(startProcessingJobsCall());
      }
    );
  }

  @override
  List<Object> get props => [
    accountAddress,
    walletAddress,
    walletStatus,
    communityAddress,
    branchAddress,
    isCommunityLoading,
    displayName,
    tokenBalance,
    token,
    transactions,
    isListeningToBranch,
    isBranchDataReceived,
    isCommunityBusinessesFetched
  ];
}