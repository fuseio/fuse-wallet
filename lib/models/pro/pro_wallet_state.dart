import 'package:flutter/material.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
// import './token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  final String walletStatus;
  final String walletAddress;
  // final String communityManagerAddress;
  // final String transferManagerAddress;
  final Transactions transactions;

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isTransfersFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isJobProcessingStarted;

  ProWalletState(
      {this.web3,
      this.walletAddress,
      this.walletStatus,
      this.isBalanceFetchingStarted,
      this.isTransfersFetchingStarted,
      this.isJobProcessingStarted,
      this.transactions});

  factory ProWalletState.initial() {
    return new ProWalletState(
      web3: null,
      walletStatus: null,
      isBalanceFetchingStarted: false,
      isTransfersFetchingStarted: false,
      isJobProcessingStarted: false,
      transactions: Transactions.initial(),
    );
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isBalanceFetchingStarted,
    bool isTransfersFetchingStarted,
    bool isJobProcessingStarted,
    String walletAddress,
    Transactions transactions,
  }) {
    return ProWalletState(
        walletAddress: walletAddress ?? this.walletAddress,
        web3: web3 ?? this.web3,
        isBalanceFetchingStarted:
            isBalanceFetchingStarted ?? this.isBalanceFetchingStarted,
        isTransfersFetchingStarted:
            isTransfersFetchingStarted ?? this.isTransfersFetchingStarted,
        isJobProcessingStarted:
            isJobProcessingStarted ?? this.isJobProcessingStarted,
        transactions: transactions ?? this.transactions);
  }

  dynamic toJson() => _$ProWalletStateToJson(this);

  static ProWalletState fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}
