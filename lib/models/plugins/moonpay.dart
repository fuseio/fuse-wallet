// import 'package:json_annotation/json_annotation.dart';

import 'deposit_base.dart';

// part 'moonpay.g.dart';

// @JsonSerializable(explicitToJson: true)
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
