import 'deposit_base.dart';

class MoonpayPlugin extends DepositPlugin {
  MoonpayPlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static MoonpayPlugin fromJson(dynamic json) => json != null
      ? MoonpayPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}
