import 'package:flutter/material.dart';
import 'package:BIM/models/pro/token.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  final num blockNumber;
  @JsonKey(fromJson: _erc20TokensFromJson)
  final Map<String, Token> erc20Tokens;

  static Map<String, Token> _erc20TokensFromJson(Map<String, dynamic> json) =>
      json == null
          ? Map<String, Token>()
          : json.map((k, e) => MapEntry(k, Token.fromJson(e as Map<String, dynamic>)));

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

  ProWalletState({
    this.web3,
    this.blockNumber,
    this.erc20Tokens,
    this.isFetchTransferEvents,
    this.isListenToTransferEvents,
    this.isProcessingTokensJobs,
    this.isFetchTokensBalances,
  });

  factory ProWalletState.initial() {
    return new ProWalletState(
      web3: null,
      blockNumber: 0,
      erc20Tokens: new Map<String, Token>(),
      isFetchTransferEvents: false,
      isProcessingTokensJobs: false,
      isListenToTransferEvents: false,
      isFetchTokensBalances: false,
    );
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isListenToTransferEvents,
    bool isJobProcessingStarted,
    String walletAddress,
    num blockNumber,
    Map<String, Token> erc20Tokens,
    bool isProcessingTokensJobs,
    bool isFetchTransferEvents,
    bool isFetchTokensBalances,
  }) {
    return ProWalletState(
      isProcessingTokensJobs:
          isProcessingTokensJobs ?? this.isProcessingTokensJobs,
      isFetchTransferEvents:
          isFetchTransferEvents ?? this.isFetchTransferEvents,
      blockNumber: blockNumber ?? this.blockNumber,
      web3: web3 ?? this.web3,
      erc20Tokens: erc20Tokens ?? this.erc20Tokens,
      isListenToTransferEvents:
          isListenToTransferEvents ?? this.isListenToTransferEvents,
      isFetchTokensBalances: isFetchTokensBalances ?? this.isFetchTokensBalances,
    );
  }

  dynamic toJson() => _$ProWalletStateToJson(this);

  static ProWalletState fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}
