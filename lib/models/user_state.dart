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
  final String displayName;
  final String email;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final bool isLoggedOut;
  final bool isContactsSynced;

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
    this.displayName,
    this.email,
    this.loginRequestSuccess,
    this.loginVerifySuccess,
    this.isLoggedOut,
    this.isContactsSynced
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
      displayName: "Anom",
      email: "",
      loginRequestSuccess: false,
      loginVerifySuccess: false,
      isLoggedOut: false,
      isContactsSynced: false
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
    String displayName,
    String email,
    bool loginRequestSuccess,
    bool loginVerifySuccess,
    bool isLoggedOut,
    bool isContactsSynced
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
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      loginRequestSuccess: loginRequestSuccess ?? this.loginRequestSuccess,
      loginVerifySuccess: loginVerifySuccess ?? this.loginVerifySuccess,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
      isContactsSynced: isContactsSynced ?? this.isContactsSynced
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
      'displayName': displayName,
      'email': email,
      'isLoggedOut': isLoggedOut,
      'isContactsSynced': isContactsSynced
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
        displayName: json['displayName'],
        email: json['email'],
        loginRequestSuccess: false,
        loginVerifySuccess: false,
        isLoggedOut: json['isLoggedOut'] == null ? false : json['isLoggedOut'],
        isContactsSynced: json['isContactsSynced'] == null ? false : json['isContactsSynced']
      );
    }
}