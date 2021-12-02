import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supervecina/models/plugins/plugin_base.dart';

part 'rampInstant.freezed.dart';
part 'rampInstant.g.dart';

@immutable
@freezed
class RampInstantPlugin with _$RampInstantPlugin {
  @Implements<Plugin>()
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

class RampInstantPluginConverter
    implements JsonConverter<RampInstantPlugin?, Map<String, dynamic>?> {
  const RampInstantPluginConverter();

  @override
  RampInstantPlugin? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return RampInstantPlugin.fromJson(json);
    }
  }

  @override
  Map<String, dynamic>? toJson(RampInstantPlugin? instance) =>
      instance?.toJson();
}
