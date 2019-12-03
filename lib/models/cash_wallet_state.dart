import 'package:flutter/material.dart';
import 'package:wallet_core/wallet_core.dart';

@immutable
class CashWalletState {
  final Web3 web3;
  final String walletAddress;
  final String walletStatus;
  final String communityAddress;
  final String communityName;
  final String tokenAddress;
  final String tokenName;
  final String tokenSymbol;
  final int tokenDecimals;
  final BigInt tokenBalance;
  final List tokenTransfersList;

  CashWalletState(
    this.web3,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.communityName,
    this.tokenAddress,
    this.tokenName,
    this.tokenSymbol,
    this.tokenDecimals,
    this.tokenBalance,
    this.tokenTransfersList
  );

  factory CashWalletState.initial() {
    return new CashWalletState(null, "", null, "", "", "", "", "", 18, BigInt.from(0), []);
  }

  CashWalletState copyWith({
    Web3 web3,
    String walletAddress,
    String walletStatus,
    String communityAddress,
    String communityName,
    String tokenAddress,
    String tokenName,
    String tokenSymbol,
    int tokenDecimals,
    BigInt tokenBalance,
    List tokenTransfersList
  }) {
    return CashWalletState (
      web3 ?? this.web3,
      walletAddress ?? this.walletAddress,
      walletStatus ?? this.walletStatus,
      communityAddress ?? this.communityAddress,
      communityName ?? this.communityName,
      tokenAddress ?? this.tokenAddress,
      tokenName ?? this.tokenName,
      tokenSymbol ?? this.tokenSymbol,
      tokenDecimals ?? this.tokenDecimals,
      tokenBalance ?? this.tokenBalance,
      tokenTransfersList ?? this.tokenTransfersList
    );
  }

    dynamic toJson() => {
      'walletAddress': walletAddress,
      'walletStatus': walletStatus,
      'communityAddress': communityAddress,
      'communityName': communityName,
      'tokenAddress': tokenAddress
    };

    static CashWalletState fromJson(dynamic json) =>
      CashWalletState(
        null,
        json['walletAddress'],
        json['walletStatus'],
        json['communityAddress'],
        json['communityName'],
        json['tokenAddress'],
        '',
        '',
        0,
        BigInt.from(0),
        null
      );
}