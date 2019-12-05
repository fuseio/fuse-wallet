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
  final Token token;
  final BigInt tokenBalance;
  final List<Transfer> tokenTransfers;

  CashWalletState(
    this.web3,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.communityName,
    this.token,
    this.tokenBalance,
    this.tokenTransfers
  );

  factory CashWalletState.initial() {
    return new CashWalletState(null, "", null, "", "", null, BigInt.from(0), new List<Transfer>());
  }

  CashWalletState copyWith({
    Web3 web3,
    String walletAddress,
    String walletStatus,
    String communityAddress,
    String communityName,
    Token token,
    BigInt tokenBalance,
    List<Transfer> tokenTransfers
  }) {
    return CashWalletState (
      web3 ?? this.web3,
      walletAddress ?? this.walletAddress,
      walletStatus ?? this.walletStatus,
      communityAddress ?? this.communityAddress,
      communityName ?? this.communityName,
      token ?? this.token,
      tokenBalance ?? this.tokenBalance,
      tokenTransfers ?? this.tokenTransfers
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
        null,
        json['walletAddress'],
        json['walletStatus'],
        json['communityAddress'],
        json['communityName'],
        null,
        BigInt.from(0),
        new List<Transfer>()
      );
}