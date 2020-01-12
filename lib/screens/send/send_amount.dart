import 'package:flutter/material.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/token.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendAmountScreen extends StatefulWidget {
  @override
  _SendAmountScreenState createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "0";
  AnimationController controller;
  Animation<Offset> offset;
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = ModalRoute.of(context).settings.arguments;

    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: (store) {
        return SendAmountViewModel.fromStore(store);
      },
      builder: (_, viewModel) {
        _onKeyPress(VirtualKeyboardKey key) {
          if (key.keyType == VirtualKeyboardKeyType.String) {
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
          if (amountText == "") {
            amountText = "0";
          }
          try {
            double amount = double.parse(amountText);
            if (amount > 0 &&
                viewModel.balance >=
                    toBigInt(amount, viewModel.token.decimals)) {
              // if (double s = value / BigInt.from(pow(10, decimals));)
              controller.forward();
            } else {
              controller.reverse();
            }
          } catch (e) {
            controller.reverse();
          }
        }

        return MainScaffold(
            withPadding: true,
            titleFontSize: 15,
            title:
                "Send to ${args.name != null ? args.name : formatAddress(args.accountAddress)}",
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text("How much?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      Container(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 30),
                              child: Text(
                                  '$amountText ${viewModel.token.symbol}',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                VirtualKeyboard(
                    height: 300,
                    fontSize: 28,
                    textColor: Theme.of(context).primaryColor,
                    type: VirtualKeyboardType.Numeric,
                    onKeyPress: _onKeyPress),
              ]))
            ],
            footer: Center(
                child: SlideTransition(
              position: offset,
              child: PrimaryButton(
                labelFontWeight: FontWeight.normal,
                label: 'Continue with $amountText ${viewModel.token.symbol}',
                onPressed: () {
                  args.amount = num.parse(amountText);
                  Navigator.pushNamed(context, '/SendReview', arguments: args);
                },
                preload: isPreloading,
                width: 300,
              ),
            )));
      },
    );
  }
}

class SendAmountViewModel {
  final BigInt balance;
  final Token token;

  SendAmountViewModel({this.balance, this.token});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    return SendAmountViewModel(
        token: store.state.cashWalletState.token,
        balance: store.state.cashWalletState.tokenBalance);
  }
}
