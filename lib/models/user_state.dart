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

  UserState({
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
  });

  factory UserState.initial() {
    return new UserState(
      mnemonic: [],
      privateKey: "",
      accountAddress: "",
      countryCode: "",
      phoneNumber: "",
      jwtToken: "",
      fullName: "Anom",
      email: "",
      loginRequestSuccess: false,
      loginVerifySuccess: false);
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
      mnemonic: mnemonic ?? this.mnemonic,
      privateKey: privateKey ?? this.privateKey,
      accountAddress: accountAddress ?? this.accountAddress,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      jwtToken: jwtToken ?? this.jwtToken,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      loginRequestSuccess: loginRequestSuccess ?? this.loginRequestSuccess,
      loginVerifySuccess: loginVerifySuccess ?? this.loginVerifySuccess
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
        mnemonic: List<String>.from(json['mnemonic']),
        privateKey: json['privateKey'],
        accountAddress: json['accountAddress'],
        countryCode: json['countryCode'],
        phoneNumber: json['phoneNumber'],
        jwtToken: json['jwtToken'],
        fullName: json['fullName'],
        email: json['email'],
        loginRequestSuccess: false,
        loginVerifySuccess: false,
      );
}