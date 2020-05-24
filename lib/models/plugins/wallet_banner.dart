import 'plugin_base.dart';

class WalletBannerPlugin extends Plugin {
  String link;
  String walletBannerHash;
  final String type = 'walletBanner';

  WalletBannerPlugin({name, isActive, this.link, this.walletBannerHash})
      : super(name: name, isActive: isActive);

  dynamic toJson() => {
        'name': name,
        'isActive': isActive,
        'type': type,
        'walletBannerHash': walletBannerHash,
        'link': link
      };

  static WalletBannerPlugin fromJson(dynamic json) => json != null
      ? WalletBannerPlugin(
          name: json['name'],
          walletBannerHash: json['walletBannerHash'],
          link: json['link'],
          isActive: json["isActive"] || false,
        )
      : null;
}
