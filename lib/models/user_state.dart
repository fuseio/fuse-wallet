import 'package:flutter/material.dart';

@immutable
class UserState {
  final List<String> mnemonic;
  final String privateKey;
  final String accountAddress;
  final String countryCode;
  final String phoneNumber;
  final String jwtToken;
  final String fullName;
  final String email;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;

  UserState(
    this.mnemonic,
    this.privateKey,
    this.accountAddress,
    this.countryCode,
    this.phoneNumber,
    this.jwtToken,
    this.fullName,
    this.email,
    this.loginRequestSuccess,
    this.loginVerifySuccess
  );

  factory UserState.initial() {
    return new UserState([], "", "", "", "", "", "Anom", "", false, false);
  }

  UserState copyWith({
    List<String> mnemonic,
    String privateKey,
    String accountAddress,
    String countryCode,
    String phoneNumber,
    String jwtToken,
    String fullName,
    String email,
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
      fullName ?? this.fullName,
      email ?? this.email,
      loginRequestSuccess ?? this.loginRequestSuccess,
      loginVerifySuccess ?? this.loginVerifySuccess
    );
  }

    dynamic toJson() => {
      'mnemonic': mnemonic,
      'privateKey': privateKey,
      'accountAddress': accountAddress,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'jwtToken': jwtToken,
      'fullName': fullName,
      'email': email
    };

    static UserState fromJson(dynamic json) =>
      UserState(
        List<String>.from(json['mnemonic']),
        json['privateKey'],
        json['accountAddress'],
        json['countryCode'],
        json['phoneNumber'],
        json['jwtToken'],
        json['fullName'],
        json['email'],
        false,
        false,
      );
}