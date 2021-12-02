import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supervecina/models/plugins/backup_bonus.dart';
import 'package:supervecina/models/plugins/invite_bonus.dart';
import 'package:supervecina/models/plugins/join_bonus.dart';
import 'package:supervecina/models/plugins/moonpay.dart';
import 'package:supervecina/models/plugins/rampInstant.dart';
import 'package:supervecina/models/plugins/transak.dart';
import 'package:supervecina/models/plugins/wallet_banner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plugins.freezed.dart';
part 'plugins.g.dart';

@immutable
@freezed
class Plugins with _$Plugins {
  const Plugins._();

  @JsonSerializable()
  factory Plugins({
    @JsonKey(includeIfNull: false)
    @RampInstantPluginConverter()
        RampInstantPlugin? rampInstant,
    @JsonKey(includeIfNull: false)
    @MoonpayPluginConverter()
        MoonpayPlugin? moonpay,
    @JsonKey(includeIfNull: false)
    @TransakPluginConverter()
        TransakPlugin? transak,
    @JsonKey(includeIfNull: false) WalletBannerPlugin? walletBanner,
    @JsonKey(includeIfNull: false)
    @JoinBonusPluginConverter()
        JoinBonusPlugin? joinBonus,
    @JsonKey(includeIfNull: false)
    @BackupBonusPluginConverter()
        BackupBonusPlugin? backupBonus,
    @JsonKey(includeIfNull: false)
    @InviteBonusPluginConverter()
        InviteBonusPlugin? inviteBonus,
  }) = _Plugins;

  factory Plugins.fromJson(dynamic json) => _$PluginsFromJson(json);

  List getDepositPlugins() {
    List depositPlugins = [];
    if (rampInstant != null && rampInstant!.isActive) {
      depositPlugins.add(rampInstant);
    }
    if (transak != null && transak!.isActive) {
      depositPlugins.add(transak);
    }
    if (moonpay != null && moonpay!.isActive) {
      depositPlugins.add(moonpay);
    }
    return depositPlugins;
  }
}

class PluginsConverter
    implements JsonConverter<Plugins?, Map<String, dynamic>?> {
  const PluginsConverter();

  @override
  Plugins? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      Map getServicesMap(dynamic json) {
        if (json.containsKey('onramp')) {
          if (json['onramp'].containsKey('services')) {
            return json['onramp']['services'];
          } else {
            return json['onramp'];
          }
        } else {
          return json;
        }
      }

      dynamic services = getServicesMap(json);
      return Plugins(
        moonpay: MoonpayPluginConverter().fromJson(services["moonpay"]),
        rampInstant:
            RampInstantPluginConverter().fromJson(services["rampInstant"]),
        transak: TransakPluginConverter().fromJson(services["transak"]),
        joinBonus: JoinBonusPluginConverter().fromJson(json['joinBonus']),
        walletBanner:
            WalletBannerPluginConverter().fromJson(json['walletBanner']),
        backupBonus: BackupBonusPluginConverter().fromJson(json['backupBonus']),
        inviteBonus: InviteBonusPluginConverter().fromJson(json['inviteBonus']),
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(Plugins? instance) => instance?.toJson();
}
