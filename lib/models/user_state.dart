import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:esol/utils/biometric_local_auth.dart';
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
  final String isoCode;
  final String phoneNumber;
  final String normalizedPhoneNumber;
  final List<String> syncedContacts;
  final Map<String, String> reverseContacts;
  final String jwtToken;
  final String displayName;
  final String avatarUrl;
  final String email;
  final String verificationId;
  final String identifier;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final bool isLoggedOut;
  final bool isContactsSynced;
  final bool backup;
  final int displayBalance;
  final DateTime installedAt;
  @JsonKey(fromJson: _authTypeFromJson, toJson: EnumToString.convertToString)
  final BiometricAuth authType;
  final bool homeBackupDialogShowed;
  final bool receiveBackupDialogShowed;
  @JsonKey(fromJson: _currencyJson)
  final String currency;
  final num totalBalance;

  @JsonKey(ignore: true)
  final dynamic signupException;
  @JsonKey(ignore: true)
  final dynamic verifyException;
  @JsonKey(ignore: true)
  final bool isLoginRequest;
  @JsonKey(ignore: true)
  final bool isVerifyRequest;
  @JsonKey(ignore: true)
  final List<Contact> contacts;
  @JsonKey(ignore: true)
  final PhoneAuthCredential credentials;

  UserState(
      {this.walletStatus,
      this.walletAddress,
      this.communityManagerAddress,
      this.transferManagerAddress,
      this.daiPointsManagerAddress,
      this.networks,
      this.mnemonic,
      this.authType,
      this.privateKey,
      this.pincode,
      this.accountAddress,
      this.countryCode,
      this.phoneNumber,
      this.normalizedPhoneNumber,
      this.isoCode,
      this.contacts,
      this.reverseContacts,
      this.syncedContacts,
      this.jwtToken,
      this.displayName,
      this.avatarUrl,
      this.email,
      this.verificationId,
      this.identifier,
      this.loginRequestSuccess,
      this.loginVerifySuccess,
      this.isLoggedOut,
      this.isContactsSynced,
      this.backup,
      this.credentials,
      this.displayBalance,
      this.installedAt,
      this.isLoginRequest,
      this.isVerifyRequest,
      this.homeBackupDialogShowed,
      this.receiveBackupDialogShowed,
      this.currency,
      this.totalBalance,
      this.signupException,
      this.verifyException});

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
        isoCode: "",
        phoneNumber: "",
        normalizedPhoneNumber: "",
        contacts: [],
        syncedContacts: [],
        reverseContacts: new Map<String, String>(),
        jwtToken: "",
        displayName: "Anom",
        email: "",
        verificationId: "",
        identifier: "",
        loginRequestSuccess: false,
        loginVerifySuccess: false,
        isLoggedOut: false,
        isContactsSynced: null,
        backup: false,
        authType: BiometricAuth.none,
        credentials: null,
        displayBalance: 0,
        installedAt: DateTime.now().toUtc(),
        isLoginRequest: false,
        isVerifyRequest: false,
        receiveBackupDialogShowed: false,
        homeBackupDialogShowed: false,
        currency: 'usd',
        totalBalance: 0);
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
      String isoCode,
      String phoneNumber,
      String normalizedPhoneNumber,
      List<Contact> contacts,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      bool loginRequestSuccess,
      bool loginVerifySuccess,
      bool isLoggedOut,
      bool isContactsSynced,
      bool backup,
      PhoneAuthCredential credentials,
      int displayBalance,
      DateTime installedAt,
      bool isLoginRequest,
      bool isVerifyRequest,
      BiometricAuth authType,
      bool receiveBackupDialogShowed,
      bool homeBackupDialogShowed,
      String currency,
      num totalBalance,
      dynamic verifyException,
      dynamic signupException}) {
    return UserState(
        verifyException: verifyException ?? this.verifyException,
        signupException: signupException ?? this.signupException,
        authType: authType ?? this.authType,
        walletAddress: walletAddress ?? this.walletAddress,
        communityManagerAddress:
            communityManagerAddress ?? this.communityManagerAddress,
        transferManagerAddress:
            transferManagerAddress ?? this.transferManagerAddress,
        walletStatus: walletStatus ?? this.walletStatus,
        networks: networks ?? this.networks,
        mnemonic: mnemonic ?? this.mnemonic,
        privateKey: privateKey ?? this.privateKey,
        pincode: pincode ?? this.pincode,
        accountAddress: accountAddress ?? this.accountAddress,
        countryCode: countryCode ?? this.countryCode,
        isoCode: isoCode ?? this.isoCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        normalizedPhoneNumber:
            normalizedPhoneNumber ?? this.normalizedPhoneNumber,
        contacts: contacts ?? this.contacts,
        syncedContacts: syncedContacts ?? this.syncedContacts,
        reverseContacts: reverseContacts ?? this.reverseContacts,
        jwtToken: jwtToken ?? this.jwtToken,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        verificationId: verificationId ?? this.verificationId,
        identifier: identifier ?? this.identifier,
        loginRequestSuccess: loginRequestSuccess ?? this.loginRequestSuccess,
        loginVerifySuccess: loginVerifySuccess ?? this.loginVerifySuccess,
        isLoggedOut: isLoggedOut ?? this.isLoggedOut,
        isContactsSynced: isContactsSynced ?? this.isContactsSynced,
        backup: backup ?? this.backup,
        credentials: credentials ?? this.credentials,
        displayBalance: displayBalance ?? this.displayBalance,
        installedAt: installedAt ?? this.installedAt,
        isLoginRequest: isLoginRequest ?? this.isLoginRequest,
        isVerifyRequest: isVerifyRequest ?? this.isVerifyRequest,
        homeBackupDialogShowed:
            homeBackupDialogShowed ?? this.homeBackupDialogShowed,
        receiveBackupDialogShowed:
            receiveBackupDialogShowed ?? this.receiveBackupDialogShowed,
        currency: currency ?? this.currency,
        totalBalance: totalBalance ?? this.totalBalance);
  }

  static String _currencyJson(String currency) =>
      currency == null ? 'usd' : currency;

  static BiometricAuth _authTypeFromJson(String auth) => auth == null
      ? BiometricAuth.none
      : EnumToString.fromString(BiometricAuth.values, auth);

  dynamic toJson() => _$UserStateToJson(this);

  static UserState fromJson(dynamic json) => _$UserStateFromJson(json);
}
