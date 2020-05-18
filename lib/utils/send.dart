import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:digitalrand/models/views/contacts.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';
import 'package:digitalrand/services.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:digitalrand/utils/phone.dart';

void navigateToSendAmountScreen(BuildContext context, ContactsViewModel viewModel,
    String accountAddress, String displayName, String phoneNumber,
    {Uint8List avatar}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => SendAmountScreen(
              pageArgs: SendAmountArguments(
                  erc20Token: viewModel.isProMode ? viewModel.daiToken : null,
                  sendType: viewModel.isProMode
                      ? SendType.ETHEREUM_ADDRESS
                      : accountAddress != null
                          ? SendType.FUSE_ADDRESS
                          : SendType.CONTACT,
                  name: displayName,
                  accountAddress: accountAddress,
                  avatar: avatar != null && avatar.isNotEmpty
                      ? MemoryImage(avatar)
                      : new AssetImage('assets/images/anom.png'),
                  phoneNumber: phoneNumber))));
}

void sendToContact(BuildContext context, ContactsViewModel viewModel,
    String displayName, String phone,
    {Uint8List avatar, String address}) async {
  if (address != null && address.isNotEmpty) {
    navigateToSendAmountScreen(context, viewModel, address, displayName, null, avatar: avatar);
  }
  try {
    Map<String, dynamic> response = await phoneNumberUtil.parse(phone);
    String phoneNumber = response['e164'];
    Map wallet = await api.getWalletByPhoneNumber(response['e164']);
    String accountAddress = (wallet != null) ? wallet["walletAddress"] : null;
    navigateToSendAmountScreen(context, viewModel, accountAddress, displayName, phoneNumber,
        avatar: avatar);
  } catch (e) {
    String formatted = formatPhoneNumber(phone, viewModel.countryCode);
    bool isValid = await PhoneService.isValid(formatted, viewModel.isoCode);
    if (isValid) {  
      Map wallet = await api.getWalletByPhoneNumber(formatted);
      String accountAddress = (wallet != null) ? wallet["walletAddress"] : null;
      navigateToSendAmountScreen(context, viewModel, accountAddress, displayName, formatted,
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
                  erc20Token: viewModel.isProMode ? viewModel.daiToken : null,
                  sendType: viewModel.isProMode
                      ? SendType.ETHEREUM_ADDRESS
                      : SendType.PASTED_ADDRESS,
                  accountAddress: accountAddress,
                  name: formatAddress(accountAddress),
                  avatar: new AssetImage('assets/images/anom.png')))));
}
