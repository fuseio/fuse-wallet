import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class SwapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      automaticallyImplyLeading: false,
      title: I18n.of(context).coming_soon,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Soon you will be able to swap your Fuse Dollars to other currencies with the best experience in the industry and no gas!')
            ],
          ),
        )
      ],
    );
  }
}