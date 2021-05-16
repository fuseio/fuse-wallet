import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'wallet_banner.freezed.dart';
part 'wallet_banner.g.dart';

@immutable
@freezed
class WalletBannerPlugin with _$WalletBannerPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory WalletBannerPlugin({
    @Default('walletBanner') String type,
    required String walletBannerHash,
    required String name,
    required String link,
    required bool isActive,
  }) = _WalletBannerPlugin;

  factory WalletBannerPlugin.fromJson(dynamic json) =>
      _$WalletBannerPluginFromJson(json);
}

class WalletBannerPluginConverter
    implements JsonConverter<WalletBannerPlugin, Map<String, dynamic>> {
  const WalletBannerPluginConverter();

  @override
  WalletBannerPlugin fromJson(Map<String, dynamic> json) => WalletBannerPlugin(
        name: json['name'],
        walletBannerHash: json['walletBannerHash'],
        link: json['link'],
        isActive: json["isActive"] ?? false,
      );

  @override
  Map<String, dynamic> toJson(WalletBannerPlugin instance) => instance.toJson();
}
