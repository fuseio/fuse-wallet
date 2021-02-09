import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/plugins/plugin_base.dart';

part 'moonpay.freezed.dart';
part 'moonpay.g.dart';

@immutable
@freezed
abstract class MoonpayPlugin with _$MoonpayPlugin {
  @Implements(Plugin)
  @JsonSerializable(createFactory: false)
  factory MoonpayPlugin({
    String name,
    String widgetUrl,
    @Default('deposit') String type,
    @Default(false) bool isActive,
  }) = _MoonpayPlugin;

  factory MoonpayPlugin.fromJson(Map<String, dynamic> json) =>
      _$MoonpayPluginFromJson(json);
}
