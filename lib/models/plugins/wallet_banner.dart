import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'wallet_banner.freezed.dart';
part 'wallet_banner.g.dart';

@immutable
@freezed
abstract class WalletBannerPlugin with _$WalletBannerPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory WalletBannerPlugin({
    @Default('walletBanner') String type,
    String walletBannerHash,
    String name,
    String link,
    bool isActive,
  }) = _WalletBannerPlugin;

  factory WalletBannerPlugin.fromJson(dynamic json) =>
      _$WalletBannerPluginFromJson(json);
}

class WalletBannerPluginConverter
    implements JsonConverter<WalletBannerPlugin, Map<String, dynamic>> {
  const WalletBannerPluginConverter();

  @override
  WalletBannerPlugin fromJson(Map<String, dynamic> json) => json != null
      ? WalletBannerPlugin(
          name: json['name'],
          walletBannerHash: json['walletBannerHash'],
          link: json['link'],
          isActive: json["isActive"] || false,
        )
      : null;

  @override
  Map<String, dynamic> toJson(WalletBannerPlugin instance) =>
      instance?.toJson();
}
