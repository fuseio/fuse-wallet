import 'plugin_base.dart';

class InviteBonusPlugin extends Plugin {
  String amount;
  final String type = 'inviteBonus';

  InviteBonusPlugin({name, isActive, this.amount})
      : super(name: name, isActive: isActive);

  @override
  dynamic toJson() =>
      {'name': name, 'isActive': isActive, 'type': type, 'amount': amount};

  static InviteBonusPlugin fromJson(dynamic json) => json != null
      ? InviteBonusPlugin(
          name: json['name'],
          amount: json.containsKey('inviteInfo')
              ? json['inviteInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] || false,
        )
      : null;
}
