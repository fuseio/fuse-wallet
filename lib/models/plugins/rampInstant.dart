import 'deposit_base.dart';

class RampInstantPlugin extends DepositPlugin {
  RampInstantPlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static RampInstantPlugin fromJson(dynamic json) => json != null
      ? RampInstantPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}
