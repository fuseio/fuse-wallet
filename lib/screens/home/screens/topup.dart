import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/constans/keys.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/services.dart';
import 'package:peepl/utils/send.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:peepl/widgets/primary_button.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';

class TopupScreen extends StatefulWidget {
  final String walletAddress;
  TopupScreen({this.walletAddress});
  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "100";
  bool isPreloading = false;

  void _onSuccessCallback(
    String publicToken,
    LinkSuccessMetadata metadata,
  ) async {
    final BottomNavigationBar navigationBar =
        AppKeys.bottomBarKey.currentWidget;
    navigationBar.onTap(0);
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
    String body = jsonEncode(Map.from(
        {'walletAddress': widget.walletAddress, 'publicToken': publicToken}));
    print('body body body $body');
    Map res = responseHandler(await client.post(
      'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/plaid/set_access_token',
      body: body,
      headers: {"Content-Type": 'application/json'},
    ));
    print('res res res ${res.toString()}');
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(String error, LinkExitMetadata metadata) {
    print("onExit: $error, metadata: ${metadata.description()}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/topup-screen');
  }

  void _createLinkToken() async {
    PlaidLink _plaidLinkToken;
    String body = jsonEncode(Map.from({
      'walletAddress': widget.walletAddress,
      'value': num.parse(amountText),
      'reference': 'Top up',
      'isAndroid': Platform.isAndroid
    }));
    openLoadingDialog(context);
    Map response = responseHandler(await client.post(
        'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/plaid/create_link_token_for_payment',
        headers: {"Content-Type": 'application/json'},
        body: body));
    Navigator.of(context).pop();
    print('response ${response.toString()}');

    if (response['link_token'] != null) {
      _plaidLinkToken = PlaidLink(
        configuration: LinkConfiguration(
          linkToken: response['link_token'],
        ),
        onSuccess: _onSuccessCallback,
        onEvent: _onEventCallback,
        onExit: _onExitCallback,
      );
      _plaidLinkToken.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    _onKeyPress(VirtualKeyboardKey key) {
      if (key.keyType == VirtualKeyboardKeyType.String) {
        if (amountText == "") {
          amountText = "0";
        }
        if (amountText == "0") {
          amountText = "";
        }
        amountText = amountText + key.text;
      } else if (key.keyType == VirtualKeyboardKeyType.Action) {
        switch (key.action) {
          case VirtualKeyboardKeyAction.Backspace:
            if (amountText.length == 0) return;
            amountText = amountText.substring(0, amountText.length - 1);
            break;
          case VirtualKeyboardKeyAction.Return:
            amountText = amountText + '\n';
            break;
          case VirtualKeyboardKeyAction.Space:
            amountText = amountText + key.text;
            break;
          default:
        }
      }
      setState(() {});
    }

    return MainScaffold(
        withPadding: true,
        title: I18n.of(context).top_up,
        automaticallyImplyLeading: false,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          I18n.of(context).how_much,
                          style: TextStyle(color: Color(0xFF898989)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: AutoSizeText(
                                amountText,
                                style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'GBP',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF808080)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Divider(
                          color: Color(0xFFE8E8E8),
                          thickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                  VirtualKeyboard(
                      fontSize: 28,
                      alwaysCaps: true,
                      height: MediaQuery.of(context).size.height * 0.3,
                      textColor: Theme.of(context).primaryColor,
                      type: VirtualKeyboardType.Numeric,
                      onKeyPress: _onKeyPress),
                ]),
          )
        ],
        footer: Center(
            child: PrimaryButton(
          opacity: 1,
          labelFontWeight: FontWeight.normal,
          label: I18n.of(context).next_button,
          onPressed: _createLinkToken,
          preload: isPreloading,
          disabled: isPreloading,
          width: 300,
        )));
  }
}
