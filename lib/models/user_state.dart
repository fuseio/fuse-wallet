import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

String currencyJson(String currency) => currency == null ? 'usd' : currency;

BiometricAuth authTypeFromJson(String auth) => auth == null
    ? BiometricAuth.none
    : EnumToString.fromString(BiometricAuth.values, auth);

@immutable
@freezed
abstract class UserState implements _$UserState {
  const UserState._();

  @JsonSerializable()
  factory UserState({
    bool isContactsSynced,
    DateTime installedAt,
    bool isLoggedOut,
    bool backup,
    bool depositBannerShowed,
    bool homeBackupDialogShowed,
    @Default('') String walletAddress,
    @Default([]) List<String> networks,
    @Default([]) List<String> mnemonic,
    @Default('') String privateKey,
    @Default('') String pincode,
    @Default('') String accountAddress,
    @Default('') String countryCode,
    @Default('') String phoneNumber,
    @Default(false) bool receiveBackupDialogShowed,
    @Default('') String isoCode,
    @Default('') String jwtToken,
    @Default('Anom') String displayName,
    @Default('') String avatarUrl,
    @Default('') String email,
    @Default('') String verificationId,
    @Default('') String identifier,
    @Default(0) num totalBalance,
    @Default([]) List<String> syncedContacts,
    @Default({}) Map<String, String> reverseContacts,
    @JsonKey(ignore: true) dynamic signupErrorMessage,
    @JsonKey(ignore: true) dynamic verifyErrorMessage,
    @JsonKey(fromJson: currencyJson) @Default('usd') String currency,
    @JsonKey(ignore: true) @Default(false) bool isLoginRequest,
    @JsonKey(ignore: true) @Default(false) bool isVerifyRequest,
    @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
        BiometricAuth authType,
    @JsonKey(ignore: true) @Default([]) List<Contact> contacts,
    @JsonKey(ignore: true) PhoneAuthCredential credentials,
  }) = _UserState;

  factory UserState.inital() => UserState(
        networks: [],
        mnemonic: [],
        contacts: [],
        syncedContacts: [],
        reverseContacts: Map<String, String>(),
        displayName: "Anom",
        isContactsSynced: null,
        backup: false,
        authType: BiometricAuth.none,
        installedAt: DateTime.now().toUtc(),
        receiveBackupDialogShowed: false,
        homeBackupDialogShowed: false,
        currency: 'usd',
        totalBalance: 0,
      );

  factory UserState.fromJson(dynamic json) => _$UserStateFromJson(json);
}

class UserStateConverter
    implements JsonConverter<UserState, Map<String, dynamic>> {
  const UserStateConverter();

  @override
  UserState fromJson(Map<String, dynamic> json) =>
      json != null ? UserState.fromJson(json) : UserState();

  @override
  Map<String, dynamic> toJson(UserState instance) => instance?.toJson();
}
