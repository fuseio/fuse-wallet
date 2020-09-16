import 'package:auto_route/auto_route.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:esol/screens/routes.gr.dart';
import 'package:esol/screens/contacts/send_amount_arguments.dart';
import 'package:esol/services.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/utils/phone.dart';
import 'package:esol/widgets/preloader.dart';

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
    ExtendedNavigator.root.push(Routes.sendAmountScreen,
        arguments: SendAmountScreenArguments(
            pageArgs: SendAmountArguments(
                accountAddress: address, name: displayName, avatar: avatar)));
    return;
  }
  try {
    _openLoadingDialog(context);
    Map res = await fetchWalletByPhone(phone, countryCode, isoCode);
    Navigator.of(context).pop();
    ExtendedNavigator.root.push(Routes.sendAmountScreen,
        arguments: SendAmountScreenArguments(
            pageArgs: SendAmountArguments(
                phoneNumber: res['phoneNumber'],
                accountAddress: res['walletAddress'],
                name: displayName,
                avatar: avatar)));
  } catch (e) {
    Navigator.of(context).pop();
    throw '$e';
  }
}

void sendToPastedAddress(accountAddress) {
  ExtendedNavigator.root.push(Routes.sendAmountScreen,
      arguments: SendAmountScreenArguments(
          pageArgs: SendAmountArguments(
              accountAddress: accountAddress,
              name: formatAddress(accountAddress),
              avatar: new AssetImage('assets/images/anom.png'))));
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
