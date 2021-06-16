import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'join_bonus.freezed.dart';
part 'join_bonus.g.dart';

@immutable
@freezed
class JoinBonusPlugin with _$JoinBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory JoinBonusPlugin({
    @Default('joinBonus') String type,
    @Default(null) String? amount,
    @Default(null) String? name,
    @Default(false) bool isActive,
  }) = _JoinBonusPlugin;

  factory JoinBonusPlugin.fromJson(dynamic json) =>
      _$JoinBonusPluginFromJson(json);
}

class JoinBonusPluginConverter
    implements JsonConverter<JoinBonusPlugin?, Map<String, dynamic>?> {
  const JoinBonusPluginConverter();

  @override
  JoinBonusPlugin? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return JoinBonusPlugin(
        name: json['name'],
        amount: json.containsKey('joinInfo')
            ? json['joinInfo']['amount']
            : json['amount'],
        isActive: json["isActive"] ?? false,
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(JoinBonusPlugin? instance) => instance?.toJson();
}
