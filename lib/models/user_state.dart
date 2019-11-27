import 'package:flutter/material.dart';

@immutable
class UserState {
  final List<String> mnemonic;
  final String privateKey;
  final String accountAddress;
  final String countryCode;
  final String phoneNumber;
  final String jwtToken;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;

  UserState(
    this.mnemonic,
    this.privateKey,
    this.accountAddress,
    this.countryCode,
    this.phoneNumber,
    this.jwtToken,
    this.loginRequestSuccess,
    this.loginVerifySuccess
  );

  factory UserState.initial() {
    return new UserState([], "", "", "", "", "", false, false);
  }

  UserState copyWith({
    List<String> mnemonic,
    String privateKey,
    String accountAddress,
    String countryCode,
    String phoneNumber,
    String jwtToken,
    bool loginRequestSuccess,
    bool loginVerifySuccess
  }) {
    return UserState (
      mnemonic ?? this.mnemonic,
      privateKey ?? this.privateKey,
      accountAddress ?? this.accountAddress,
      countryCode ?? this.countryCode,
      phoneNumber ?? this.phoneNumber,
      jwtToken ?? this.jwtToken,
      loginRequestSuccess ?? this.loginRequestSuccess,
      loginVerifySuccess ?? this.loginVerifySuccess
    );
  }
}