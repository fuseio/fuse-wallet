import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void comingSoon(context) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    duration: Duration(seconds: 2),
    messageText: new Text(
      "Coming soon",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
  )..show(context);
}