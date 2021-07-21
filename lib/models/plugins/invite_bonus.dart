import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'invite_bonus.freezed.dart';
part 'invite_bonus.g.dart';

@immutable
@freezed
class InviteBonusPlugin with _$InviteBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory InviteBonusPlugin({
    @Default('inviteBonus') String type,
    @Default(null) String? amount,
    @Default(null) String? name,
    @Default(false) bool isActive,
  }) = _InviteBonusPlugin;

  factory InviteBonusPlugin.fromJson(dynamic json) =>
      _$InviteBonusPluginFromJson(json);
}

class InviteBonusPluginConverter
    implements JsonConverter<InviteBonusPlugin?, Map<String, dynamic>?> {
  const InviteBonusPluginConverter();

  @override
  InviteBonusPlugin? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return InviteBonusPlugin(
        name: json['name'],
        amount: json.containsKey('inviteInfo')
            ? json['inviteInfo']['amount']
            : json['amount'],
        isActive: json["isActive"] ?? false,
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(InviteBonusPlugin? instance) =>
      instance?.toJson();
}
