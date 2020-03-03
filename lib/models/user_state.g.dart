// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return UserState(
    mnemonic: (json['mnemonic'] as List)?.map((e) => e as String)?.toList(),
    privateKey: json['privateKey'] as String,
    pincode: json['pincode'] as String,
    accountAddress: json['accountAddress'] as String,
    countryCode: json['countryCode'] as String,
    phoneNumber: json['phoneNumber'] as String,
    reverseContacts: (json['reverseContacts'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    syncedContacts:
        (json['syncedContacts'] as List)?.map((e) => e as String)?.toList(),
    jwtToken: json['jwtToken'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    verificationId: json['verificationId'] as String,
    loginRequestSuccess: json['loginRequestSuccess'] as bool,
    loginVerifySuccess: json['loginVerifySuccess'] as bool,
    isLoggedOut: json['isLoggedOut'] as bool,
    isContactsSynced: json['isContactsSynced'] as bool,
    backup: json['backup'] as bool,
    displayBalance: json['displayBalance'] as int,
    installedAt: json['installedAt'] == null
        ? null
        : DateTime.parse(json['installedAt'] as String),
  );
}

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'mnemonic': instance.mnemonic,
      'privateKey': instance.privateKey,
      'pincode': instance.pincode,
      'accountAddress': instance.accountAddress,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'syncedContacts': instance.syncedContacts,
      'reverseContacts': instance.reverseContacts,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'email': instance.email,
      'verificationId': instance.verificationId,
      'loginRequestSuccess': instance.loginRequestSuccess,
      'loginVerifySuccess': instance.loginVerifySuccess,
      'isLoggedOut': instance.isLoggedOut,
      'isContactsSynced': instance.isContactsSynced,
      'backup': instance.backup,
      'displayBalance': instance.displayBalance,
      'installedAt': instance.installedAt?.toIso8601String(),
    };
