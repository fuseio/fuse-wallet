import 'package:flutter/material.dart';
import 'package:wallet_core/wallet_core.dart';

@immutable
class CashWalletState {
  final Web3 web3;
  final String publicKey;
  final String walletAddress;
  final String communityAddress;
  final String tokenAddress;
  final String tokenName;
  final String tokenSymbol;

  CashWalletState(
    this.web3,
    this.publicKey,
    this.walletAddress,
    this.communityAddress,
    this.tokenAddress,
    this.tokenName,
    this.tokenSymbol
  );

  factory CashWalletState.initial() {
    return new CashWalletState(null, "", "", "", "", "", "");
  }

  CashWalletState copyWith({
    Web3 web3,
    String publicKey,
    String walletAddress,
    String communityAddress,
    String tokenAddress,
    String tokenName,
    String tokenSymbol
  }) {
    return CashWalletState (
      web3 ?? this.web3,
      publicKey ?? this.publicKey,
      walletAddress ?? this.walletAddress,
      communityAddress ?? this.communityAddress,
      tokenAddress ?? this.tokenAddress,
      tokenName ?? this.tokenName,
      tokenSymbol ?? this.tokenSymbol
    );
  }
}