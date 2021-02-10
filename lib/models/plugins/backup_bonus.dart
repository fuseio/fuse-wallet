import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'backup_bonus.freezed.dart';
part 'backup_bonus.g.dart';

@immutable
@freezed
abstract class BackupBonusPlugin with _$BackupBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory BackupBonusPlugin({
    @Default('backupBonus') String type,
    String amount,
    String name,
    bool isActive,
  }) = _BackupBonusPlugin;

  factory BackupBonusPlugin.fromJson(dynamic json) =>
      _$BackupBonusPluginFromJson(json);
}

class BackupBonusPluginConverter
    implements JsonConverter<BackupBonusPlugin, Map<String, dynamic>> {
  const BackupBonusPluginConverter();

  @override
  BackupBonusPlugin fromJson(Map<String, dynamic> json) => json != null
      ? BackupBonusPlugin(
          name: json['name'],
          amount: json.containsKey('backupInfo')
              ? json['backupInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] ?? false,
        )
      : null;

  @override
  Map<String, dynamic> toJson(BackupBonusPlugin instance) => instance?.toJson();
}
