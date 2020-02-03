import 'package:flutter/material.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/models/transactions.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import './token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CashWalletState {
  final String walletStatus;
  final String walletAddress;
  final String communityAddress;
  final String communityName;
  @JsonKey(
      name: 'communities',
      fromJson: _communitiesFromJson,
      toJson: _communitiesToJson)
  final Map<String, Community> communities;
  final bool isCommunityLoading;

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true)
  final String branchAddress;
  @JsonKey(ignore: true)
  final bool isCommunityFetched;
  @JsonKey(ignore: true)
  final bool isCommunityBusinessesFetched;
  @JsonKey(ignore: true)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true)
  final bool isTransfersFetchingStarted;
  @JsonKey(ignore: true)
  final bool isListeningToBranch;
  @JsonKey(ignore: true)
  final bool isBranchDataReceived;
  @JsonKey(ignore: true)
  final bool isJobProcessingStarted;
  @JsonKey(ignore: true)
  final Map<String, num> sendToInvites;

  static Map<String, Community> _communitiesFromJson(
      Map<String, dynamic> list) {
    if (list == null) {
      return Map<String, Community>();
    } else {
      Map<String, Community> communities = new Map<String, Community>();
      Iterable<MapEntry<String, Community>> entries =
          List.from(list['communities']).map((community) => new MapEntry(
              (community['address'] as String).toLowerCase(),
              Community.fromJson(community)));
      communities.addEntries(entries);
      return communities;
    }
  }

  static Map<String, dynamic> _communitiesToJson(
          Map<String, Community> communities) =>
      new Map<String, dynamic>.from({
        "communities": List<Community>.from(communities.values)
            .map((community) => community.toJson())
            .toList()
      });

  CashWalletState(
      {this.web3,
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
      this.isBranchDataReceived,
      this.isCommunityBusinessesFetched,
      this.isJobProcessingStarted,
      this.communities});

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
        isBranchDataReceived: false,
        isCommunityBusinessesFetched: false,
        isBalanceFetchingStarted: false,
        isTransfersFetchingStarted: false,
        isJobProcessingStarted: false,
        sendToInvites: new Map<String, num>(),
        communities: new Map<String, Community>());
  }

  CashWalletState copyWith(
      {wallet_core.Web3 web3,
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
      bool isBranchDataReceived,
      bool isJobProcessingStarted,
      Token token,
      BigInt tokenBalance,
      Map<String, num> sendToInvites,
      Transactions transactions,
      Plugins plugins,
      Map<String, Community> communities}) {
    return CashWalletState(
        web3: web3 ?? this.web3,
        walletAddress: walletAddress ?? this.walletAddress,
        walletStatus: walletStatus ?? this.walletStatus,
        communityAddress: communityAddress ?? this.communityAddress,
        branchAddress: branchAddress ?? this.branchAddress,
        communityName: communityName ?? this.communityName,
        isCommunityLoading: isCommunityLoading ?? this.isCommunityLoading,
        isCommunityFetched: isCommunityFetched ?? this.isCommunityFetched,
        isCommunityBusinessesFetched:
            isCommunityBusinessesFetched ?? this.isCommunityBusinessesFetched,
        isBalanceFetchingStarted:
            isBalanceFetchingStarted ?? this.isBalanceFetchingStarted,
        isTransfersFetchingStarted:
            isTransfersFetchingStarted ?? this.isTransfersFetchingStarted,
        isListeningToBranch: isListeningToBranch ?? this.isListeningToBranch,
        isBranchDataReceived: isBranchDataReceived ?? this.isBranchDataReceived,
        isJobProcessingStarted:
            isJobProcessingStarted ?? this.isJobProcessingStarted,
        sendToInvites: sendToInvites ?? this.sendToInvites,
        communities: communities ?? this.communities);
  }

  dynamic toJson() => _$CashWalletStateToJson(this);

  static CashWalletState fromJson(dynamic json) =>
      _$CashWalletStateFromJson(json);
}
