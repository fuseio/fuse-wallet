import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'backup_bonus.freezed.dart';
part 'backup_bonus.g.dart';

@immutable
@freezed
abstract class BackupBonusPlugin with _$BackupBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable(createFactory: false)
  factory BackupBonusPlugin({
    @Default('backupBonus') String type,
    String amount,
    String name,
    bool isActive,
  }) = _BackupBonusPlugin;

  factory BackupBonusPlugin.fromJson(dynamic json) => json != null
      ? BackupBonusPlugin(
          name: json['name'],
          amount: json.containsKey('joinInfo')
              ? json['joinInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] ?? false,
        )
      : null;
}
