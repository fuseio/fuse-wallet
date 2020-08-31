import 'package:esol/models/plugins/backup_bonus.dart';
import 'package:esol/models/plugins/bridge_to_foreign_fee.dart';
import 'package:esol/models/plugins/foreign_transfers_fee.dart';
import 'package:esol/models/plugins/invite_bonus.dart';
import 'package:esol/models/plugins/join_bonus.dart';
import 'package:esol/models/plugins/moonpay.dart';
import 'package:esol/models/plugins/rampInstant.dart';
import 'package:esol/models/plugins/transak.dart';
import 'package:esol/models/plugins/wallet_banner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plugins.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: false)
class Plugins {
  @JsonKey(
      name: 'foreignTransfers',
      fromJson: _foreignTransfersFromJson,
      toJson: _foreignTransfersToJson,
      includeIfNull: false)
  ForeignTransfersFeePlugin foreignTransfers;
  @JsonKey(
      name: 'bridgeToForeign',
      fromJson: _bridgeToForeignFromJson,
      toJson: _bridgeToForeignToJson,
      includeIfNull: false)
  BridgeToForeignFeePlugin bridgeToForeign;
  @JsonKey(
      name: 'rampInstant',
      fromJson: _rampInstantFromJson,
      toJson: _rampInstantToJson,
      includeIfNull: false)
  RampInstantPlugin rampInstant;
  @JsonKey(
      name: 'moonpay',
      fromJson: _moonpayFromJson,
      toJson: _moonpayToJson,
      includeIfNull: false)
  MoonpayPlugin moonpay;
  @JsonKey(
      name: 'transak',
      fromJson: _transakFromJson,
      toJson: _transakToJson,
      includeIfNull: false)
  TransakPlugin transak;
  @JsonKey(
      name: 'joinBonus',
      fromJson: _joinBonusFromJson,
      toJson: _joinBonusToJson,
      includeIfNull: false)
  JoinBonusPlugin joinBonus;
  @JsonKey(
      name: 'walletBanner',
      fromJson: _wallerBannerFromJson,
      toJson: _walletBannerToJson,
      includeIfNull: false)
  WalletBannerPlugin walletBanner;
  @JsonKey(
      name: 'backupBonus',
      fromJson: _backupBonusFromJson,
      toJson: _backupBonusToJson,
      includeIfNull: false)
  BackupBonusPlugin backupBonus;
  @JsonKey(
      name: 'inviteBonus',
      fromJson: _inviteBonusFromJson,
      toJson: _inviteBonusToJson,
      includeIfNull: false)
  InviteBonusPlugin inviteBonus;

  Plugins(
      {this.moonpay,
      this.transak,
      this.rampInstant,
      this.joinBonus,
      this.walletBanner,
      this.backupBonus,
      this.foreignTransfers,
      this.bridgeToForeign,
      this.inviteBonus});

  static Map getServicesMap(dynamic json) {
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

  static Map getFeesMap(dynamic json) {
    Map fees = {};
    if (json.containsKey('fee')) {
      if (json['fee'].containsKey('foreignTransfers')) {
        json['fee']['foreignTransfers']['receiverAddress'] =
            json['fee']['receiverAddress'];
        fees['foreignTransfers'] = json['fee']['foreignTransfers'];
      }

      if (json['fee'].containsKey('bridgeToForeign')) {
        json['fee']['bridgeToForeign']['receiverAddress'] =
            json['fee']['receiverAddress'];
        fees['bridgeToForeign'] = json['fee']['bridgeToForeign'];
      }

      return fees;
    } else {
      return json;
    }
  }

  factory Plugins.fromJson(dynamic json) {
    if (json == null) {
      return Plugins();
    } else {
      dynamic services = Plugins.getServicesMap(json);
      dynamic fees = Plugins.getFeesMap(json);
      return Plugins(
        moonpay: MoonpayPlugin.fromJson(services["moonpay"]),
        rampInstant: RampInstantPlugin.fromJson(services["rampInstant"]),
        transak: TransakPlugin.fromJson(services["transak"]),
        bridgeToForeign:
            BridgeToForeignFeePlugin.fromJson(fees["bridgeToForeign"]),
        foreignTransfers:
            ForeignTransfersFeePlugin.fromJson(fees["foreignTransfers"]),
        joinBonus: JoinBonusPlugin.fromJson(json['joinBonus']),
        walletBanner: WalletBannerPlugin.fromJson(json['walletBanner']),
        backupBonus: BackupBonusPlugin.fromJson(json['backupBonus']),
        inviteBonus: InviteBonusPlugin.fromJson(json['inviteBonus']),
      );
    }
  }

  dynamic toJson() => _$PluginsToJson(this);

  static InviteBonusPlugin _inviteBonusFromJson(Map<String, dynamic> json) =>
      json == null ? null : InviteBonusPlugin.fromJson(json);

  static Map<String, dynamic> _inviteBonusToJson(
          InviteBonusPlugin inviteBonus) =>
      inviteBonus != null ? inviteBonus.toJson() : null;

  static BackupBonusPlugin _backupBonusFromJson(Map<String, dynamic> json) =>
      json == null ? null : BackupBonusPlugin.fromJson(json);

  static Map<String, dynamic> _backupBonusToJson(
          BackupBonusPlugin backupBonus) =>
      backupBonus != null ? backupBonus.toJson() : null;

  static JoinBonusPlugin _joinBonusFromJson(Map<String, dynamic> json) =>
      json == null ? null : JoinBonusPlugin.fromJson(json);

  static Map<String, dynamic> _joinBonusToJson(JoinBonusPlugin joinBonus) =>
      joinBonus != null ? joinBonus.toJson() : null;

  static WalletBannerPlugin _wallerBannerFromJson(Map<String, dynamic> json) =>
      json == null ? null : WalletBannerPlugin.fromJson(json);

  static Map<String, dynamic> _walletBannerToJson(
          WalletBannerPlugin wallerBanner) =>
      wallerBanner != null ? wallerBanner.toJson() : null;

  static BridgeToForeignFeePlugin _bridgeToForeignFromJson(
          Map<String, dynamic> json) =>
      json == null ? null : BridgeToForeignFeePlugin.fromJson(json);

  static Map<String, dynamic> _bridgeToForeignToJson(
          BridgeToForeignFeePlugin bridgeToForeign) =>
      bridgeToForeign != null ? bridgeToForeign.toJson() : null;

  static ForeignTransfersFeePlugin _foreignTransfersFromJson(
          Map<String, dynamic> json) =>
      json == null ? null : ForeignTransfersFeePlugin.fromJson(json);

  static Map<String, dynamic> _foreignTransfersToJson(
          ForeignTransfersFeePlugin foreignTransfers) =>
      foreignTransfers != null ? foreignTransfers.toJson() : null;

  static MoonpayPlugin _moonpayFromJson(Map<String, dynamic> json) =>
      json == null ? null : MoonpayPlugin.fromJson(json);

  static RampInstantPlugin _rampInstantFromJson(Map<String, dynamic> json) =>
      json == null ? null : RampInstantPlugin.fromJson(json);

  static TransakPlugin _transakFromJson(Map<String, dynamic> json) =>
      json == null ? null : TransakPlugin.fromJson(json);

  static Map<String, dynamic> _moonpayToJson(MoonpayPlugin moonpay) =>
      moonpay != null ? moonpay.toJson() : null;

  static Map<String, dynamic> _rampInstantToJson(RampInstantPlugin rampInstant) =>
      rampInstant != null ? rampInstant.toJson() : null;

  static Map<String, dynamic> _transakToJson(TransakPlugin transak) =>
      transak != null ? transak.toJson() : null;

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
