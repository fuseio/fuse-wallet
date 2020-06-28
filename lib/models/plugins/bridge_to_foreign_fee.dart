import 'package:json_annotation/json_annotation.dart';

import 'fee_base.dart';

part 'bridge_to_foreign_fee.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class BridgeToForeignFeePlugin extends FeePlugin {
  BridgeToForeignFeePlugin(
      {String name,
      bool isActive,
      String amount,
      String receiverAddress,
      String type = 'percentage'})
      : super(
            name: name,
            isActive: isActive,
            amount: amount,
            receiverAddress: receiverAddress,
            type: type);

  factory BridgeToForeignFeePlugin.fromJson(Map<String, dynamic> json) =>
      json != null ? _$BridgeToForeignFeePluginFromJson(json) : null;

  @override
  String getAmountText() => '$amount%';
}
