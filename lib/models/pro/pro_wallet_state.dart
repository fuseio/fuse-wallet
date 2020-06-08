import 'package:flutter/material.dart';
import 'package:fusecash/models/jobs/swap_token_job.dart';
import 'package:fusecash/models/pro/token.dart';
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

  @JsonKey(ignore: true)
  final Map<String, SwapTokenJob> swapActions;

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

  ProWalletState({
    this.web3,
    this.blockNumber,
    this.etherBalance,
    this.erc20Tokens,
    this.swapActions,
    this.isFetchTransferEvents,
    this.isListenToTransferEvents,
    this.isProcessingTokensJobs,
    this.isFetchTokensBalances,
    this.isProcessingSwapActions,
  });

  factory ProWalletState.initial() {
    return new ProWalletState(
        web3: null,
        blockNumber: 0,
        erc20Tokens: new Map<String, Token>(),
        swapActions: new Map<String, SwapTokenJob>(),
        isFetchTransferEvents: false,
        etherBalance: BigInt.zero,
        isProcessingTokensJobs: false,
        isListenToTransferEvents: false,
        isFetchTokensBalances: false,
        isProcessingSwapActions: false);
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isListenToTransferEvents,
    bool isJobProcessingStarted,
    bool isProcessingSwapActions,
    String walletAddress,
    num blockNumber,
    Map<String, Token> erc20Tokens,
    Map<String, SwapTokenJob> swapActions,
    bool isProcessingTokensJobs,
    bool isFetchTransferEvents,
    bool isFetchTokensBalances,
    BigInt etherBalance,
  }) {
    return ProWalletState(
      isProcessingSwapActions:
          isProcessingSwapActions ?? this.isProcessingSwapActions,
      swapActions: swapActions ?? this.swapActions,
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
