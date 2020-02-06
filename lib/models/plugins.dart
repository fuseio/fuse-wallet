
import 'package:json_annotation/json_annotation.dart';

part 'plugins.g.dart';

abstract class Plugin {
  String name;
  bool isActive;

  Plugin(
    this.name,
    this.isActive,
  );

  dynamic toJson() => {'name': name, 'isActive': isActive};
}

class JoinBonusPlugin extends Plugin {
  String amount;
  final String type = 'joinBonus';

  JoinBonusPlugin({
    name,
    isActive,
    this.amount
  }) : super(name, isActive);

  dynamic toJson() => {'name': name, 'isActive': isActive, 'type': type, 'amount': amount};

  static JoinBonusPlugin fromJson(dynamic json) => json != null
    ? JoinBonusPlugin(
        name: json['name'],
        amount: json.containsKey('joinInfo') ? json['joinInfo']['amount'] : json['amount'],
        isActive: json["isActive"] || false,
      )
    : null;
}

abstract class DepositPlugin extends Plugin {
  String widgetUrl;

  final String type = 'deposit';

  DepositPlugin(
    name,
    isActive,
    this.widgetUrl,
  ) : super(name, isActive);

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
  @JsonKey(name: 'joinBonus', fromJson: _joinBonusFromJson, toJson: _joinBonusToJson, includeIfNull: false)
  JoinBonusPlugin joinBonus;

  Plugins({this.moonpay, this.carbon, this.wyre, this.coindirect, this.ramp, this.joinBonus});

  static Map getServicesMap (dynamic json) {
    if (json.containsKey('onramp')) {
      if (json['onramp'].containsKey('services')) {
        return json['onramp']['services'];
      } else {
        return json['onramp'];
      }
    } else {
      return json;
    }
  }

  static Plugins fromJson(dynamic json) {
    if (json == null) {
      return Plugins();
    } else {
      dynamic services= Plugins.getServicesMap(json);
      return Plugins(
        moonpay: MoonpayPlugin.fromJson(services["moonpay"]),
        carbon: CarbonPlugin.fromJson(services["carbon"]),
        wyre: WyrePlugin.fromJson(services["wyre"]),
        coindirect: CoindirectPlugin.fromJson(services["coindirect"]),
        ramp: RampPlugin.fromJson(services["ramp"]),
        joinBonus:  JoinBonusPlugin.fromJson(json['joinBonus'])
      );
    }
  }

  static JoinBonusPlugin _joinBonusFromJson(Map<String, dynamic> json) =>
      json == null ? null : JoinBonusPlugin.fromJson(json);

  static Map<String, dynamic> _joinBonusToJson(JoinBonusPlugin joinBonus) => joinBonus != null ? joinBonus.toJson() : null;

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
  // static Plugins fromJson(dynamic json) => json != null
  //   ? Plugins(
  //       moonpay: MoonpayPlugin.fromJson(json["moonpay"]),
  //       carbon: CarbonPlugin.fromJson(json["carbon"]),
  //       wyre: WyrePlugin.fromJson(json["wyre"]),
  //       coindirect: CoindirectPlugin.fromJson(json["coindirect"]),
  //       ramp: RampPlugin.fromJson(json["ramp"]),
  //     )
  //   : {};
  // static Plugins fromJson(dynamic json) {
  //   if (json != null) {
  //     Plugins(
  //     moonpay: MoonpayPlugin.fromJson(json["moonpay"]),
  //     carbon: CarbonPlugin.fromJson(json["carbon"]),
  //     wyre: WyrePlugin.fromJson(json["wyre"]),
  //     coindirect: CoindirectPlugin.fromJson(json["coindirect"]),
  //     ramp: RampPlugin.fromJson(json["ramp"]),
  //   );
  //   } else {
  //     return Plugins();
  //   }
  // }

  // static Plugins fromJson(dynamic json) => _$PluginsFromJson(json);

  dynamic toJson() => {
        'moonpay': moonpay != null ? moonpay.toJson() : null,
        'carbon': carbon != null ? carbon.toJson() : null,
        'wyre': wyre != null ? wyre.toJson() : null,
        'coindirect': coindirect != null ? coindirect.toJson() : null,
        'ramp': ramp != null ? ramp.toJson() : null,
        'joinBonus': joinBonus != null ? joinBonus.toJson() : null,
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
