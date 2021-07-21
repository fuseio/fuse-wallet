import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/backup_bonus.dart';
import 'package:fusecash/models/plugins/invite_bonus.dart';
import 'package:fusecash/models/plugins/join_bonus.dart';
import 'package:fusecash/models/plugins/moonpay.dart';
import 'package:fusecash/models/plugins/rampInstant.dart';
import 'package:fusecash/models/plugins/transak.dart';
import 'package:fusecash/models/plugins/wallet_banner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plugins.freezed.dart';
part 'plugins.g.dart';

@immutable
@freezed
class Plugins with _$Plugins {
  const Plugins._();

  @JsonSerializable()
  factory Plugins({
    @Default(null)
    @JsonKey(includeIfNull: false)
    @RampInstantPluginConverter()
        RampInstantPlugin? rampInstant,
    @Default(null)
    @JsonKey(includeIfNull: false)
    @MoonpayPluginConverter()
        MoonpayPlugin? moonpay,
    @Default(null)
    @JsonKey(includeIfNull: false)
    @TransakPluginConverter()
        TransakPlugin? transak,
    @Default(null)
    @JsonKey(includeIfNull: false)
        WalletBannerPlugin? walletBanner,
    @Default(null)
    @JsonKey(includeIfNull: false)
    @JoinBonusPluginConverter()
        JoinBonusPlugin? joinBonus,
    @Default(null)
    @JsonKey(includeIfNull: false)
    @BackupBonusPluginConverter()
        BackupBonusPlugin? backupBonus,
    @Default(null)
    @JsonKey(includeIfNull: false)
    @InviteBonusPluginConverter()
        InviteBonusPlugin? inviteBonus,
  }) = _Plugins;

  factory Plugins.fromJson(dynamic json) => _$PluginsFromJson(json);

  List getDepositPlugins() {
    List depositPlugins = [];
    if (this.rampInstant != null && this.rampInstant!.isActive) {
      depositPlugins.add(this.rampInstant);
    }
    if (this.transak != null && this.transak!.isActive) {
      depositPlugins.add(this.transak);
    }
    if (this.moonpay != null && this.moonpay!.isActive) {
      depositPlugins.add(this.moonpay);
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
