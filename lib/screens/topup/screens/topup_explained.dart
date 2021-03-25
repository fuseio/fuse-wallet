import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/screens/topup/screens/topup.dart';
import 'package:peepl/widgets/my_app_bar.dart';
import 'package:peepl/widgets/primary_button.dart';
import 'package:peepl/models/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:peepl/screens/topup/router/topup_router.gr.dart';

class TopupExplained extends StatefulWidget {
  TopupExplained({
    Key key,
  }) : super(key: key);

  @override
  _TopupExplainedState createState() => _TopupExplainedState();
}

class _TopupExplainedState extends State<TopupExplained> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> texts = [
    "Top up using Stripe, one of the worlds most trusted payment processors.",
    "Just use your credit or debit card. It takes less than a minute. 😉",
    "Stripe is fully regulated by the FCA and used by millions of businesses worldwide."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                'Top up your Peepl wallet using Stripe',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: Center(
                child: PrimaryButton(
                  label: "Let's do it",
                  fontSize: 35,
                  width: MediaQuery.of(context).size.width * .7,
                  radius: 20,
                  height: 80,
                  labelFontWeight: FontWeight.bold,
                  onPressed: () {
                    ExtendedNavigator.named('topupRouter').pushTopupScreen(
                      topupType: TopupType.STRIPE,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
