import 'package:json_annotation/json_annotation.dart';

import 'fee_base.dart';

part 'foreign_transfers_fee.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class ForeignTransfersFeePlugin extends FeePlugin {
  ForeignTransfersFeePlugin(
      {String name,
      bool isActive,
      String amount,
      String receiverAddress,
      String type = 'fixed'})
      : super(
            name: name,
            isActive: isActive,
            amount: amount,
            receiverAddress: receiverAddress,
            type: type);

  factory ForeignTransfersFeePlugin.fromJson(Map<String, dynamic> json) =>
      json != null ? _$ForeignTransfersFeePluginFromJson(json) : null;

  @override
  String getAmountText() => '$amount';
}
