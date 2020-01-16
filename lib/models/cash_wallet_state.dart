import 'package:flutter/material.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import './token.dart';
import './transaction.dart';

@immutable
class CashWalletState {
  final wallet_core.Web3 web3;
  final String walletAddress;
  final String walletStatus;
  final String branchAddress;
  final String communityName;
  final bool isCommunityLoading;
  final bool isCommunityFetched;
  final bool isCommunityBusinessesFetched;
  final bool isBalanceFetchingStarted;
  final bool isTransfersFetchingStarted;
  final bool isListeningToBranch;
  final BigInt tokenBalance;
  final Map<String, num> sendToInvites;
  // final List<Transfer> tokenTransfers;
  // final List<PendingTransfer> pendingTransfers;
  final Transactions transactions;
  final Plugins plugins;
  final String communityAddress;
  final Token token;
  final List<Business> businesses;

  final Map<String, Community> communities;

  CashWalletState({
    this.web3,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.branchAddress,
    this.sendToInvites,
    this.communityName,
    this.isCommunityLoading,
    this.isCommunityFetched,
    this.isBalanceFetchingStarted,
    this.isTransfersFetchingStarted,
    this.isListeningToBranch,
    this.token,
    this.tokenBalance,
    // this.tokenTransfers,
    // this.pendingTransfers,
    this.businesses,
    this.transactions,
    this.isCommunityBusinessesFetched,
    this.plugins,
    this.communities
  });

  factory CashWalletState.initial() {
    return new CashWalletState(
        web3: null,
        walletAddress: "",
        walletStatus: null,
        communityAddress: null,
        branchAddress: "",
        communityName: "",
        isCommunityLoading: false,
        isCommunityFetched: false,
        isListeningToBranch: false,
        isCommunityBusinessesFetched: false,
        isBalanceFetchingStarted: false,
        isTransfersFetchingStarted: false,
        token: null,
        tokenBalance: BigInt.from(0),
        // tokenTransfers: new List<Transfer>(),
        // pendingTransfers: new List<PendingTransfer>(),
        sendToInvites: new Map<String, num>(),
        businesses: new List<Business>(),
        transactions: new Transactions(list: new List<Transaction>()),
        plugins: new Plugins(),
        communities: new Map<String, Community>());
  }

  CashWalletState copyWith({
    wallet_core.Web3 web3,
    String walletAddress,
    String walletStatus,
    String communityAddress,
    String branchAddress,
    String communityName,
    bool isCommunityLoading,
    bool isCommunityFetched,
    bool isCommunityBusinessesFetched,
    bool isBalanceFetchingStarted,
    bool isTransfersFetchingStarted,
    bool isListeningToBranch,
    Token token,
    BigInt tokenBalance,
    // List<Transfer> tokenTransfers,
    // List<PendingTransfer> pendingTransfers,
    Map<String, num> sendToInvites,
    List<Business> businesses,
    Transactions transactions,
    Plugins plugins,
    Map<String, Community> communities
  }) {
    return CashWalletState(
        web3: web3 ?? this.web3,
        walletAddress: walletAddress ?? this.walletAddress,
        walletStatus: walletStatus ?? this.walletStatus,
        communityAddress: communityAddress ?? this.communityAddress,
        branchAddress: branchAddress ?? this.branchAddress,
        communityName: communityName ?? this.communityName,
        isCommunityLoading: isCommunityLoading ?? this.isCommunityLoading,
        isCommunityFetched: isCommunityFetched ?? this.isCommunityFetched,
        isCommunityBusinessesFetched: isCommunityBusinessesFetched ?? this.isCommunityBusinessesFetched,
        isBalanceFetchingStarted: isBalanceFetchingStarted ?? this.isBalanceFetchingStarted,
        isTransfersFetchingStarted: isTransfersFetchingStarted ?? this.isTransfersFetchingStarted,
        isListeningToBranch: isListeningToBranch ?? this.isListeningToBranch,
        token: token ?? this.token,
        tokenBalance: tokenBalance ?? this.tokenBalance,
        // tokenTransfers: tokenTransfers ?? this.tokenTransfers,
        // pendingTransfers: pendingTransfers ?? this.pendingTransfers,
        sendToInvites: sendToInvites ?? this.sendToInvites,
        businesses: businesses ?? this.businesses,
        transactions: transactions ?? this.transactions,
        plugins: plugins ?? this.plugins,
        communities: communities ?? this.communities
    );
  }

  dynamic toJson() => {
        'walletAddress': walletAddress,
        'walletStatus': walletStatus,
        'communityAddress': communityAddress,
        'communityName': communityName,
        'token': token?.toJson(),
        'tokenBalance': tokenBalance.toString(),
        'transactions': transactions.toJson(),
        'plugins': plugins.toJson(),
        'communities': List<Community>.from(communities.values)
            .map((community) => community.toJson())
            .toList()
      };

  static CashWalletState fromJson(dynamic json) {
    Map<String, Community> communities = new Map<String, Community>();
    Iterable<MapEntry<String, Community>> entries =
        List.from(json['communities']).map((community) => new MapEntry(community['address'], Community.fromJson(community)));
    communities.addEntries(entries);
    return CashWalletState(
        web3: null,
        walletAddress: json['walletAddress'],
        walletStatus: json['walletStatus'],
        communityAddress: json['communityAddress'],
        branchAddress: json['branchAddress'],
        communityName: json['communityName'],
        isCommunityLoading: json['isCommunityLoading'],
        isCommunityFetched: false,
        isCommunityBusinessesFetched: false,
        isBalanceFetchingStarted: false,
        isTransfersFetchingStarted: false,
        isListeningToBranch: false,
        token: json['token'] == null ? json['token'] : Token.fromJson(json['token']),
        tokenBalance: json['tokenBalance'] == null ? null : BigInt.parse(json['tokenBalance']),
        sendToInvites: new Map<String, num>(),
        transactions: Transactions.fromJson(json['transactions']),
        plugins: Plugins.fromJson(json["plugins"]),
        communities: json['communities'] != null ? communities : new Map<String, Community>()
    );
  }
}
