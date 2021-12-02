import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supervecina/generated/l10n.dart';

void showErrorSnack({
  required BuildContext context,
  String? title,
  int duration = 3,
  EdgeInsets? margin,
  message,
}) {
  Flushbar(
    boxShadows: [
      BoxShadow(
        offset: Offset(0.5, 0.5),
        blurRadius: 5,
      ),
    ],
    duration: Duration(seconds: duration),
    titleText: Text(
      title ?? I10n.of(context).transaction_failed,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 14.0,
      ),
    ),
    backgroundColor: Theme.of(context).bottomAppBarColor,
    margin: margin ?? EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 80),
    borderRadius: 8,
    icon: SvgPicture.asset(
      'assets/images/failed_icon.svg',
      width: 20,
      height: 20,
    ),
  ).show(context);
}

void showCopiedFlushbar(context) {
  Flushbar(
    duration: Duration(seconds: 1),
    boxShadows: [
      BoxShadow(
        offset: Offset(0.5, 0.5),
        blurRadius: 5,
      ),
    ],
    messageText: Text(
      I10n.of(context).copied_to_clipboard,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Theme.of(context).bottomAppBarColor,
    margin: EdgeInsets.only(
      top: 8,
      right: 8,
      left: 8,
      bottom: 100,
    ),
    borderRadius: 8,
  ).show(context);
}
