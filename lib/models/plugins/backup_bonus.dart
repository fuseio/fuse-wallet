import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'backup_bonus.freezed.dart';
part 'backup_bonus.g.dart';

@immutable
@freezed
class BackupBonusPlugin with _$BackupBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory BackupBonusPlugin({
    @Default('backupBonus') String type,
    @Default(null) String? amount,
    @Default(null) String? name,
    @Default(false) bool isActive,
  }) = _BackupBonusPlugin;

  factory BackupBonusPlugin.fromJson(dynamic json) =>
      _$BackupBonusPluginFromJson(json);
}

class BackupBonusPluginConverter
    implements JsonConverter<BackupBonusPlugin?, Map<String, dynamic>?> {
  const BackupBonusPluginConverter();

  @override
  BackupBonusPlugin? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return BackupBonusPlugin(
        name: json['name'],
        amount: json.containsKey('backupInfo')
            ? json['backupInfo']['amount']
            : json['amount'],
        isActive: json["isActive"] ?? false,
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(BackupBonusPlugin? instance) =>
      instance?.toJson();
}
