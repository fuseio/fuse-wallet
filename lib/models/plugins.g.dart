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

  writeNotNull('moonpay', Plugins._moonpayToJson(instance.moonpay));
  writeNotNull('transak', Plugins._transakToJson(instance.transak));
  writeNotNull('carbon', Plugins._carbonToJson(instance.carbon));
  writeNotNull('wyre', Plugins._wyreToJson(instance.wyre));
  writeNotNull('coindirect', Plugins._coindirectToJson(instance.coindirect));
  writeNotNull('ramp', Plugins._rampToJson(instance.ramp));
  writeNotNull('joinBonus', Plugins._joinBonusToJson(instance.joinBonus));
  writeNotNull(
      'walletBanner', Plugins._walletBannerToJson(instance.walletBanner));
  writeNotNull('backupBonus', Plugins._backupBonusToJson(instance.backupBonus));
  writeNotNull('inviteBonus', Plugins._inviteBonusToJson(instance.inviteBonus));
  return val;
}
