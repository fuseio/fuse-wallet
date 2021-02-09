import 'package:freezed_annotation/freezed_annotation.dart';
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
abstract class Plugins implements _$Plugins {
  const Plugins._();

  // @JsonSerializable(createFactory: false)
  factory Plugins({
    RampInstantPlugin rampInstant,
    MoonpayPlugin moonpay,
    TransakPlugin transak,
    JoinBonusPlugin joinBonus,
    WalletBannerPlugin walletBanner,
    BackupBonusPlugin backupBonus,
    InviteBonusPlugin inviteBonus,
  }) = _Plugins;

  dynamic toJson() => <String, dynamic>{
        'rampInstant': this.rampInstant?.toJson(),
        'moonpay': this.moonpay?.toJson(),
        'transak': this.transak?.toJson(),
        'joinBonus': this.joinBonus?.toJson(),
        'walletBanner': this.walletBanner?.toJson(),
        'backupBonus': this.backupBonus?.toJson(),
        'inviteBonus': this.inviteBonus?.toJson(),
        'hashCode': this.hashCode,
      };

  factory Plugins.fromJson(dynamic json) {
    if (json == null) {
      return Plugins();
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
        moonpay: MoonpayPlugin.fromJson(services["moonpay"]),
        rampInstant: RampInstantPlugin.fromJson(services["rampInstant"]),
        transak: TransakPlugin.fromJson(services["transak"]),
        joinBonus: JoinBonusPlugin.fromJson(json['joinBonus']),
        walletBanner: WalletBannerPlugin.fromJson(json['walletBanner']),
        backupBonus: BackupBonusPlugin.fromJson(json['backupBonus']),
        inviteBonus: InviteBonusPlugin.fromJson(json['inviteBonus']),
      );
    }
  }

  List getDepositPlugins() {
    List depositPlugins = [];
    if (this.rampInstant != null && this.rampInstant.isActive) {
      depositPlugins.add(this.rampInstant);
    }
    if (this.transak != null && this.transak.isActive) {
      depositPlugins.add(this.transak);
    }
    if (this.moonpay != null && this.moonpay.isActive) {
      depositPlugins.add(this.moonpay);
    }
    return depositPlugins;
  }
}
