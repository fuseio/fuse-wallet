import 'package:flutter/material.dart';
import 'package:fusecash/models/views/contacts.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/widgets/preloader.dart';

void _openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Preloader();
    },
  );
}

void navigateToSendAmountScreen(
  BuildContext context,
  ContactsViewModel viewModel,
  String accountAddress,
  String displayName,
  String phoneNumber, {
  ImageProvider<dynamic> avatar,
}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => SendAmountScreen(
              pageArgs: SendAmountArguments(
                  name: displayName,
                  accountAddress: accountAddress,
                  avatar: avatar,
                  phoneNumber: phoneNumber))));
}

void sendToContact(BuildContext context, ContactsViewModel viewModel,
    String displayName, String phone,
    {ImageProvider avatar, String address}) async {
  if (address != null && address.isNotEmpty) {
    navigateToSendAmountScreen(context, viewModel, address, displayName, null,
        avatar: avatar);
    return;
  }
  try {
    _openLoadingDialog(context);
    Map<String, dynamic> response = await phoneNumberUtil.parse(phone);
    String phoneNumber = response['e164'];
    Map wallet = await api.getWalletByPhoneNumber(response['e164']);
    Navigator.pop(context);
    String accountAddress = (wallet != null) ? wallet["walletAddress"] : null;
    navigateToSendAmountScreen(
        context, viewModel, accountAddress, displayName, phoneNumber,
        avatar: avatar);
  } catch (e) {
    String formatted = formatPhoneNumber(phone, viewModel.countryCode);
    bool isValid = await PhoneService.isValid(formatted, viewModel.isoCode);
    if (isValid) {
      Map wallet = await api.getWalletByPhoneNumber(formatted);
      String accountAddress = (wallet != null) ? wallet["walletAddress"] : null;
      Navigator.pop(context);
      navigateToSendAmountScreen(
          context, viewModel, accountAddress, displayName, formatted,
          avatar: avatar);
    }
  }
}

void sendToPastedAddress(
    BuildContext context, ContactsViewModel viewModel, accountAddress) {
  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => SendAmountScreen(
              pageArgs: SendAmountArguments(
                  // erc20Token: viewModel.isProMode ? viewModel.daiToken : null,
                  // feePlugin: viewModel.isProMode ? viewModel.feePlugin : null,
                  // sendType: viewModel.isProMode
                  //     ? SendType.ETHEREUM_ADDRESS
                  //     : SendType.PASTED_ADDRESS,
                  accountAddress: accountAddress,
                  name: formatAddress(accountAddress),
                  avatar: new AssetImage('assets/images/anom.png')))));
}
