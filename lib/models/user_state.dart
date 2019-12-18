import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';  

@immutable
class UserState {
  final List<String> mnemonic;
  final String privateKey;
  final String accountAddress;
  final String countryCode;
  final String phoneNumber;
  final List<Contact> contacts;
  final List<String> syncedContacts;
  final Map<String, String> reverseContacts;
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
    this.contacts,
    this.reverseContacts,
    this.syncedContacts,
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
      contacts: null,
      syncedContacts: [],
      reverseContacts: new Map<String, String>(),
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
    List<Contact> contacts,
    List<String> syncedContacts,
    Map<String, String> reverseContacts,
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
      contacts: contacts ?? this.contacts,
      syncedContacts: syncedContacts ?? this.syncedContacts,
      reverseContacts: reverseContacts ?? this.reverseContacts,
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
      'reverseContacts': jsonEncode(reverseContacts),
      'syncedContacts': jsonEncode(syncedContacts),
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
        contacts: null,
        reverseContacts: json['reverseContacts'] == null ? new Map<String, String>(): Map<String, String>.from(jsonDecode(json['reverseContacts'])),
        syncedContacts: json['syncedContacts'] == null ? new List<String>(): List<String>.from(jsonDecode(json['syncedContacts'])),
        jwtToken: json['jwtToken'],
        fullName: json['fullName'],
        email: json['email'],
        loginRequestSuccess: false,
        loginVerifySuccess: false,
      );
}