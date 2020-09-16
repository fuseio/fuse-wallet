// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return UserState(
    walletStatus: json['walletStatus'] as String,
    walletAddress: json['walletAddress'] as String,
    communityManagerAddress: json['communityManagerAddress'] as String,
    transferManagerAddress: json['transferManagerAddress'] as String,
    daiPointsManagerAddress: json['daiPointsManagerAddress'] as String,
    networks: (json['networks'] as List)?.map((e) => e as String)?.toList(),
    mnemonic: (json['mnemonic'] as List)?.map((e) => e as String)?.toList(),
    authType: UserState._authTypeFromJson(json['authType'] as String),
    privateKey: json['privateKey'] as String,
    pincode: json['pincode'] as String,
    accountAddress: json['accountAddress'] as String,
    countryCode: json['countryCode'] as String,
    phoneNumber: json['phoneNumber'] as String,
    normalizedPhoneNumber: json['normalizedPhoneNumber'] as String,
    isoCode: json['isoCode'] as String,
    reverseContacts: (json['reverseContacts'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    syncedContacts:
        (json['syncedContacts'] as List)?.map((e) => e as String)?.toList(),
    jwtToken: json['jwtToken'] as String,
    displayName: json['displayName'] as String,
    avatarUrl: json['avatarUrl'] as String,
    email: json['email'] as String,
    verificationId: json['verificationId'] as String,
    identifier: json['identifier'] as String,
    loginRequestSuccess: json['loginRequestSuccess'] as bool,
    loginVerifySuccess: json['loginVerifySuccess'] as bool,
    isLoggedOut: json['isLoggedOut'] as bool,
    isContactsSynced: json['isContactsSynced'] as bool,
    backup: json['backup'] as bool,
    displayBalance: json['displayBalance'] as int,
    installedAt: json['installedAt'] == null
        ? null
        : DateTime.parse(json['installedAt'] as String),
    homeBackupDialogShowed: json['homeBackupDialogShowed'] as bool,
    receiveBackupDialogShowed: json['receiveBackupDialogShowed'] as bool,
    currency: UserState._currencyJson(json['currency'] as String),
    totalBalance: json['totalBalance'] as num,
  );
}

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'communityManagerAddress': instance.communityManagerAddress,
      'transferManagerAddress': instance.transferManagerAddress,
      'daiPointsManagerAddress': instance.daiPointsManagerAddress,
      'networks': instance.networks,
      'mnemonic': instance.mnemonic,
      'privateKey': instance.privateKey,
      'pincode': instance.pincode,
      'accountAddress': instance.accountAddress,
      'countryCode': instance.countryCode,
      'isoCode': instance.isoCode,
      'phoneNumber': instance.phoneNumber,
      'normalizedPhoneNumber': instance.normalizedPhoneNumber,
      'syncedContacts': instance.syncedContacts,
      'reverseContacts': instance.reverseContacts,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'verificationId': instance.verificationId,
      'identifier': instance.identifier,
      'loginRequestSuccess': instance.loginRequestSuccess,
      'loginVerifySuccess': instance.loginVerifySuccess,
      'isLoggedOut': instance.isLoggedOut,
      'isContactsSynced': instance.isContactsSynced,
      'backup': instance.backup,
      'displayBalance': instance.displayBalance,
      'installedAt': instance.installedAt?.toIso8601String(),
      'authType': EnumToString.convertToString(instance.authType),
      'homeBackupDialogShowed': instance.homeBackupDialogShowed,
      'receiveBackupDialogShowed': instance.receiveBackupDialogShowed,
      'currency': instance.currency,
      'totalBalance': instance.totalBalance,
    };
