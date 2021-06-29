import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'rampInstant.freezed.dart';
part 'rampInstant.g.dart';

// @immutable
@freezed
class RampInstantPlugin with _$RampInstantPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory RampInstantPlugin({
    @Default('rampInstant') String name,
    String? widgetUrl,
    @Default('deposit') String type,
    @Default(false) bool isActive,
  }) = _RampInstantPlugin;

  factory RampInstantPlugin.fromJson(Map<String, dynamic> json) =>
      _$RampInstantPluginFromJson(json);
}
