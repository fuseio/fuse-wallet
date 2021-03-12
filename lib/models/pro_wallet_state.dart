import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.freezed.dart';
part 'pro_wallet_state.g.dart';

BigInt etherBalanceFromJson(String etherBalance) =>
    etherBalance == null ? BigInt.zero : BigInt.parse(etherBalance);

Map<String, Token> erc20TokensFromJson(Map<String, dynamic> json) =>
    json == null
        ? Map<String, Token>()
        : json.map(
            (k, e) => MapEntry(k, Token.fromJson(e as Map<String, dynamic>)));

@immutable
@freezed
abstract class ProWalletState implements _$ProWalletState {
  const ProWalletState._();

  @JsonSerializable()
  factory ProWalletState({
    @JsonKey(fromJson: etherBalanceFromJson) BigInt etherBalance,
    @JsonKey(fromJson: erc20TokensFromJson)
    @Default({})
        Map<String, Token> erc20Tokens,
    @JsonKey(ignore: true) @Default(false) bool isFetchTransferEvents,
    @JsonKey(ignore: true) @Default(false) bool isListenToTransferEvents,
    @JsonKey(ignore: true) @Default(false) bool isProcessingTokensJobs,
    @JsonKey(ignore: true) @Default(false) bool isFetchTokensBalances,
    @JsonKey(ignore: true) @Default(false) bool isProcessingSwapActions,
    @JsonKey(ignore: true) @Default(false) bool isFetchTokensLatestPrice,
    @JsonKey(ignore: true) @Default(false) bool isFetchNewTokens,
  }) = _ProWalletState;

  factory ProWalletState.initial() {
    return ProWalletState(
      erc20Tokens: Map<String, Token>(),
      etherBalance: BigInt.zero,
    );
  }

  factory ProWalletState.fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}

class ProWalletStateConverter
    implements JsonConverter<ProWalletState, Map<String, dynamic>> {
  const ProWalletStateConverter();

  @override
  ProWalletState fromJson(Map<String, dynamic> json) =>
      json != null ? ProWalletState.fromJson(json) : ProWalletState.initial();

  @override
  Map<String, dynamic> toJson(ProWalletState instance) => instance?.toJson();
}
