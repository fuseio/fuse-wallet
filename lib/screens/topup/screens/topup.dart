import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/constans/keys.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/screens/topup/dialogs/card_failed.dart';
import 'package:peepl/screens/topup/dialogs/minting_dialog.dart';
import 'package:peepl/services.dart';
import 'package:peepl/utils/constans.dart';
import 'package:peepl/utils/stripe.dart';
import 'package:peepl/utils/stripe_custom_response.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:peepl/widgets/primary_button.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

class _TopUpViewModel extends Equatable {
  final String walletAddress;

  _TopUpViewModel({
    this.walletAddress,
  });

  static _TopUpViewModel fromStore(Store<AppState> store) {
    return _TopUpViewModel(
      walletAddress: store.state.userState.walletAddress,
    );
  }

  @override
  List<Object> get props => [walletAddress];
}

enum TopupType { STRIPE, PLAID }

class TopupScreen extends StatefulWidget {
  final TopupType topupType;
  TopupScreen({this.topupType = TopupType.STRIPE});
  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "25";
  bool isPreloading = false;

  void _onSuccessCallback(
    String publicToken,
    LinkSuccessMetadata metadata,
    String walletAddress,
  ) async {
    final BottomNavigationBar navigationBar =
        AppKeys.bottomBarKey.currentWidget;
    navigationBar.onTap(0);
    String body = jsonEncode(
        Map.from({'walletAddress': walletAddress, 'publicToken': publicToken}));
    responseHandler(
      await client.post(
        '$topUpService/plaid/set_access_token',
        body: body,
        headers: {"Content-Type": 'application/json'},
      ),
    );
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

  void _handlePlaid(String walletAddress) async {
    PlaidLink _plaidLinkToken;
    String body = jsonEncode(Map.from({
      'walletAddress': walletAddress,
      'value': num.parse(amountText),
      'reference': 'Top up',
      'isAndroid': Platform.isAndroid
    }));
    Map response = responseHandler(
      await client.post(
        '$topUpService/plaid/create_link_token_for_payment',
        headers: {"Content-Type": 'application/json'},
        body: body,
      ),
    );

    if (response['link_token'] != null) {
      _plaidLinkToken = PlaidLink(
        configuration: LinkConfiguration(
          linkToken: response['link_token'],
        ),
        onSuccess: (
          String publicToken,
          LinkSuccessMetadata metadata,
        ) =>
            _onSuccessCallback(publicToken, metadata, walletAddress),
        onEvent: _onEventCallback,
        onExit: _onExitCallback,
      );
      _plaidLinkToken.open();
    }
  }

  void _handleStripe(String walletAddress) async {
    final StripeCustomResponse response = await StripeService().payWithNewCard(
      amount: amountText,
      walletAddress: walletAddress,
      currency: 'GBP',
    );
    if (response.ok) {
      showDialog(
        context: context,
        builder: (context) => MintingDialog(amountText, true),
        barrierDismissible: false,
      );
    } else {
      if (!response.msg.contains('Cancelled by user')) {
        showDialog(
          context: context,
          builder: (context) => TopUpFailed(),
        );
      }
    }
  }

  _onPress(String walletAddress) async {
    if (widget.topupType == TopupType.PLAID) {
      _handlePlaid(walletAddress);
    } else if (widget.topupType == TopupType.STRIPE) {
      _handleStripe(walletAddress);
    }
  }

  //decimal place checker
  String decimalChecker(double a, {int decimalPlaces = 2}) {
    List<String> values = a.toString().split('.');
    if (values.length == 2 && values[1].length > decimalPlaces) {
      return "Too long";
    } else {
      return a.toString();
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
        if (!(num.parse(amountText + key.text) > 250) &&
            !(decimalChecker(double.parse(amountText + key.text)) ==
                'Too long')) {
          // Don't allow topping up more than £250
          amountText = amountText + key.text;
        }

        // TODO: Disallow decimals greater than 2 places (i.e. 25.0192)
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
      title: 'Top up using your card',
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
      footer: StoreConnector<AppState, _TopUpViewModel>(
        distinct: true,
        converter: _TopUpViewModel.fromStore,
        builder: (_, viewModel) => Center(
          child: PrimaryButton(
            opacity: 1,
            labelFontWeight: FontWeight.normal,
            label: I18n.of(context).next_button,
            onPressed: () => _onPress(viewModel.walletAddress),
            preload: isPreloading,
            disabled: isPreloading,
            width: 300,
          ),
        ),
      ),
    );
  }
}
