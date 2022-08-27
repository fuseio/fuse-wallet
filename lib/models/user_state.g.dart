// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$$_UserStateFromJson(Map<String, dynamic> json) => _$_UserState(
      contractVersion: json['contractVersion'] as String?,
      walletModules: json['walletModules'] == null
          ? null
          : WalletModules.fromJson(
              json['walletModules'] as Map<String, dynamic>),
      installedAt: json['installedAt'] == null
          ? null
          : DateTime.parse(json['installedAt'] as String),
      isContactsSynced: json['isContactsSynced'] as bool?,
      isLoggedOut: json['isLoggedOut'] as bool? ?? false,
      backup: json['backup'] as bool? ?? false,
      scrollToTop: json['scrollToTop'] as bool? ?? false,
      walletAddress: json['walletAddress'] as String? ?? '',
      networks: (json['networks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mnemonic: (json['mnemonic'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      privateKey: json['privateKey'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      accountAddress: json['accountAddress'] as String? ?? '',
      countryCode: json['countryCode'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      warnSendDialogShowed: json['warnSendDialogShowed'] as bool? ?? false,
      isoCode: json['isoCode'] as String? ?? '',
      jwtToken: json['jwtToken'] as String? ?? '',
      displayName: json['displayName'] as String? ?? 'Anom',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      email: json['email'] as String? ?? '',
      verificationId: json['verificationId'] as String?,
      identifier: json['identifier'] as String? ?? '',
      syncedContacts: (json['syncedContacts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      reverseContacts: (json['reverseContacts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      currency: json['currency'] as String? ?? 'usd',
      authType: $enumDecodeNullable(_$BiometricAuthEnumMap, json['authType']) ??
          BiometricAuth.none,
      locale: localeFromJson(json['locale'] as Map<String, dynamic>),
      did: json['did'] as String?,
      privateKeyForDID: json['privateKeyForDID'] as String?,
      userInfoCredential: json['userInfoCredential'] as String?,
    );

Map<String, dynamic> _$$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'contractVersion': instance.contractVersion,
      'walletModules': instance.walletModules?.toJson(),
      'installedAt': instance.installedAt?.toIso8601String(),
      'isContactsSynced': instance.isContactsSynced,
      'isLoggedOut': instance.isLoggedOut,
      'backup': instance.backup,
      'scrollToTop': instance.scrollToTop,
      'walletAddress': instance.walletAddress,
      'networks': instance.networks,
      'mnemonic': instance.mnemonic,
      'privateKey': instance.privateKey,
      'pincode': instance.pincode,
      'accountAddress': instance.accountAddress,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'warnSendDialogShowed': instance.warnSendDialogShowed,
      'isoCode': instance.isoCode,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'verificationId': instance.verificationId,
      'identifier': instance.identifier,
      'syncedContacts': instance.syncedContacts,
      'reverseContacts': instance.reverseContacts,
      'currency': instance.currency,
      'authType': _$BiometricAuthEnumMap[instance.authType]!,
      'locale': localeToJson(instance.locale),
      'did': instance.did,
      'privateKeyForDID': instance.privateKeyForDID,
      'userInfoCredential': instance.userInfoCredential,
    };

const _$BiometricAuthEnumMap = {
  BiometricAuth.faceID: 'faceID',
  BiometricAuth.touchID: 'touchID',
  BiometricAuth.pincode: 'pincode',
  BiometricAuth.none: 'none',
};
