import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:wallet_core/wallet_core.dart' show Web3;
import 'package:json_annotation/json_annotation.dart';

part 'cash_wallet_state.freezed.dart';
part 'cash_wallet_state.g.dart';

Map<String, Token> tokensFromJson(Map<String, dynamic> tokens) => tokens == null
    ? Map<String, Token>()
    : tokens
        .map((k, e) => MapEntry(k, Token.fromJson(e as Map<String, dynamic>)));

Map<String, dynamic> communitiesToJson(Map<String, Community> communities) =>
    Map<String, dynamic>.from({
      "communities": List<Community>.from(communities.values)
          .map((community) => community.toJson())
          .toList()
    });

Map<String, Community> communitiesFromJson(Map<String, dynamic> list) {
  if (list == null) {
    return Map<String, Community>();
  } else {
    Map<String, Community> communities = Map<String, Community>();
    Iterable<MapEntry<String, Community>> entries =
        List.from(list['communities']).map((community) => MapEntry(
            (community['address'] as String).toLowerCase(),
            Community.fromJson(community)));
    communities.addEntries(entries);
    return communities;
  }
}

@immutable
@freezed
abstract class CashWalletState implements _$CashWalletState {
  const CashWalletState._();

  @JsonSerializable()
  factory CashWalletState({
    String communityAddress,
    @JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
    @JsonKey(name: 'communities', fromJson: communitiesFromJson, toJson: communitiesToJson)
        Map<String, Community> communities,
    // @JsonKey(ignore: true) Web3 web3,
    @JsonKey(ignore: true) String branchAddress,
    @JsonKey(ignore: true) @Default(false) bool isCommunityLoading,
    @JsonKey(ignore: true) @Default(false) bool isCommunityFetched,
    @JsonKey(ignore: true) @Default(false) bool isBalanceFetchingStarted,
    @JsonKey(ignore: true) @Default(false) bool isTransfersFetchingStarted,
    @JsonKey(ignore: true) @Default(false) bool isListeningToBranch,
    @JsonKey(ignore: true) @Default(false) bool isBranchDataReceived,
    @JsonKey(ignore: true) @Default(false) bool isCommunityBusinessesFetched,
    @JsonKey(ignore: true) @Default(false) bool isJobProcessingStarted,
  }) = _CashWalletState;

  factory CashWalletState.initial() {
    return CashWalletState(
      communities: Map<String, Community>(),
      tokens: Map<String, Token>(),
    );
  }

  factory CashWalletState.fromJson(dynamic json) =>
      _$CashWalletStateFromJson(json);
}

class CashWalletStateConverter
    implements JsonConverter<CashWalletState, Map<String, dynamic>> {
  const CashWalletStateConverter();

  @override
  CashWalletState fromJson(Map<String, dynamic> json) =>
      json != null ? CashWalletState.fromJson(json) : CashWalletState();

  @override
  Map<String, dynamic> toJson(CashWalletState instance) => instance?.toJson();
}
