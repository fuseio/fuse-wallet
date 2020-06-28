import 'deposit_base.dart';

class TransakPlugin extends DepositPlugin {
  TransakPlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static TransakPlugin fromJson(dynamic json) => json != null
      ? TransakPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}
