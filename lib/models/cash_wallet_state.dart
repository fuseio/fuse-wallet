import 'package:flutter/material.dart';
import 'package:esol/models/community/community.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'cash_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CashWalletState {
  final String communityAddress;
  @JsonKey(
      name: 'communities',
      fromJson: _communitiesFromJson,
      toJson: _communitiesToJson)
  final Map<String, Community> communities;

  @JsonKey(ignore: true, defaultValue: false)
  final bool isCommunityLoading;
  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true)
  final String branchAddress;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isCommunityFetched;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isCommunityBusinessesFetched;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isTransfersFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isListeningToBranch;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBranchDataReceived;
  @JsonKey(ignore: true, defaultValue: false)
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
      this.communityAddress,
      this.branchAddress,
      this.sendToInvites,
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
        communityAddress: null,
        branchAddress: "",
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
      String communityAddress,
      String branchAddress,
      bool isCommunityLoading,
      bool isCommunityFetched,
      bool isCommunityBusinessesFetched,
      bool isBalanceFetchingStarted,
      bool isTransfersFetchingStarted,
      bool isListeningToBranch,
      bool isBranchDataReceived,
      bool isJobProcessingStarted,
      Map<String, num> sendToInvites,
      Map<String, Community> communities}) {
    return CashWalletState(
        web3: web3 ?? this.web3,
        communityAddress: communityAddress ?? this.communityAddress,
        branchAddress: branchAddress ?? this.branchAddress,
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
