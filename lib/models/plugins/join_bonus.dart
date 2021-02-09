import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'join_bonus.freezed.dart';
part 'join_bonus.g.dart';

@immutable
@freezed
abstract class JoinBonusPlugin with _$JoinBonusPlugin {
  @Implements(Plugin)
  @JsonSerializable(createFactory: false)
  factory JoinBonusPlugin({
    @Default('joinBonus') String type,
    String amount,
    String name,
    bool isActive,
  }) = _JoinBonusPlugin;

  factory JoinBonusPlugin.fromJson(dynamic json) => json != null
      ? JoinBonusPlugin(
          name: json['name'],
          amount: json.containsKey('joinInfo')
              ? json['joinInfo']['amount']
              : json['amount'],
          isActive: json["isActive"] ?? false,
        )
      : null;
}
