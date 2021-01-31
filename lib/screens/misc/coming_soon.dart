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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(
                      I18n.of(context).coming_soon,
                    ),
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
