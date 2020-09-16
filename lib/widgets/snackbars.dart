import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:esol/generated/i18n.dart';

void transactionFailedSnack(message,
    {BuildContext context,
    String title,
    Duration duration,
    EdgeInsets margin}) {
  Flushbar(
      boxShadows: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.5, 0.5),
          blurRadius: 5,
        ),
      ],
      duration: duration,
      titleText: Text(
        title ?? I18n.of(ExtendedNavigator.root.context).transaction_failed,
        style: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 14.0, color: Colors.black),
      ),
      backgroundColor:
          Theme.of(ExtendedNavigator.root.context).bottomAppBarColor,
      margin: margin ?? EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 80),
      borderRadius: 8,
      icon: SvgPicture.asset(
        'assets/images/failed_icon.svg',
        width: 20,
        height: 20,
      ))
    ..show(context ?? ExtendedNavigator.named('homeRouter').context);
}
