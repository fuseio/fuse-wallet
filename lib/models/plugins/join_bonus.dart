import 'plugin_base.dart';

class JoinBonusPlugin extends Plugin {
  String amount;
  final String type = 'joinBonus';

  JoinBonusPlugin({name, isActive, this.amount})
      : super(name: name, isActive: isActive);

  dynamic toJson() =>
      {'name': name, 'isActive': isActive, 'type': type, 'amount': amount};

  static JoinBonusPlugin fromJson(dynamic json) => json != null
      ? JoinBonusPlugin(
          name: json['name'],
          amount: json.containsKey('joinInfo')
              ? json['joinInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] || false,
        )
      : null;
}
