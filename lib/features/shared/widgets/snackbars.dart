import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';

void showErrorSnack({
  required BuildContext context,
  String? title,
  Duration? duration,
  EdgeInsets? margin,
  String? message,
}) {
  Flushbar(
      boxShadows: [
        BoxShadow(
          offset: Offset(0.5, 0.5),
          blurRadius: 5,
        ),
      ],
      duration: duration,
      titleText: Text(
        title ?? I10n.of(context).transaction_failed,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      messageText: message != null
          ? Text(
              message,
              style: TextStyle(
                fontSize: 14.0,
              ),
            )
          : null,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      margin: margin ?? EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 80),
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      icon: SvgPicture.asset(
        'assets/images/failed_icon.svg',
        width: 20,
        height: 20,
      ))
    ..show(context);
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
    borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
  )..show(context);
}
