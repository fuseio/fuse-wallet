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

  static MoonpayPlugin fromJsonState(dynamic json) =>
      MoonpayPlugin.fromJson(json);

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

  static CarbonPlugin fromJsonState(dynamic json) =>
      CarbonPlugin.fromJson(json);
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

  static WyrePlugin fromJsonState(dynamic json) => WyrePlugin.fromJson(json);
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

  static CoindirectPlugin fromJsonState(dynamic json) =>
      CoindirectPlugin.fromJson(json);
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

  static RampPlugin fromJsonState(dynamic json) => RampPlugin.fromJson(json);
}

class Plugins {
  MoonpayPlugin moonpay;
  CarbonPlugin carbon;
  WyrePlugin wyre;
  CoindirectPlugin coindirect;
  RampPlugin ramp;

  Plugins({this.moonpay, this.carbon, this.wyre, this.coindirect, this.ramp});

  static Plugins fromJson(dynamic json) => json != null
      ? Plugins(
          moonpay: MoonpayPlugin.fromJson(json["moonpay"]),
          carbon: CarbonPlugin.fromJson(json["carbon"]),
          wyre: WyrePlugin.fromJson(json["wyre"]),
          coindirect: CoindirectPlugin.fromJson(json["coindirect"]),
          ramp: RampPlugin.fromJson(json["ramp"]),
        )
      : {};

  static Plugins fromJsonState(dynamic json) => Plugins.fromJson(json);

  dynamic toJson() => {
        'moonpay': moonpay != null ? moonpay.toJson() : null,
        'carbon': carbon != null ? carbon.toJson() : null,
        'wyre': wyre != null ? wyre.toJson() : null,
        'coindirect': coindirect != null ? coindirect.toJson() : null,
        'ramp': ramp != null ? ramp.toJson() : null,
      };

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
