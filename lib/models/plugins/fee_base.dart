import 'plugin_base.dart';

abstract class FeePlugin extends Plugin {
  String amount;
  String type;
  String receiverAddress;

  String getAmountText();

  FeePlugin({this.amount, this.type, this.receiverAddress, name, isActive})
      : super(name: name, isActive: isActive);

  num calcFee(tokensAmount) {
    if (this.type == 'fixed') {
      return num.parse(this.amount);
    } else if (this.type == 'percentage') {
      return ((num.parse(this.amount) / 100) * tokensAmount);
    }
    return 0;
  }

  dynamic toJson() => {
        'name': name,
        'isActive': isActive,
        'type': type,
        'amount': amount,
        'receiverAddress': receiverAddress
      };
}
