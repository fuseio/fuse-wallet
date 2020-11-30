import 'package:auto_route/auto_route.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:bit2c/screens/routes.gr.dart';
import 'package:bit2c/screens/contacts/send_amount_arguments.dart';
import 'package:bit2c/services.dart';
import 'package:bit2c/utils/format.dart';
import 'package:bit2c/utils/phone.dart';
import 'package:bit2c/widgets/preloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_number/phone_number.dart';

Future<Map> fetchWalletByPhone(
    String phone, String countryCode, String isoCode) async {
  try {
    PhoneNumber phoneNumber = await phoneNumberUtil.parse(phone);
    Map wallet = await api.getWalletByPhoneNumber(phoneNumber.e164);
    String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;

    return {
      'phoneNumber': phoneNumber.e164,
      'walletAddress': walletAddress,
    };
  } catch (e) {
    String formatted = formatPhoneNumber(phone, countryCode);
    bool isValid = await phoneNumberUtil.validate(formatted, isoCode);
    if (isValid) {
      PhoneNumber phoneNumber =
          await phoneNumberUtil.parse(formatted, regionCode: isoCode);
      Map wallet = await api.getWalletByPhoneNumber(phoneNumber.e164);
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      return {
        'phoneNumber': phoneNumber.e164,
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

void bracodeScannerHandler() async {
  try {
    PermissionStatus permission = await Permission.camera.request();
    if (permission == PermissionStatus.granted) {
      ScanResult scanResult = await BarcodeScanner.scan();
      if (isValidEthereumAddress(scanResult.rawContent)) {
        sendToPastedAddress(scanResult.rawContent);
      } else {
        List<String> parts = scanResult.rawContent.split(':');
        bool expression = parts.length == 2 && parts[0] == 'ethereum';
        if (expression) {
          final String accountAddress = parts[1];
          sendToPastedAddress(accountAddress);
        }
      }
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}

// void bracodeScannerValidateAPI(
//   String phoneNumber,
//   String address,
// ) async {
//   final logger = await AppFactory().getLogger('validateApi');
//   ScanResult scanResult = await BarcodeScanner.scan();
//   logger.info('token - ${scanResult.rawContent}');
//   final String token = scanResult.rawContent;
//   try {
//     String qrValidateAPI = "https://bit2c.co.il/account/validate";
//     var body = jsonEncode(<String, String>{
//       'phonenumber': phoneNumber,
//       'address': address,
//       'token': token,
//     });
//     Response response = await client.post(qrValidateAPI,
//         body: body, headers: {'Content-Type': 'application/json'});
//     Map<String, dynamic> res = responseHandler(response);
//     transactionFailedSnack(res['Message'],
//         title: res['Status'],
//         duration: Duration(seconds: 3),
//         context: ExtendedNavigator.named('homeRouter').context,
//         margin: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 120));
//     logger.info('res res ${res.toString()}');
//   } catch (error, stackTrace) {
//     logger.severe('Error while validating account ${error.toString()}');
//     await AppFactory().reportError(error, stackTrace: stackTrace);
//     throw 'Error while validating QR';
//   }
// }
