import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class UserState {
  final String walletStatus;
  final String walletAddress;
  final String communityManagerAddress;
  final String transferManagerAddress;
  final String daiPointsManagerAddress;
  final List<String> networks;
  final List<String> mnemonic;
  final String privateKey;
  final String pincode;
  final String accountAddress;
  final String countryCode;
  final String phoneNumber;
  final List<String> syncedContacts;
  final Map<String, String> reverseContacts;
  final String jwtToken;
  final String displayName;
  final String email;
  final String identifier;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final bool isLoggedOut;
  final bool isContactsSynced;
  final bool backup;
  final int displayBalance;
  final DateTime installedAt;
  final bool isProModeActivated;

  @JsonKey(ignore: true, defaultValue: false)
  final bool isProMode;
  @JsonKey(ignore: true)
  final List<Contact> contacts;

  UserState(
      {this.walletStatus,
      this.walletAddress,
      this.communityManagerAddress,
      this.transferManagerAddress,
      this.daiPointsManagerAddress,
      this.networks,
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
      this.identifier,
      this.loginRequestSuccess,
      this.loginVerifySuccess,
      this.isLoggedOut,
      this.isContactsSynced,
      this.backup,
      this.displayBalance,
      this.installedAt,
      this.isProMode,
      this.isProModeActivated});

  factory UserState.initial() {
    return new UserState(
        walletAddress: "",
        transferManagerAddress: "",
        communityManagerAddress: "",
        daiPointsManagerAddress: "",
        walletStatus: null,
        networks: [],
        mnemonic: [],
        privateKey: "",
        pincode: null,
        accountAddress: "",
        countryCode: "",
        phoneNumber: "",
        contacts: [],
        syncedContacts: [],
        reverseContacts: new Map<String, String>(),
        jwtToken: "",
        displayName: "Anom",
        email: "",
        identifier: "",
        loginRequestSuccess: false,
        loginVerifySuccess: false,
        isLoggedOut: false,
        isContactsSynced: null,
        backup: false,
        displayBalance: 0,
        installedAt: DateTime.now().toUtc(),
        isProMode: false,
        isProModeActivated: false);
  }

  UserState copyWith(
      {String walletAddress,
      String communityManagerAddress,
      String transferManagerAddress,
      String daiPointsManagerAddress,
      String walletStatus,
      List<String> networks,
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
      String identifier,
      bool loginRequestSuccess,
      bool loginVerifySuccess,
      bool isLoggedOut,
      bool isContactsSynced,
      bool backup,
      int displayBalance,
      DateTime installedAt,
      bool isProMode,
      bool isProModeActivated}) {
    return UserState(
        walletAddress: walletAddress ?? this.walletAddress,
        communityManagerAddress: communityManagerAddress ?? this.communityManagerAddress,
        transferManagerAddress: transferManagerAddress ?? this.transferManagerAddress,
        walletStatus: walletStatus ?? this.walletStatus,
        networks: networks ?? this.networks,
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
        identifier: identifier ?? this.identifier,
        loginRequestSuccess: loginRequestSuccess ?? this.loginRequestSuccess,
        loginVerifySuccess: loginVerifySuccess ?? this.loginVerifySuccess,
        isLoggedOut: isLoggedOut ?? this.isLoggedOut,
        isContactsSynced: isContactsSynced ?? this.isContactsSynced,
        backup: backup ?? this.backup,
        displayBalance: displayBalance ?? this.displayBalance,
        installedAt: installedAt ?? this.installedAt,
        isProMode: isProMode ?? this.isProMode,
        isProModeActivated: isProModeActivated ?? this.isProModeActivated);
  }

  dynamic toJson() => _$UserStateToJson(this);

  static UserState fromJson(dynamic json) => _$UserStateFromJson(json);
}
