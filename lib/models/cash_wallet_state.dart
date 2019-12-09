import 'package:flutter/material.dart';
import 'package:wallet_core/wallet_core.dart';
import './token.dart';
import './transfer.dart';

@immutable
class CashWalletState {
  final Web3 web3;
  final String walletAddress;
  final String walletStatus;
  final String communityAddress;
  final String communityName;
  final bool isCommunityLoading;
  final Token token;
  final BigInt tokenBalance;
  final List<Transfer> tokenTransfers;

  CashWalletState({
    this.web3,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.communityName,
    this.isCommunityLoading,
    this.token,
    this.tokenBalance,
    this.tokenTransfers
  });

  factory CashWalletState.initial() {
    return new CashWalletState(
      web3: null,
      walletAddress: "",
      walletStatus: null,
      communityAddress: "",
      communityName: "",
      isCommunityLoading: false,
      token: null,
      tokenBalance: BigInt.from(0),
      tokenTransfers: new List<Transfer>());
  }

  CashWalletState copyWith({
    Web3 web3,
    String walletAddress,
    String walletStatus,
    String communityAddress,
    String communityName,
    bool isCommunityLoading,
    Token token,
    BigInt tokenBalance,
    List<Transfer> tokenTransfers
  }) {
    return CashWalletState (
      web3: web3 ?? this.web3,
      walletAddress: walletAddress ?? this.walletAddress,
      walletStatus: walletStatus ?? this.walletStatus,
      communityAddress: communityAddress ?? this.communityAddress,
      communityName: communityName ?? this.communityName,
      isCommunityLoading: isCommunityLoading ?? this.isCommunityLoading,
      token: token ?? this.token,
      tokenBalance: tokenBalance ?? this.tokenBalance,
      tokenTransfers: tokenTransfers ?? this.tokenTransfers
    );
  }

    dynamic toJson() => {
      'walletAddress': walletAddress,
      'walletStatus': walletStatus,
      'communityAddress': communityAddress,
      'communityName': communityName
    };

    static CashWalletState fromJson(dynamic json) =>
      CashWalletState(
        web3: null,
        walletAddress: json['walletAddress'],
        walletStatus: json['walletStatus'],
        communityAddress: json['communityAddress'],
        communityName: json['communityName'],
        isCommunityLoading: false,
        token: null,
        tokenBalance: BigInt.from(0),
        tokenTransfers: new List<Transfer>()
      );
}