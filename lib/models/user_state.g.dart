// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$_$_UserStateFromJson(Map<String, dynamic> json) {
  return _$_UserState(
    walletStatus: json['walletStatus'] as String ?? '',
    walletAddress: json['walletAddress'] as String ?? '',
    communityManagerAddress: json['communityManagerAddress'] as String ?? '',
    transferManagerAddress: json['transferManagerAddress'] as String ?? '',
    daiPointsManagerAddress: json['daiPointsManagerAddress'] as String ?? '',
    networks: (json['networks'] as List)?.map((e) => e as String)?.toList(),
    mnemonic: (json['mnemonic'] as List)?.map((e) => e as String)?.toList(),
    authType: authTypeFromJson(json['authType'] as String),
    privateKey: json['privateKey'] as String ?? '',
    pincode: json['pincode'] as String ?? '',
    accountAddress: json['accountAddress'] as String ?? '',
    countryCode: json['countryCode'] as String ?? '',
    phoneNumber: json['phoneNumber'] as String ?? '',
    normalizedPhoneNumber: json['normalizedPhoneNumber'] as String ?? '',
    isoCode: json['isoCode'] as String ?? '',
    reverseContacts: (json['reverseContacts'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(k, e as String),
        ) ??
        {},
    syncedContacts:
        (json['syncedContacts'] as List)?.map((e) => e as String)?.toList(),
    jwtToken: json['jwtToken'] as String ?? '',
    displayName: json['displayName'] as String ?? 'Anom',
    avatarUrl: json['avatarUrl'] as String ?? '',
    email: json['email'] as String ?? '',
    verificationId: json['verificationId'] as String ?? '',
    identifier: json['identifier'] as String ?? '',
    isLoggedOut: json['isLoggedOut'] as bool ?? false,
    isContactsSynced: json['isContactsSynced'] as bool ?? false,
    backup: json['backup'] as bool ?? false,
    displayBalance: json['displayBalance'] as int,
    installedAt: json['installedAt'] == null
        ? null
        : DateTime.parse(json['installedAt'] as String),
    currency: currencyJson(json['currency'] as String),
    totalBalance: json['totalBalance'] as num ?? 0,
    depositBannerShowed: json['depositBannerShowed'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'communityManagerAddress': instance.communityManagerAddress,
      'transferManagerAddress': instance.transferManagerAddress,
      'daiPointsManagerAddress': instance.daiPointsManagerAddress,
      'networks': instance.networks,
      'mnemonic': instance.mnemonic,
      'authType': EnumToString.convertToString(instance.authType),
      'privateKey': instance.privateKey,
      'pincode': instance.pincode,
      'accountAddress': instance.accountAddress,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'normalizedPhoneNumber': instance.normalizedPhoneNumber,
      'isoCode': instance.isoCode,
      'reverseContacts': instance.reverseContacts,
      'syncedContacts': instance.syncedContacts,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'verificationId': instance.verificationId,
      'identifier': instance.identifier,
      'isLoggedOut': instance.isLoggedOut,
      'isContactsSynced': instance.isContactsSynced,
      'backup': instance.backup,
      'displayBalance': instance.displayBalance,
      'installedAt': instance.installedAt?.toIso8601String(),
      'currency': instance.currency,
      'totalBalance': instance.totalBalance,
      'depositBannerShowed': instance.depositBannerShowed,
    };
