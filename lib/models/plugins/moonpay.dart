import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'moonpay.freezed.dart';
part 'moonpay.g.dart';

@immutable
@freezed
class MoonpayPlugin with _$MoonpayPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory MoonpayPlugin({
    @Default('moonpay') String name,
    String? widgetUrl,
    @Default('deposit') String type,
    @Default(false) bool isActive,
  }) = _MoonpayPlugin;

  factory MoonpayPlugin.fromJson(Map<String, dynamic> json) =>
      _$MoonpayPluginFromJson(json);
}
