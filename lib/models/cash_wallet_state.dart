import 'package:flutter/material.dart';
import 'package:wallet_core/wallet_core.dart';

@immutable
class CashWalletState {
  final Web3 web3;
  final String publicKey;
  final String walletAddress;
  final String walletStatus;
  final String communityAddress;
  final String communityName;
  final String tokenAddress;
  final String tokenName;
  final String tokenSymbol;
  final int tokenDecimals;
  final BigInt tokenBalance;

  CashWalletState(
    this.web3,
    this.publicKey,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.communityName,
    this.tokenAddress,
    this.tokenName,
    this.tokenSymbol,
    this.tokenDecimals,
    this.tokenBalance
  );

  factory CashWalletState.initial() {
    return new CashWalletState(null, "", "", null, "", "", "", "", "", 18, 0);
  }

  CashWalletState copyWith({
    Web3 web3,
    String publicKey,
    String walletAddress,
    String walletStatus,
    String communityAddress,
    String communityName,
    String tokenAddress,
    String tokenName,
    String tokenSymbol,
    int tokenDecimals,
    dynamic tokenBalance
  }) {
    return CashWalletState (
      web3 ?? this.web3,
      publicKey ?? this.publicKey,
      walletAddress ?? this.walletAddress,
      walletStatus ?? this.walletStatus,
      communityAddress ?? this.communityAddress,
      communityName ?? this.communityName,
      tokenAddress ?? this.tokenAddress,
      tokenName ?? this.tokenName,
      tokenSymbol ?? this.tokenSymbol,
      tokenDecimals ?? this.tokenDecimals,
      tokenBalance ?? this.tokenBalance
    );
  }
}