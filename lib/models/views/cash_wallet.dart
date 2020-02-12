import 'package:equatable/equatable.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/draw_info.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/models/transactions.dart';
import 'package:fusecash/utils/phone.dart';
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
  final Plugins plugins;
  final DrawInfo drawInfo;

  CashHeaderViewModel({this.community, this.firstName, this.plugins, this.drawInfo});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return CashHeaderViewModel(
      community: community,
      plugins: community?.plugins,
      drawInfo: store.state.cashWalletState.drawInfo,
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      });
  }

  @override
  List<Object> get props => [community, drawInfo, plugins];
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
  final Function() identifyCall;
  final DrawInfo drawInfo;

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
    this.community,
    this.identifyCall,
    this.drawInfo
  });

  static CashWalletViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    bool isCommunityLoading = store.state.cashWalletState.isCommunityLoading;
    String branchAddress = store.state.cashWalletState.branchAddress;
    return CashWalletViewModel(
      drawInfo: store.state.cashWalletState.drawInfo,
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.cashWalletState.walletAddress,
      walletStatus: store.state.cashWalletState.walletStatus,
      communityAddress: communityAddres,
      branchAddress: branchAddress,
      isCommunityLoading: isCommunityLoading,
      isCommunityFetched: store.state.cashWalletState.isCommunityFetched,
      isBalanceFetchingStarted: store.state.cashWalletState.isBalanceFetchingStarted,
      isTransfersFetchingStarted: store.state.cashWalletState.isTransfersFetchingStarted ?? false,
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
      isContactsSynced: store.state.userState.isContactsSynced,
      isJobProcessingStarted: store.state.cashWalletState.isJobProcessingStarted,
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
      },
      identifyCall: () {
        String fullPhoneNumber = formatPhoneNumber(store.state.userState.phoneNumber, store.state.userState.countryCode);
        store.dispatch(enablePushNotifications());
        store.dispatch(segmentAliasCall(fullPhoneNumber));
        store.dispatch(segmentIdentifyCall(
            fullPhoneNumber,
            new Map<String, dynamic>.from({
              "Phone Number": fullPhoneNumber,
              "Wallet Address": store.state.cashWalletState.walletAddress,
              "Account Address": store.state.userState.accountAddress,
              "Display Name": store.state.userState.displayName
            })));
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
    isCommunityBusinessesFetched,
    drawInfo
  ];
}