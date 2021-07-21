// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Plugins _$_$_PluginsFromJson(Map<String, dynamic> json) {
  return _$_Plugins(
    rampInstant: const RampInstantPluginConverter()
        .fromJson(json['rampInstant'] as Map<String, dynamic>?),
    moonpay: const MoonpayPluginConverter()
        .fromJson(json['moonpay'] as Map<String, dynamic>?),
    transak: const TransakPluginConverter()
        .fromJson(json['transak'] as Map<String, dynamic>?),
    walletBanner: json['walletBanner'] == null
        ? null
        : WalletBannerPlugin.fromJson(json['walletBanner']),
    joinBonus: const JoinBonusPluginConverter()
        .fromJson(json['joinBonus'] as Map<String, dynamic>?),
    backupBonus: const BackupBonusPluginConverter()
        .fromJson(json['backupBonus'] as Map<String, dynamic>?),
    inviteBonus: const InviteBonusPluginConverter()
        .fromJson(json['inviteBonus'] as Map<String, dynamic>?),
  );
}

Map<String, dynamic> _$_$_PluginsToJson(_$_Plugins instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rampInstant',
      const RampInstantPluginConverter().toJson(instance.rampInstant));
  writeNotNull(
      'moonpay', const MoonpayPluginConverter().toJson(instance.moonpay));
  writeNotNull(
      'transak', const TransakPluginConverter().toJson(instance.transak));
  writeNotNull('walletBanner', instance.walletBanner?.toJson());
  writeNotNull(
      'joinBonus', const JoinBonusPluginConverter().toJson(instance.joinBonus));
  writeNotNull('backupBonus',
      const BackupBonusPluginConverter().toJson(instance.backupBonus));
  writeNotNull('inviteBonus',
      const InviteBonusPluginConverter().toJson(instance.inviteBonus));
  return val;
}
