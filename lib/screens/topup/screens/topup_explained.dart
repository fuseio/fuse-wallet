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
    "Top up with Stripe, who use \n the UK's Open Banking API",
    "This is much cheaper for the \n restaurants in your \n community compared to \n Debit and Credit Card",
    "Stripe Are fully regulated \n by the FCA, and only connect \n to your bank account to make \n initiating a payment easier"
  ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _TopupExplainedViewModel>(
      distinct: true,
      converter: _TopupExplainedViewModel.fromStore,
      builder: (_, viewModel) {
        return Scaffold(
          appBar: MyAppBar(
            height: 100,
            child: Container(
              padding: EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
                bottom: 15.0,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withAlpha(20),
                    blurRadius: 30.0,
                    spreadRadius: 10.0,
                    offset: Offset(
                      0.0,
                      3.0,
                    ),
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Keep More Money In",
                      style: TextStyle(
                          fontSize: 26, color: Theme.of(context).splashColor),
                    ),
                    Row(
                      children: [
                        Text(
                          "Your ",
                          style: TextStyle(
                              fontSize: 26,
                              color: Theme.of(context).splashColor),
                        ),
                        Text(
                          "Local Community",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).splashColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: texts.map((e) => item(e)).toList(),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: PrimaryButton(
                      label: 'Top up Using Stripe',
                      fontSize: 16,
                      labelFontWeight: FontWeight.normal,
                      onPressed: () {
                        ExtendedNavigator.named('topupRouter').pushTopupScreen(
                          topupType: TopupType.STRIPE,
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'If you had problems with Stripe you can top up \n using debit or credit card ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                            text: "Top up now",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                ExtendedNavigator.named('topupRouter')
                                    .pushTopupScreen(
                                  topupType: TopupType.PLAID,
                                );
                              }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget item(String text) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: 150,
      ),
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PlatformIcons(context).checkMark,
            color: Theme.of(context).primaryColorDark,
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
              child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ))
        ],
      ),
    );
  }
}

class _TopupExplainedViewModel extends Equatable {
  final String walletAddress;
  _TopupExplainedViewModel({
    this.walletAddress,
  });

  static _TopupExplainedViewModel fromStore(Store<AppState> store) {
    return _TopupExplainedViewModel(
      walletAddress: store.state.userState?.walletAddress ?? '',
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
      ];
}
