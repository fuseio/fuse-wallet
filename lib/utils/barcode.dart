import 'package:barcode_scan/barcode_scan.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:bit2c/models/plugins/fee_base.dart';
import 'package:bit2c/models/pro/token.dart';
import 'package:bit2c/screens/pro_mode/assets_list.dart';
import 'package:bit2c/screens/send/send_amount.dart';
import 'package:bit2c/screens/send/send_amount_arguments.dart';

bracodeScannerHandler(BuildContext context,
    {bool isProMode = false, Token daiToken, FeePlugin feePlugin}) async {
  try {
    String accountAddress = await BarcodeScanner.scan();
    List<String> parts = accountAddress.split(':');
    bool expression = !isProMode && parts.length == 2
        ? parts[0] == 'fuse'
        : parts[0] == 'ethereum';
    if (expression) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => SendAmountScreen(
                  pageArgs: SendAmountArguments(
                      feePlugin: feePlugin,
                      avatar: NetworkImage(getTokenUrl(
                          checksumEthereumAddress(daiToken.address))),
                      erc20Token: isProMode ? daiToken : null,
                      sendType: isProMode
                          ? SendType.ETHEREUM_ADDRESS
                          : SendType.QR_ADDRESS,
                      accountAddress: parts[1]))));
    } else {
      print('Account address is not on Fuse');
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}
