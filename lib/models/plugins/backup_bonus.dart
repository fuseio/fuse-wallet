import 'plugin_base.dart';

class BackupBonusPlugin extends Plugin {
  final String type = 'backupBonus';
  String amount;

  BackupBonusPlugin({name, isActive, this.amount})
      : super(name: name, isActive: isActive);

  @override
  dynamic toJson() =>
      {'name': name, 'isActive': isActive, 'type': type, 'amount': amount};

  static BackupBonusPlugin fromJson(dynamic json) => json != null
      ? BackupBonusPlugin(
          name: json['name'],
          amount: json.containsKey('backupInfo')
              ? json['backupInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] || false,
        )
      : null;
}
