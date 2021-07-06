import 'package:auto_route/auto_route.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
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
    PhoneNumber phoneNumber = await phoneNumberUtil.parse(
      phone,
      regionCode: isoCode,
    );
    Map? wallet = await api.getWalletByPhoneNumber(phoneNumber.e164);
    String? walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
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
      String? walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      return {
        'phoneNumber': phoneNumber.e164,
        'walletAddress': walletAddress,
      };
    } else {
      throw 'Phone number isnt valid - $e';
    }
  }
}

void openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Preloader(),
  );
}

void sendToContact(
  BuildContext context,
  String displayName,
  String phone,
  String countryCode,
  String isoCode, {
  ImageProvider? avatar,
  String? address,
  Token? tokenToSend,
}) async {
  if (address != null && address.isNotEmpty) {
    final args = SendFlowArguments(
      accountAddress: address,
      avatar: AssetImage('assets/images/anom.png'),
      name: displayName,
      tokenToSend: tokenToSend,
    );
    context.navigateTo(
      ContactsTab(
        children: [
          ContactsList(
            pageArgs: args,
          ),
          SendAmountScreen(
            pageArgs: args,
          ),
        ],
      ),
    );
  } else {
    openLoadingDialog(context);
    Map res = await fetchWalletByPhone(phone, countryCode, isoCode);
    context.router.pop();
    final args = SendFlowArguments(
      phoneNumber: res['phoneNumber'],
      accountAddress: res['walletAddress'],
      avatar: AssetImage('assets/images/anom.png'),
      name: displayName,
      tokenToSend: tokenToSend,
    );
    context.navigateTo(
      ContactsTab(
        children: [
          ContactsList(
            pageArgs: args,
          ),
          SendAmountScreen(
            pageArgs: args,
          ),
        ],
      ),
    );
  }
}

void sendToPastedAddress(
  BuildContext context,
  accountAddress, {
  Token? token,
}) {
  final args = SendFlowArguments(
    accountAddress: accountAddress,
    avatar: AssetImage('assets/images/anom.png'),
    name: formatAddress(accountAddress),
    tokenToSend: token,
  );
  context.navigateTo(
    ContactsTab(
      children: [
        ContactsList(
          pageArgs: args,
        ),
        SendAmountScreen(
          pageArgs: args,
        ),
      ],
    ),
  );
}

void barcodeScannerHandler(
  BuildContext context,
  String scanResult,
) async {
  log.info('scanResult $scanResult');
  try {
    PermissionStatus permission = await Permission.camera.request();
    if (permission == PermissionStatus.granted) {
      final bool hasColon = scanResult.contains(':');
      if (hasColon) {
        List<String> parts = scanResult.split(':');
        bool expression =
            parts.length == 2 && (parts[0] == 'fuse' || parts[0] == 'ethereum');
        if (expression) {
          final String accountAddress =
              parts[0] == 'fuse' ? parts[1].replaceFirst('f', 'x') : parts[1];
          if (isValidEthereumAddress(checksumEthereumAddress(accountAddress))) {
            sendToPastedAddress(context, accountAddress);
          } else {
            throw 'ERROR';
          }
        } else {
          throw 'ERROR';
        }
      } else if (isValidEthereumAddress(checksumEthereumAddress(scanResult))) {
        sendToPastedAddress(context, scanResult);
      }
    }
  } catch (e, s) {
    log.error('ERROR - BarcodeScanner ${e.toString()} ${s.toString()}');
    Flushbar(
      duration: Duration(seconds: 2),
      boxShadows: [
        BoxShadow(
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
