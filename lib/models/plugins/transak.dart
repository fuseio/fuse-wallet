import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'transak.freezed.dart';
part 'transak.g.dart';

@immutable
@freezed
class TransakPlugin with _$TransakPlugin {
  @Implements(Plugin)
  @JsonSerializable()
  factory TransakPlugin({
    @Default('transak') String name,
    String? widgetUrl,
    @Default('deposit') String type,
    @Default(false) bool isActive,
  }) = _TransakPlugin;

  factory TransakPlugin.fromJson(Map<String, dynamic> json) =>
      _$TransakPluginFromJson(json);
}
