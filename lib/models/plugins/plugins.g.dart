// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PluginsToJson(Plugins instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('foreignTransfers',
      Plugins._foreignTransfersToJson(instance.foreignTransfers));
  writeNotNull('bridgeToForeign',
      Plugins._bridgeToForeignToJson(instance.bridgeToForeign));
  writeNotNull('rampInstant', Plugins._rampInstantToJson(instance.rampInstant));
  writeNotNull('moonpay', Plugins._moonpayToJson(instance.moonpay));
  writeNotNull('transak', Plugins._transakToJson(instance.transak));
  writeNotNull('joinBonus', Plugins._joinBonusToJson(instance.joinBonus));
  writeNotNull(
      'walletBanner', Plugins._walletBannerToJson(instance.walletBanner));
  writeNotNull('backupBonus', Plugins._backupBonusToJson(instance.backupBonus));
  writeNotNull('inviteBonus', Plugins._inviteBonusToJson(instance.inviteBonus));
  return val;
}
