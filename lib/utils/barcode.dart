import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';

bracodeScannerHandler(
  BuildContext context,
) async {
  try {
    String accountAddress = await BarcodeScanner.scan();
    List<String> parts = accountAddress.split(':');
    bool expression = parts.length == 2 && parts[0] == 'ethereum';
    if (expression) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => SendAmountScreen(
                  pageArgs: SendAmountArguments(accountAddress: parts[1]))));
    } else {
      print('Account address is not on Fuse');
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}
