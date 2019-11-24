import 'package:flutter/material.dart';

@immutable
class CashWalletState {
  final String publicKey;
  final String walletAddress;

  CashWalletState(
    this.publicKey,
    this.walletAddress
  );

  factory CashWalletState.initial() {
    return new CashWalletState("", "");
  }

  CashWalletState copyWith(
    String publicKey,
    String walletAddress
  ) {
    return CashWalletState (
      publicKey ?? this.publicKey,
      walletAddress ?? this.walletAddress
    );
  }
}