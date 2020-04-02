import 'package:flutter/material.dart';
import 'package:supervenica/models/pro/token.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  final List<Token> tokens;
  final num blockNumber;

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isListenToTransferEvents;

  ProWalletState(
      {this.web3,
      this.blockNumber,
      this.tokens,
      this.isBalanceFetchingStarted,
      this.isListenToTransferEvents,
      });

  factory ProWalletState.initial() {
    return new ProWalletState(
      web3: null,
      blockNumber: 0,
      tokens: new List<Token>(),
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
    List<Token> tokens,
    num blockNumber,
  }) {
    return ProWalletState(
      blockNumber: blockNumber ?? this.blockNumber,
        web3: web3 ?? this.web3,
        tokens: tokens ?? this.tokens,
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
