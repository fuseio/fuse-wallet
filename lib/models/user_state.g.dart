// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$_$_UserStateFromJson(Map<String, dynamic> json) {
  return _$_UserState(
    isContactsSynced: json['isContactsSynced'] as bool,
    installedAt: json['installedAt'] == null
        ? null
        : DateTime.parse(json['installedAt'] as String),
    isLoggedOut: json['isLoggedOut'] as bool,
    backup: json['backup'] as bool,
    depositBannerShowed: json['depositBannerShowed'] as bool,
    homeBackupDialogShowed: json['homeBackupDialogShowed'] as bool,
    displayBalance: json['displayBalance'] as int ?? 0,
    walletStatus: json['walletStatus'] as String ?? '',
    walletAddress: json['walletAddress'] as String ?? '',
    networks:
        (json['networks'] as List)?.map((e) => e as String)?.toList() ?? [],
    mnemonic:
        (json['mnemonic'] as List)?.map((e) => e as String)?.toList() ?? [],
    privateKey: json['privateKey'] as String ?? '',
    pincode: json['pincode'] as String ?? '',
    accountAddress: json['accountAddress'] as String ?? '',
    countryCode: json['countryCode'] as String ?? '',
    phoneNumber: json['phoneNumber'] as String ?? '',
    normalizedPhoneNumber: json['normalizedPhoneNumber'] as String ?? '',
    receiveBackupDialogShowed:
        json['receiveBackupDialogShowed'] as bool ?? false,
    isoCode: json['isoCode'] as String ?? '',
    jwtToken: json['jwtToken'] as String ?? '',
    displayName: json['displayName'] as String ?? 'Anom',
    avatarUrl: json['avatarUrl'] as String ?? '',
    email: json['email'] as String ?? '',
    verificationId: json['verificationId'] as String ?? '',
    identifier: json['identifier'] as String ?? '',
    totalBalance: json['totalBalance'] as num ?? 0,
    syncedContacts:
        (json['syncedContacts'] as List)?.map((e) => e as String)?.toList() ??
            [],
    reverseContacts: (json['reverseContacts'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(k, e as String),
        ) ??
        {},
    currency: currencyJson(json['currency'] as String),
    authType: authTypeFromJson(json['authType'] as String),
  );
}

Map<String, dynamic> _$_$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'isContactsSynced': instance.isContactsSynced,
      'installedAt': instance.installedAt?.toIso8601String(),
      'isLoggedOut': instance.isLoggedOut,
      'backup': instance.backup,
      'depositBannerShowed': instance.depositBannerShowed,
      'homeBackupDialogShowed': instance.homeBackupDialogShowed,
      'displayBalance': instance.displayBalance,
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'networks': instance.networks,
      'mnemonic': instance.mnemonic,
      'privateKey': instance.privateKey,
      'pincode': instance.pincode,
      'accountAddress': instance.accountAddress,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'normalizedPhoneNumber': instance.normalizedPhoneNumber,
      'receiveBackupDialogShowed': instance.receiveBackupDialogShowed,
      'isoCode': instance.isoCode,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'verificationId': instance.verificationId,
      'identifier': instance.identifier,
      'totalBalance': instance.totalBalance,
      'syncedContacts': instance.syncedContacts,
      'reverseContacts': instance.reverseContacts,
      'currency': instance.currency,
      'authType': EnumToString.convertToString(instance.authType),
    };
