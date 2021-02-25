import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peepl/constans/keys.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/services.dart';
import 'package:peepl/utils/stripe.dart';
import 'package:peepl/utils/stripe_custom_response.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:peepl/widgets/primary_button.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';

enum TopupType { STRIPE, PLAID }

class TopupScreen extends StatefulWidget {
  final String walletAddress;
  final TopupType topupType;
  TopupScreen({this.walletAddress, this.topupType = TopupType.STRIPE});
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
    String body = jsonEncode(Map.from(
        {'walletAddress': widget.walletAddress, 'publicToken': publicToken}));
    responseHandler(await client.post(
      'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/plaid/set_access_token',
      body: body,
      headers: {"Content-Type": 'application/json'},
    ));
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

  void _handlePlaid() async {
    PlaidLink _plaidLinkToken;
    String body = jsonEncode(Map.from({
      'walletAddress': widget.walletAddress,
      'value': num.parse(amountText),
      'reference': 'Top up',
      'isAndroid': Platform.isAndroid
    }));
    Map response = responseHandler(
      await client.post(
        'http://ec2-18-198-1-146.eu-central-1.compute.amazonaws.com/api/plaid/create_link_token_for_payment',
        headers: {"Content-Type": 'application/json'},
        body: body,
      ),
    );

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

  void _handleStripe() async {
    final StripeCustomResponse response = await StripeService().payWithNewCard(
      amount: amountText,
      walletAddress: widget.walletAddress,
      currency: 'GBP',
    );
    if (response.ok) {
      final BottomNavigationBar navigationBar =
          AppKeys.bottomBarKey.currentWidget;
      navigationBar.onTap(0);
      ExtendedNavigator.named('homeRouter').popUntilRoot();
      ExtendedNavigator.named('topupRouter').popUntilRoot();
      Flushbar(
          boxShadows: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.5, 0.5),
              blurRadius: 5,
            ),
          ],
          titleText: Text(
            I18n.of(context).success,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            I18n.of(context).success,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          margin: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 100),
          borderRadius: 8,
          icon: SvgPicture.asset(
            'assets/images/approve_icon.svg',
            width: 20,
            height: 20,
          ))
        ..show(ExtendedNavigator.named('homeRouter').context);
    } else {
      Flushbar(
          boxShadows: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.5, 0.5),
              blurRadius: 5,
            ),
          ],
          titleText: Text(
            I18n.of(context).oops,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            I18n.of(context).something_went_wrong,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          margin: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 100),
          borderRadius: 8,
          icon: SvgPicture.asset(
            'assets/images/failed_icon.svg',
            width: 20,
            height: 20,
          ))
        ..show(context);
    }
  }

  _onPress() async {
    if (widget.topupType == TopupType.PLAID) {
      _handlePlaid();
    } else if (widget.topupType == TopupType.STRIPE) {
      _handleStripe();
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
      title: 'Top up using ${EnumToString.convertToString(widget.topupType)}',
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
                                  fontSize: 40.0, fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
          onPressed: _onPress,
          preload: isPreloading,
          disabled: isPreloading,
          width: 300,
        ),
      ),
    );
  }
}
