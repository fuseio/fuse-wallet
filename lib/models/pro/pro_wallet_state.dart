import 'package:flutter/material.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  @JsonKey(fromJson: _etherBalanceFromJson)
  final BigInt etherBalance;
  final num blockNumber;
  @JsonKey(fromJson: _erc20TokensFromJson)
  final Map<String, Token> erc20Tokens;

  static BigInt _etherBalanceFromJson(String etherBalance) =>
      etherBalance == null ? BigInt.zero : BigInt.parse(etherBalance);

  static Map<String, Token> _erc20TokensFromJson(Map<String, dynamic> json) =>
      json == null
          ? Map<String, Token>()
          : json.map(
              (k, e) => MapEntry(k, Token.fromJson(e as Map<String, dynamic>)));

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isListenToTransferEvents;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isFetchTransferEvents;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isProcessingTokensJobs;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isFetchTokensBalances;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isProcessingSwapActions;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isFetchTokensLastestPrice;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isFetchNewTokens;

  ProWalletState(
      {this.web3,
      this.blockNumber,
      this.etherBalance,
      this.erc20Tokens,
      this.isFetchTransferEvents,
      this.isListenToTransferEvents,
      this.isProcessingTokensJobs,
      this.isFetchTokensBalances,
      this.isProcessingSwapActions,
      this.isFetchTokensLastestPrice,
      this.isFetchNewTokens});

  factory ProWalletState.initial() {
    return new ProWalletState(
        web3: null,
        blockNumber: 0,
        erc20Tokens: new Map<String, Token>(),
        isFetchTransferEvents: false,
        etherBalance: BigInt.zero,
        isProcessingTokensJobs: false,
        isListenToTransferEvents: false,
        isFetchTokensBalances: false,
        isProcessingSwapActions: false,
        isFetchTokensLastestPrice: false,
        isFetchNewTokens: false);
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isListenToTransferEvents,
    bool isJobProcessingStarted,
    bool isProcessingSwapActions,
    String walletAddress,
    num blockNumber,
    Map<String, Token> erc20Tokens,
    bool isProcessingTokensJobs,
    bool isFetchTransferEvents,
    bool isFetchTokensBalances,
    BigInt etherBalance,
    bool isFetchTokensLastestPrice,
    bool isFetchNewTokens,
  }) {
    return ProWalletState(
      isFetchNewTokens: isFetchNewTokens ?? this.isFetchNewTokens,
      isFetchTokensLastestPrice:
          isFetchTokensLastestPrice ?? this.isFetchTokensLastestPrice,
      isProcessingSwapActions:
          isProcessingSwapActions ?? this.isProcessingSwapActions,
      etherBalance: etherBalance ?? this.etherBalance,
      isProcessingTokensJobs:
          isProcessingTokensJobs ?? this.isProcessingTokensJobs,
      isFetchTransferEvents:
          isFetchTransferEvents ?? this.isFetchTransferEvents,
      blockNumber: blockNumber ?? this.blockNumber,
      web3: web3 ?? this.web3,
      erc20Tokens: erc20Tokens ?? this.erc20Tokens,
      isListenToTransferEvents:
          isListenToTransferEvents ?? this.isListenToTransferEvents,
      isFetchTokensBalances:
          isFetchTokensBalances ?? this.isFetchTokensBalances,
    );
  }

  dynamic toJson() => _$ProWalletStateToJson(this);

  static ProWalletState fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}
