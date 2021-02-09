import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'invite_bonus.freezed.dart';
part 'invite_bonus.g.dart';

@immutable
@freezed
abstract class InviteBonusPlugin with _$InviteBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable(createFactory: false)
  factory InviteBonusPlugin({
    @Default('inviteBonus') String type,
    String amount,
    String name,
    bool isActive,
  }) = _InviteBonusPlugin;

  factory InviteBonusPlugin.fromJson(dynamic json) => json != null
      ? InviteBonusPlugin(
          name: json['name'],
          amount: json.containsKey('inviteInfo')
              ? json['inviteInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] ?? false,
        )
      : null;
}
