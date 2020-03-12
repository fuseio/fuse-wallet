import 'package:flutter/material.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  final Transactions transactions;

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isListenToTransferEvents;

  ProWalletState(
      {this.web3,
      this.isBalanceFetchingStarted,
      this.isListenToTransferEvents,
      this.transactions});

  factory ProWalletState.initial() {
    return new ProWalletState(
      web3: null,
      isBalanceFetchingStarted: false,
      isListenToTransferEvents: false,
      transactions: Transactions.initial(),
    );
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isBalanceFetchingStarted,
    bool isListenToTransferEvents,
    bool isJobProcessingStarted,
    String walletAddress,
    Transactions transactions,
  }) {
    return ProWalletState(
        web3: web3 ?? this.web3,
        isBalanceFetchingStarted:
            isBalanceFetchingStarted ?? this.isBalanceFetchingStarted,
        isListenToTransferEvents:
            isListenToTransferEvents ?? this.isListenToTransferEvents,
        transactions: transactions ?? this.transactions);
  }

  dynamic toJson() => _$ProWalletStateToJson(this);

  static ProWalletState fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}
