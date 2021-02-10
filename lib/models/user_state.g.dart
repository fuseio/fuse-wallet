// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$_$_UserStateFromJson(Map<String, dynamic> json) {
  return _$_UserState(
    syncedContacts:
        (json['syncedContacts'] as List)?.map((e) => e as String)?.toList() ??
            [],
    installedAt: json['installedAt'] == null
        ? null
        : DateTime.parse(json['installedAt'] as String),
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
    reverseContacts: (json['reverseContacts'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(k, e as String),
        ) ??
        {},
    jwtToken: json['jwtToken'] as String ?? '',
    displayName: json['displayName'] as String ?? 'Anom',
    avatarUrl: json['avatarUrl'] as String ?? '',
    email: json['email'] as String ?? '',
    verificationId: json['verificationId'] as String ?? '',
    identifier: json['identifier'] as String ?? '',
    isLoggedOut: json['isLoggedOut'] as bool ?? false,
    isContactsSynced: json['isContactsSynced'] as bool ?? false,
    backup: json['backup'] as bool ?? false,
    depositBannerShowed: json['depositBannerShowed'] as bool ?? false,
    totalBalance: json['totalBalance'] as num ?? 0,
    homeBackupDialogShowed: json['homeBackupDialogShowed'] as bool ?? false,
    currency: currencyJson(json['currency'] as String),
    authType: authTypeFromJson(json['authType'] as String),
  );
}

Map<String, dynamic> _$_$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'syncedContacts': instance.syncedContacts,
      'installedAt': instance.installedAt?.toIso8601String(),
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
      'reverseContacts': instance.reverseContacts,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'verificationId': instance.verificationId,
      'identifier': instance.identifier,
      'isLoggedOut': instance.isLoggedOut,
      'isContactsSynced': instance.isContactsSynced,
      'backup': instance.backup,
      'depositBannerShowed': instance.depositBannerShowed,
      'totalBalance': instance.totalBalance,
      'homeBackupDialogShowed': instance.homeBackupDialogShowed,
      'currency': instance.currency,
      'authType': EnumToString.convertToString(instance.authType),
    };
