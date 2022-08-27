import 'package:charge_wallet_sdk/models/wallet_modules/wallet_modules.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/constants/enums.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

Locale localeFromJson(Map<String, dynamic> map) =>
    Locale(map['languageCode'], map['countryCode']);

Map<String, dynamic> localeToJson(Locale? locale) => locale == null
    ? {'languageCode': 'en', 'countryCode': 'US'}
    : {'languageCode': locale.languageCode, 'countryCode': locale.countryCode};

@freezed
class UserState with _$UserState {
  const UserState._();

  factory UserState({
    @JsonKey(ignore: true) String? wcURI,
    String? contractVersion,
    WalletModules? walletModules,
    DateTime? installedAt,
    bool? isContactsSynced,
    @Default(false) bool isLoggedOut,
    @Default(false) bool backup,
    @Default(false) bool scrollToTop,
    @Default('') String walletAddress,
    @Default([]) List<String> networks,
    @Default([]) List<String> mnemonic,
    @Default('') String privateKey,
    @Default('') String pincode,
    @Default('') String accountAddress,
    @Default('') String countryCode,
    @Default('') String phoneNumber,
    @Default(false) bool warnSendDialogShowed,
    @Default('') String isoCode,
    @Default('') String jwtToken,
    @Default('Anom') String displayName,
    @Default('') String avatarUrl,
    @Default('') String email,
    String? verificationId,
    @Default('') String identifier,
    @Default([]) List<String> syncedContacts,
    @Default({}) Map<String, String> reverseContacts,
    @Default('usd') String currency,
    @JsonKey(ignore: true) @Default(false) bool hasUpgrade,
    @Default(BiometricAuth.none) BiometricAuth authType,
    @JsonKey(fromJson: localeFromJson, toJson: localeToJson) Locale? locale,
    @JsonKey(ignore: true) @Default([]) List<Contact> contacts,
    @JsonKey(ignore: true) PhoneAuthCredential? credentials,
    String? did,
    String? privateKeyForDID,
    String? userInfoCredential,
  }) = _UserState;

  factory UserState.initial() => UserState(
        networks: const [],
        mnemonic: const [],
        contacts: const [],
        syncedContacts: const [],
        reverseContacts: const {},
        displayName: "Anom",
        backup: false,
        authType: BiometricAuth.none,
        currency: 'usd',
      );

  factory UserState.fromJson(dynamic json) => _$UserStateFromJson(json);
}

class UserStateConverter
    implements JsonConverter<UserState, Map<String, dynamic>?> {
  const UserStateConverter();

  @override
  UserState fromJson(Map<String, dynamic>? json) =>
      json != null ? UserState.fromJson(json) : UserState.initial();

  @override
  Map<String, dynamic> toJson(UserState instance) => instance.toJson();
}
