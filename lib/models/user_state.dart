import 'package:flutter/material.dart';

@immutable
class UserState {
  final List<String> mnemonic;
  final String privateKey;
  final String countryCode;
  final String phoneNumber;
  final String jwtToken;

  UserState(
    this.mnemonic,
    this.privateKey,
    this.countryCode,
    this.phoneNumber,
    this.jwtToken
  );

  factory UserState.initial() {
    return new UserState([], "", "", "", "");
  }

  UserState copyWith({
    List<String> mnemonic,
    String privateKey,
    String countryCode,
    String phoneNumber,
    String jwtToken
  }) {
    return UserState (
      mnemonic ?? this.mnemonic,
      privateKey ?? this.privateKey,
      countryCode ?? this.countryCode,
      phoneNumber ?? this.phoneNumber,
      jwtToken ?? this.jwtToken
    );
  }
}