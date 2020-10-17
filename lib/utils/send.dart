import 'package:auto_route/auto_route.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:bit2c/redux/actions/cash_wallet_actions.dart';
import 'package:bit2c/redux/state/store.dart';
import 'package:bit2c/widgets/snackbars.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:bit2c/screens/routes.gr.dart';
import 'package:bit2c/screens/contacts/send_amount_arguments.dart';
import 'package:bit2c/services.dart';
import 'package:bit2c/utils/format.dart';
import 'package:bit2c/utils/phone.dart';
import 'package:bit2c/widgets/preloader.dart';
import 'package:http/http.dart';

Future<Map> fetchWalletByPhone(phone, countryCode, isoCode) async {
  try {
    Map<String, dynamic> response = await phoneNumberUtil.parse(phone);
    String phoneNumber = response['e164'];
    Map wallet = await api.getWalletByPhoneNumber(response['e164']);
    String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;

    return {
      'phoneNumber': phoneNumber,
      'walletAddress': walletAddress,
    };
  } catch (e) {
    String formatted = formatPhoneNumber(phone, countryCode);
    bool isValid = await PhoneService.isValid(formatted, isoCode);
    if (isValid) {
      Map wallet = await api.getWalletByPhoneNumber(formatted);
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      return {
        'phoneNumber': formatted,
        'walletAddress': walletAddress,
      };
    } else {
      throw '[ERROR] Fetch Wallet By Phone - $e';
    }
  }
}

void _openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Preloader(),
  );
}

void sendToContact(BuildContext context, String displayName, String phone,
    {ImageProvider avatar,
    String address,
    String countryCode,
    String isoCode}) async {
  if (address != null && address.isNotEmpty) {
    ExtendedNavigator.root.pushSendAmountScreen(
        pageArgs: SendAmountArguments(
            accountAddress: address, name: displayName, avatar: avatar));
    return;
  }
  try {
    _openLoadingDialog(context);
    Map res = await fetchWalletByPhone(phone, countryCode, isoCode);
    Navigator.of(context).pop();
    ExtendedNavigator.root.pushSendAmountScreen(
        pageArgs: SendAmountArguments(
            phoneNumber: res['phoneNumber'],
            accountAddress: res['walletAddress'],
            name: displayName,
            avatar: avatar));
  } catch (e) {
    Navigator.of(context).pop();
    throw '$e';
  }
}

void sendToPastedAddress(accountAddress) {
  ExtendedNavigator.root.pushSendAmountScreen(
      pageArgs: SendAmountArguments(
          accountAddress: accountAddress, name: formatAddress(accountAddress)));
}

bracodeScannerHandler() async {
  try {
    ScanResult scanResult = await BarcodeScanner.scan();
    if (isValidEthereumAddress(scanResult.rawContent)) {
      sendToPastedAddress(scanResult.rawContent);
    } else {
      List<String> parts = scanResult.rawContent.split(':');
      bool expression = parts.length == 2 && parts[0] == 'ethereum';
      if (expression) {
        final String accountAddress = parts[1];
        sendToPastedAddress(accountAddress);
      } else {
        print('Account address is not on Fuse');
      }
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}

void bracodeScannerValidateAPI(
  String phoneNumber,
  String address,
) async {
  final logger = await AppFactory().getLogger('validateApi');
  ScanResult scanResult = await BarcodeScanner.scan();
  logger.info('scanResult.rawContent ${scanResult.rawContent}');
  try {
    String qrValidateAPI = "https://bit2c.co.il/account/validate";
    Response response = await client.post(qrValidateAPI, body: <String, String>{
      'phonenumber': phoneNumber,
      'address': address,
      'token': scanResult.rawContent,
    }, headers: {
      'Content-Type': 'application/json'
    });
    Map<String, dynamic> res = responseHandler(response);
    transactionFailedSnack(res['Message'],
        title: res['Status'],
        duration: Duration(seconds: 3),
        context: ExtendedNavigator.named('homeRouter').context,
        margin: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 120));
    logger.info('res res ${res.toString()}');
  } catch (error, stackTrace) {
    logger.severe('Error while validating account ${error.toString()}');
    await AppFactory().reportError(error, stackTrace: stackTrace);
    throw 'Error while validating QR';
  }
}
