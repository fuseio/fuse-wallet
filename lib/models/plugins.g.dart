// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plugins _$PluginsFromJson(Map<String, dynamic> json) {
  return Plugins(
    moonpay: Plugins._moonpayFromJson(json['moonpay'] as Map<String, dynamic>),
    carbon: Plugins._carbonFromJson(json['carbon'] as Map<String, dynamic>),
    wyre: Plugins._wyreFromJson(json['wyre'] as Map<String, dynamic>),
    coindirect:
        Plugins._coindirectFromJson(json['coindirect'] as Map<String, dynamic>),
    ramp: Plugins._rampFromJson(json['ramp'] as Map<String, dynamic>),
    joinBonus:
        Plugins._joinBonusFromJson(json['joinBonus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PluginsToJson(Plugins instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('moonpay', Plugins._moonpayToJson(instance.moonpay));
  writeNotNull('carbon', Plugins._carbonToJson(instance.carbon));
  writeNotNull('wyre', Plugins._wyreToJson(instance.wyre));
  writeNotNull('coindirect', Plugins._coindirectToJson(instance.coindirect));
  writeNotNull('ramp', Plugins._rampToJson(instance.ramp));
  writeNotNull('joinBonus', Plugins._joinBonusToJson(instance.joinBonus));
  return val;
}
