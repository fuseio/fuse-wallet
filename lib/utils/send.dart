import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_number/phone_number.dart';

Future<Map> fetchWalletByPhone(
  String phone,
  String countryCode,
  String isoCode,
) async {
  try {
    PhoneNumber phoneNumber = await phoneNumberUtil.parse(phone);
    Map? wallet = await api.getWalletByPhoneNumber(phoneNumber.e164);
    String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;

    return {
      'phoneNumber': phoneNumber.e164,
      'walletAddress': walletAddress,
    };
  } catch (e) {
    String formatted = formatPhoneNumber(phone, countryCode);
    bool isValid = await phoneNumberUtil.validate(formatted, isoCode);
    if (isValid) {
      PhoneNumber phoneNumber = await phoneNumberUtil.parse(
        formatted,
        regionCode: isoCode,
      );
      Map? wallet = await api.getWalletByPhoneNumber(phoneNumber.e164);
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      return {
        'phoneNumber': phoneNumber.e164,
        'walletAddress': walletAddress,
      };
    } else {
      throw 'Phone number isnt valid - $e';
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

void sendToContact(
  BuildContext context,
  String displayName,
  String phone, {
  ImageProvider? avatar,
  String? address,
  String? countryCode,
  String? isoCode,
  Token? tokenToSend,
}) async {
  if (address != null && address.isNotEmpty) {
    // ExtendedNavigator.root.pushSendAmountScreen(
    //   pageArgs: SendFlowArguments(
    //     accountAddress: address,
    //     name: displayName,
    //     avatar: avatar,
    //     tokenToSend: tokenToSend,
    //   ),
    // );
    return;
  }
  try {
    _openLoadingDialog(context);
    // Map res = await fetchWalletByPhone(phone, countryCode, isoCode);
    Navigator.of(context).pop();
    // ExtendedNavigator.root.pushSendAmountScreen(
    //   pageArgs: SendFlowArguments(
    //     phoneNumber: res['phoneNumber'],
    //     accountAddress: res['walletAddress'],
    //     name: displayName,
    //     avatar: avatar,
    //     tokenToSend: tokenToSend,
    //   ),
    // );
  } catch (e) {
    Navigator.of(context).pop();
    throw '$e';
  }
}

void sendToPastedAddress(
  accountAddress, {
  Token? token,
}) {
  // ExtendedNavigator.root.pushSendAmountScreen(
  //   pageArgs: SendFlowArguments(
  //     accountAddress: accountAddress,
  //     avatar: AssetImage('assets/images/anom.png'),
  //     name: formatAddress(accountAddress),
  //     tokenToSend: token,
  //   ),
  // );
}

void barcodeScannerHandler(context) async {
  try {
    PermissionStatus permission = await Permission.camera.request();
    // if (permission == PermissionStatus.granted) {
    //   ScanResult scanResult = await BarcodeScanner.scan();
    //   final String rawData = scanResult.rawContent;
    //   final bool hasColon = rawData.contains(':');
    //   if (hasColon) {
    //     List<String> parts = scanResult.rawContent.split(':');
    //     bool expression =
    //         parts.length == 2 && (parts[0] == 'fuse' || parts[0] == 'ethereum');
    //     if (expression) {
    //       final String accountAddress =
    //           parts[0] == 'fuse' ? parts[1].replaceFirst('f', 'x') : parts[1];
    //       if (isValidEthereumAddress(accountAddress)) {
    //         sendToPastedAddress(accountAddress);
    //       } else {
    //         throw 'ERROR';
    //       }
    //     } else {
    //       throw 'ERROR';
    //     }
    //   } else if (isValidEthereumAddress(rawData)) {
    //     sendToPastedAddress(scanResult.rawContent);
    //   }
    // }
  } catch (e) {
    log.error('ERROR - BarcodeScanner');
    Flushbar(
      duration: Duration(seconds: 2),
      boxShadows: [
        BoxShadow(
          // color: Colors.grey[500],
          offset: Offset(0.5, 0.5),
          blurRadius: 5,
        ),
      ],
      titleText: Text(
        I10n.of(context).error,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        I10n.of(context).invalid_qa_code,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      margin: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 100),
      borderRadius: 8,
      icon: SvgPicture.asset(
        'assets/images/failed_icon.svg',
        width: 20,
        height: 20,
      ),
    )..show(context);
  }
}
