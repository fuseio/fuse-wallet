// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletBannerPlugin _$_$_WalletBannerPluginFromJson(
    Map<String, dynamic> json) {
  return _$_WalletBannerPlugin(
    type: json['type'] as String? ?? 'walletBanner',
    walletBannerHash: json['walletBannerHash'] as String?,
    name: json['name'] as String?,
    link: json['link'] as String?,
    isActive: json['isActive'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_WalletBannerPluginToJson(
        _$_WalletBannerPlugin instance) =>
    <String, dynamic>{
      'type': instance.type,
      'walletBannerHash': instance.walletBannerHash,
      'name': instance.name,
      'link': instance.link,
      'isActive': instance.isActive,
    };
