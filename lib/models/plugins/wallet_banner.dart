import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supervecina/models/plugins/plugin_base.dart';

part 'wallet_banner.freezed.dart';
part 'wallet_banner.g.dart';

@immutable
@freezed
class WalletBannerPlugin with _$WalletBannerPlugin {
  @Implements<Plugin>()
  @JsonSerializable()
  factory WalletBannerPlugin({
    @Default('walletBanner') String type,
    String? walletBannerHash,
    String? name,
    String? link,
    @Default(false) bool isActive,
  }) = _WalletBannerPlugin;

  factory WalletBannerPlugin.fromJson(dynamic json) =>
      _$WalletBannerPluginFromJson(json);
}

class WalletBannerPluginConverter
    implements JsonConverter<WalletBannerPlugin?, Map<String, dynamic>?> {
  const WalletBannerPluginConverter();

  @override
  WalletBannerPlugin? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return WalletBannerPlugin(
        name: json['name'],
        walletBannerHash: json['walletBannerHash'],
        link: json['link'],
        isActive: json["isActive"] ?? false,
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(WalletBannerPlugin? instance) =>
      instance?.toJson();
}
