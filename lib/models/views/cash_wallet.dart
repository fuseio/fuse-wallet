import 'package:equatable/equatable.dart';
import 'package:localdolarmx/models/business.dart';
import 'package:localdolarmx/models/community.dart';
import 'package:localdolarmx/models/transactions/transactions.dart';
import 'package:redux/redux.dart';
import 'package:localdolarmx/models/app_state.dart';
import 'package:localdolarmx/models/token.dart';
import 'package:localdolarmx/models/transactions/transaction.dart';

import 'package:localdolarmx/redux/actions/cash_wallet_actions.dart';
import 'package:localdolarmx/redux/actions/user_actions.dart';
import 'package:contacts_service/contacts_service.dart';

class CashWalletViewModel extends Equatable {
  final String accountAddress;
  final String walletAddress;
  final String communityAddress;
  final String branchAddress;
  final String identifier;
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
  final Transactions transactions;
  final List<Contact> contacts;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final Function(String) switchCommunity;
  final Function() startTransfersFetching;
  final Function() listenToBranch;
  final Function(List<Contact>) syncContacts;
  final Function() branchCommunityUpdate;
  final List<Business> businesses;
  final Function() loadBusinesses;
  final Function() syncContactsRejected;
  final Function() startProcessingJobs;
  final Function() setIdentifier;
  final bool isContactsSynced;
  final bool isJobProcessingStarted;
  final Community community;

  CashWalletViewModel({
    this.accountAddress,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.branchAddress,
    this.identifier,
    this.isCommunityLoading,
    this.isCommunityFetched,
    this.isBalanceFetchingStarted,
    this.isListeningToBranch,
    this.isBranchDataReceived,
    this.isTransfersFetchingStarted,
    this.displayName,
    this.tokenBalance,
    this.token,
    this.transactions,
    this.contacts,
    this.countryCode,
    this.reverseContacts,
    this.switchCommunity,
    this.startTransfersFetching,
    this.listenToBranch,
    this.syncContacts,
    this.branchCommunityUpdate,
    this.businesses,
    this.loadBusinesses,
    this.syncContactsRejected,
    this.isCommunityBusinessesFetched,
    this.startProcessingJobs,
    this.setIdentifier,
    this.isContactsSynced,
    this.isJobProcessingStarted,
    this.community
  });

  static CashWalletViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddress] ?? new Community.initial();
    bool isCommunityLoading = store.state.cashWalletState.isCommunityLoading ?? false;
    String branchAddress = store.state.cashWalletState.branchAddress;
    return CashWalletViewModel(
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.cashWalletState.walletAddress,
      walletStatus: store.state.cashWalletState.walletStatus,
      communityAddress: communityAddress,
      branchAddress: branchAddress,
      identifier: store.state.userState.identifier,
      isCommunityLoading: isCommunityLoading,
      isCommunityFetched: store.state.cashWalletState.isCommunityFetched ?? false,
      isBalanceFetchingStarted: store.state.cashWalletState.isBalanceFetchingStarted ?? false,
      isTransfersFetchingStarted: store.state.cashWalletState.isTransfersFetchingStarted ?? false,
      isListeningToBranch: store.state.cashWalletState.isListeningToBranch ?? false,
      isBranchDataReceived: store.state.cashWalletState.isBranchDataReceived ?? false,
      displayName: store.state.userState.displayName,
      tokenBalance: community?.tokenBalance ?? BigInt.from(0),
      token: community?.token,
      transactions: community?.transactions ?? new Transactions(list: new List<Transaction>()),
      contacts: store.state.userState.contacts,
      reverseContacts: store.state.userState.reverseContacts,
      countryCode: store.state.userState.countryCode,
      businesses: community?.businesses ?? [],
      isCommunityBusinessesFetched: store.state.cashWalletState.isCommunityBusinessesFetched,
      isContactsSynced: store.state.userState.isContactsSynced,
      isJobProcessingStarted: store.state.cashWalletState.isJobProcessingStarted ?? false,
      community: community,
      switchCommunity: (String communityAddress) {
        store.dispatch(switchCommunityCall(communityAddress));
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
      },
      setIdentifier: () {
        store.dispatch(setDeviceId(true));
      }
    );
  }

  @override
  List<Object> get props => [
    contacts,
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