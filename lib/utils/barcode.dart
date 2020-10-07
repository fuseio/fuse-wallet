import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bit2c/redux/actions/cash_wallet_actions.dart';
import 'package:bit2c/redux/state/store.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:bit2c/models/plugins/fee_base.dart';
import 'package:bit2c/models/pro/token.dart';
import 'package:bit2c/screens/pro_mode/assets_list.dart';
import 'package:bit2c/screens/send/send_amount.dart';
import 'package:bit2c/screens/send/send_amount_arguments.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../services.dart';

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


bracodeScannerValidateAPI(BuildContext context, String phoneNumber, String address, String token,{bool isProMode = false, Token daiToken, FeePlugin feePlugin}) async {

  // print(phoneNumber);
  // print(address);
  // print(token);

  try {

    String data = await BarcodeScanner.scan();
    List<String> parts = data.split('.');

    if (parts.length >= 2) {

      String first = parts[1];
      String second = parts[2]!=null?parts[2]:"";
      String token = "$first.$second";
      try {
        String qrValidateAPI = "https://testing.bit2c.co.il/account/validate";
        var param = jsonEncode(<String, String>{
          'phonenumber': phoneNumber,
          'address': address,
          'token': token,
        });

        Response response = await client.post(qrValidateAPI, body: param);
        Map<String, dynamic> drawInfoResponse = responseHandler(response);
        final data = drawInfoResponse['data'];
        return data;
      } catch (error, stackTrace) {
        await AppFactory().reportError(error, stackTrace);
        throw 'Error while validating QR';
      }
    } else {
      print('QR Validate is not on Fuse');
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}
