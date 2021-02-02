import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class SwapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        automaticallyImplyLeading: false,
        title: I18n.of(context).swap,
        children: <Widget>[
          Image.asset(
            'assets/images/swap-illustr.png',
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  I18n.of(context).coming_soon,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
