import 'package:json_annotation/json_annotation.dart';

part 'plugins.g.dart';

abstract class DepositPlugin {
  String name;
  bool isActive;
  String widgetUrl;

  final String type = 'deposit';

  DepositPlugin(
    this.name,
    this.isActive,
    this.widgetUrl,
  );

  String generateUrl({String email, String walletAddress}) {
    return this.widgetUrl;
  }

  dynamic toJson() => {'name': name, 'isActive': isActive, 'type': type};
}

class MoonpayPlugin extends DepositPlugin {
  MoonpayPlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static MoonpayPlugin fromJson(dynamic json) => json != null
      ? MoonpayPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;

  String generateUrl({String email, String walletAddress}) {
    String url = this.widgetUrl;

    url += '&externalCustomerId=$walletAddress';
    if (email != null && email != '') {
      url = url + '&email=$email';
    }
    return url;
  }
}

class CarbonPlugin extends DepositPlugin {
  CarbonPlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static CarbonPlugin fromJson(dynamic json) => json != null
      ? CarbonPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}

class WyrePlugin extends DepositPlugin {
  WyrePlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static WyrePlugin fromJson(dynamic json) => json != null
      ? WyrePlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}

class CoindirectPlugin extends DepositPlugin {
  CoindirectPlugin({name, isActive, widgetUrl})
      : super(name, isActive, widgetUrl);

  static CoindirectPlugin fromJson(dynamic json) => json != null
      ? CoindirectPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}

class RampPlugin extends DepositPlugin {
  RampPlugin({name, isActive, widgetUrl}) : super(name, isActive, widgetUrl);

  static RampPlugin fromJson(dynamic json) => json != null
      ? RampPlugin(
          name: json['name'],
          widgetUrl: json['widgetUrl'],
          isActive: json["isActive"] || false,
        )
      : null;
}

@JsonSerializable(explicitToJson: true)
class Plugins {
  @JsonKey(name: 'moonpay', fromJson: _moonpayFromJson, toJson: _moonpayToJson, includeIfNull: false)
  MoonpayPlugin moonpay;
  @JsonKey(name: 'carbon', fromJson: _carbonFromJson, toJson: _carbonToJson, includeIfNull: false)
  CarbonPlugin carbon;
  @JsonKey(name: 'wyre', fromJson: _wyreFromJson, toJson: _wyreToJson, includeIfNull: false)
  WyrePlugin wyre;
  @JsonKey(name: 'coindirect', fromJson: _coindirectFromJson, toJson: _coindirectToJson, includeIfNull: false)
  CoindirectPlugin coindirect;
  @JsonKey(name: 'ramp', fromJson: _rampFromJson, toJson: _rampToJson, includeIfNull: false)
  RampPlugin ramp;

  Plugins({this.moonpay, this.carbon, this.wyre, this.coindirect, this.ramp});

  static WyrePlugin _wyreFromJson(Map<String, dynamic> json) =>
      json == null ? null : WyrePlugin.fromJson(json);

  static Map<String, dynamic> _wyreToJson(WyrePlugin wyre) => wyre != null ? wyre.toJson() : null;

  static CoindirectPlugin _coindirectFromJson(Map<String, dynamic> json) =>
      json == null ? null : CoindirectPlugin.fromJson(json);

  static Map<String, dynamic> _coindirectToJson(
          CoindirectPlugin coindirect) =>
      coindirect != null ? coindirect.toJson() : null;

  static RampPlugin _rampFromJson(Map<String, dynamic> json) =>
      json == null ? null : RampPlugin.fromJson(json);

  static Map<String, dynamic> _rampToJson(RampPlugin ramp) =>
      ramp != null ? ramp.toJson() : null;

  static MoonpayPlugin _moonpayFromJson(Map<String, dynamic> json) =>
      json == null ? null : MoonpayPlugin.fromJson(json);

  static Map<String, dynamic> _moonpayToJson(MoonpayPlugin moonpay) =>
      moonpay != null ? moonpay.toJson() : null;

  static CarbonPlugin _carbonFromJson(Map<String, dynamic> json) =>
      json == null ? null : CarbonPlugin.fromJson(json);

  static Map<String, dynamic> _carbonToJson(CarbonPlugin carbon) =>
      carbon != null ? carbon.toJson() : null;

  static Plugins fromJson(dynamic json) => _$PluginsFromJson(json);

  Map<String, dynamic> toJson() => _$PluginsToJson(this);

  List getDepositPlugins() {
    List depositPlugins = [];
    if (this.moonpay != null && this.moonpay.isActive) {
      depositPlugins.add(this.moonpay);
    }
    // if (this.carbon != null && this.carbon.isActive) {
    //   depositPlugins.add(this.carbon);
    // }
    // if (this.wyre != null && this.wyre.isActive) {
    //   depositPlugins.add(this.wyre);
    // }
    // if (this.coindirect != null && this.coindirect.isActive) {
    //   depositPlugins.add(this.coindirect);
    // }
    // if (this.ramp != null && this.ramp.isActive) {
    //   depositPlugins.add(this.ramp);
    // }
    return depositPlugins;
  }
}
