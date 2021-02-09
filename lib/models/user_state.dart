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
abstract class UserState with _$UserState {
  @JsonSerializable()
  factory UserState({
    @Default('') String walletStatus,
    @Default('') String walletAddress,
    @Default('') String communityManagerAddress,
    @Default('') String transferManagerAddress,
    @Default('') String daiPointsManagerAddress,
    List<String> networks,
    List<String> mnemonic,
    @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
        BiometricAuth authType,
    @Default('') String privateKey,
    @Default('') String pincode,
    @Default('') String accountAddress,
    @Default('') String countryCode,
    @Default('') String phoneNumber,
    @Default('') String normalizedPhoneNumber,
    @Default('') String isoCode,
    @JsonKey(ignore: true) List<Contact> contacts,
    @Default({}) Map<String, String> reverseContacts,
    List<String> syncedContacts,
    @Default('') String jwtToken,
    @Default('Anom') String displayName,
    @Default('') String avatarUrl,
    @Default('') String email,
    @Default('') String verificationId,
    @Default('') String identifier,
    @Default(false) bool isLoggedOut,
    @Default(false) bool isContactsSynced,
    @Default(false) bool backup,
    @JsonKey(ignore: true) PhoneAuthCredential credentials,
    int displayBalance,
    DateTime installedAt,
    @JsonKey(fromJson: currencyJson) @Default('usd') String currency,
    @Default(0) num totalBalance,
    @JsonKey(ignore: true) dynamic signupErrorMessage,
    @JsonKey(ignore: true) dynamic verifyErrorMessage,
    @Default(false) bool depositBannerShowed,
    @JsonKey(ignore: true) @Default(false) bool isLoginRequest,
    @JsonKey(ignore: true) @Default(false) bool isVerifyRequest,
    @JsonKey(ignore: true) @Default(false) bool homeBackupDialogShowed,
    @JsonKey(ignore: true) @Default(false) bool receiveBackupDialogShowed,
  }) = _UserState;

  factory UserState.fromJson(dynamic json) => _$UserStateFromJson(json);
}
