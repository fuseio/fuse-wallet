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
    walletBanner: const WalletBannerPluginConverter()
        .fromJson(json['walletBanner'] as Map<String, dynamic>),
    joinBonus: const JoinBonusPluginConverter()
        .fromJson(json['joinBonus'] as Map<String, dynamic>),
    backupBonus: const BackupBonusPluginConverter()
        .fromJson(json['backupBonus'] as Map<String, dynamic>),
    inviteBonus: const InviteBonusPluginConverter()
        .fromJson(json['inviteBonus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_PluginsToJson(_$_Plugins instance) {
  final val = <String, dynamic>{
    'rampInstant': instance.rampInstant?.toJson(),
    'moonpay': instance.moonpay?.toJson(),
    'transak': instance.transak?.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('walletBanner',
      const WalletBannerPluginConverter().toJson(instance.walletBanner));
  writeNotNull(
      'joinBonus', const JoinBonusPluginConverter().toJson(instance.joinBonus));
  writeNotNull('backupBonus',
      const BackupBonusPluginConverter().toJson(instance.backupBonus));
  writeNotNull('inviteBonus',
      const InviteBonusPluginConverter().toJson(instance.inviteBonus));
  return val;
}
