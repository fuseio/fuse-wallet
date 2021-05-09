// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Plugins _$_$_PluginsFromJson(Map<String, dynamic> json) {
  return _$_Plugins(
    rampInstant:
        RampInstantPlugin.fromJson(json['rampInstant'] as Map<String, dynamic>),
    moonpay: MoonpayPlugin.fromJson(json['moonpay'] as Map<String, dynamic>),
    transak: TransakPlugin.fromJson(json['transak'] as Map<String, dynamic>),
    walletBanner: walletBannerFromJson(json['walletBanner']),
    joinBonus: joinBonusPluginFromJson(json['joinBonus']),
    backupBonus: backupBonusPluginFromJson(json['backupBonus']),
    inviteBonus: inviteBonusPluginFromJson(json['inviteBonus']),
  );
}

Map<String, dynamic> _$_$_PluginsToJson(_$_Plugins instance) =>
    <String, dynamic>{
      'rampInstant': instance.rampInstant.toJson(),
      'moonpay': instance.moonpay.toJson(),
      'transak': instance.transak.toJson(),
      'walletBanner': instance.walletBanner.toJson(),
      'joinBonus': instance.joinBonus.toJson(),
      'backupBonus': instance.backupBonus.toJson(),
      'inviteBonus': instance.inviteBonus.toJson(),
    };
