import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';  
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);


@immutable
class UserState {
  final List<String> mnemonic;
  final String privateKey;
  final String pincode;
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
  final bool isLoggedOut;

  UserState({
    this.mnemonic,
    this.privateKey,
    this.pincode,
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
    this.loginVerifySuccess,
    this.isLoggedOut
  });

  factory UserState.initial() {
    return new UserState(
      mnemonic: [],
      privateKey: "",
      pincode: null,
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
      loginVerifySuccess: false,
      isLoggedOut: false
      );
  }

  UserState copyWith({
    List<String> mnemonic,
    String privateKey,
    String pincode,
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
    bool loginVerifySuccess,
    bool isLoggedOut
  }) {
    return UserState (
      mnemonic: mnemonic ?? this.mnemonic,
      privateKey: privateKey ?? this.privateKey,
      pincode: pincode ?? this.pincode,
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
      loginVerifySuccess: loginVerifySuccess ?? this.loginVerifySuccess,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut
    );
  }

    dynamic toJson() => {
      'mnemonic': mnemonic,
      'privateKey': privateKey,
      'pincode': pincode,
      'accountAddress': accountAddress,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'reverseContacts': jsonEncode(reverseContacts),
      'syncedContacts': jsonEncode(syncedContacts),
      'jwtToken': jwtToken,
      'fullName': fullName,
      'email': email
    };

    static UserState fromJson(dynamic json) {
      logger.d('fromJson:');
      logger.d('mnemonic: ${json['mnemonic']}');
      logger.d('privateKey: ${json['privateKey']}');
      logger.d('accountAddress: ${json['accountAddress']}');
      logger.d('jwtToken: ${json['jwtToken']}');
      logger.d('end fromJson');

      return UserState(
        mnemonic: List<String>.from(json['mnemonic']),
        privateKey: json['privateKey'],
        pincode: json['pincode'],
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
        isLoggedOut: false
      );
    }
}