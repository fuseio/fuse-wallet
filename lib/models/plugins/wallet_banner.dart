import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'wallet_banner.freezed.dart';
part 'wallet_banner.g.dart';

@immutable
@freezed
abstract class WalletBannerPlugin with _$WalletBannerPlugin {
  @Implements(Plugin)
  @JsonSerializable(createFactory: false)
  factory WalletBannerPlugin({
    @Default('walletBanner') String type,
    String walletBannerHash,
    String name,
    String link,
    bool isActive,
  }) = _WalletBannerPlugin;

  factory WalletBannerPlugin.fromJson(dynamic json) => json != null
      ? WalletBannerPlugin(
          name: json['name'],
          link: json['link'],
          walletBannerHash: json['walletBannerHash'],
          isActive: json["isActive"] ?? false,
        )
      : null;
}
