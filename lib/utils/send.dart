import 'package:auto_route/auto_route.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:seedbed/screens/routes.gr.dart';
import 'package:seedbed/screens/contacts/send_amount_arguments.dart';
import 'package:seedbed/services.dart';
import 'package:seedbed/utils/format.dart';
import 'package:seedbed/utils/phone.dart';
import 'package:seedbed/widgets/preloader.dart';

void _openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Preloader(),
  );
}

void navigateToSendAmountScreen(
  String accountAddress,
  String displayName,
  String phoneNumber, {
  ImageProvider<dynamic> avatar,
}) {
  ExtendedNavigator.root.replace(Routes.sendAmountScreen,
      arguments: SendAmountScreenArguments(
          pageArgs: SendAmountArguments(
              name: displayName,
              accountAddress: accountAddress,
              avatar: avatar,
              phoneNumber: phoneNumber)));
}

void sendToContact(BuildContext context, String displayName, String phone,
    {ImageProvider avatar,
    String address,
    String countryCode,
    String isoCode}) async {
  if (address != null && address.isNotEmpty) {
    navigateToSendAmountScreen(address, displayName, null, avatar: avatar);
    return;
  }
  try {
    _openLoadingDialog(context);
    Map<String, dynamic> response = await phoneNumberUtil.parse(phone);
    String phoneNumber = response['e164'];
    Map wallet = await api.getWalletByPhoneNumber(response['e164']);
    String accountAddress = (wallet != null) ? wallet["walletAddress"] : null;
    navigateToSendAmountScreen(accountAddress, displayName, phoneNumber,
        avatar: avatar);
  } catch (e) {
    String formatted = formatPhoneNumber(phone, countryCode);
    bool isValid = await PhoneService.isValid(formatted, isoCode);
    if (isValid) {
      Map wallet = await api.getWalletByPhoneNumber(formatted);
      String accountAddress = (wallet != null) ? wallet["walletAddress"] : null;
      navigateToSendAmountScreen(accountAddress, displayName, formatted,
          avatar: avatar);
    }
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
    List<String> parts = scanResult.rawContent.split(':');
    bool expression = parts.length == 2 && parts[0] == 'ethereum';
    if (expression) {
      final String accountAddress = parts[1];
      sendToPastedAddress(accountAddress);
    } else {
      print('Account address is not on Fuse');
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}
