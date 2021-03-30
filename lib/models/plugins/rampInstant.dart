import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'rampInstant.freezed.dart';
part 'rampInstant.g.dart';

@immutable
@freezed
abstract class RampInstantPlugin with _$RampInstantPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory RampInstantPlugin({
    String name,
    String widgetUrl,
    @Default('deposit') String type,
    @Default(false) bool isActive,
  }) = _RampInstantPlugin;

  factory RampInstantPlugin.fromJson(Map<String, dynamic> json) =>
      _$RampInstantPluginFromJson(json);
}
