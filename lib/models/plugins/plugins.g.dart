// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Plugins _$_$_PluginsFromJson(Map<String, dynamic> json) {
  return _$_Plugins(
    rampInstant: json['rampInstant'] == null
        ? null
        : RampInstantPlugin.fromJson(
            json['rampInstant'] as Map<String, dynamic>),
    moonpay: json['moonpay'] == null
        ? null
        : MoonpayPlugin.fromJson(json['moonpay'] as Map<String, dynamic>),
    transak: json['transak'] == null
        ? null
        : TransakPlugin.fromJson(json['transak'] as Map<String, dynamic>),
    walletBanner: walletBannerFromJson(json['walletBanner']),
    joinBonus: joinBonusPluginFromJson(json['joinBonus']),
    backupBonus: backupBonusPluginFromJson(json['backupBonus']),
    inviteBonus: inviteBonusPluginFromJson(json['inviteBonus']),
  );
}

Map<String, dynamic> _$_$_PluginsToJson(_$_Plugins instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rampInstant', instance.rampInstant?.toJson());
  writeNotNull('moonpay', instance.moonpay?.toJson());
  writeNotNull('transak', instance.transak?.toJson());
  writeNotNull('walletBanner', instance.walletBanner?.toJson());
  writeNotNull('joinBonus', instance.joinBonus?.toJson());
  writeNotNull('backupBonus', instance.backupBonus?.toJson());
  writeNotNull('inviteBonus', instance.inviteBonus?.toJson());
  return val;
}
