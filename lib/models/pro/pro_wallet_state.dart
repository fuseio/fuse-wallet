import 'package:flutter/material.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  final num blockNumber;
  final Map<String, Token> erc20Tokens;

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isListenToTransferEvents;

  ProWalletState({
    this.web3,
    this.blockNumber,
    this.isBalanceFetchingStarted,
    this.erc20Tokens,
    this.isListenToTransferEvents,
  });

  factory ProWalletState.initial() {
    return new ProWalletState(
      web3: null,
      blockNumber: 0,
      erc20Tokens: new Map<String, Token>(),
      isBalanceFetchingStarted: false,
      isListenToTransferEvents: false,
    );
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isBalanceFetchingStarted,
    bool isListenToTransferEvents,
    bool isJobProcessingStarted,
    String walletAddress,
    num blockNumber,
    Map<String, Token> erc20Tokens,
  }) {
    return ProWalletState(
      blockNumber: blockNumber ?? this.blockNumber,
      web3: web3 ?? this.web3,
      erc20Tokens: erc20Tokens ?? this.erc20Tokens,
      isBalanceFetchingStarted:
          isBalanceFetchingStarted ?? this.isBalanceFetchingStarted,
      isListenToTransferEvents:
          isListenToTransferEvents ?? this.isListenToTransferEvents,
    );
  }

  dynamic toJson() => _$ProWalletStateToJson(this);

  static ProWalletState fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}
