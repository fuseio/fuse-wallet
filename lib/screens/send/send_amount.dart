import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/token.dart';

class SendAmountScreen extends StatefulWidget {
  final SendAmountArguments pageArgs;
  SendAmountScreen({this.pageArgs});
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
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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
    final SendAmountArguments args = this.widget.pageArgs;
    String title =
        "${I18n.of(context).send_to} ${args.name != null ? args.name : formatAddress(args.accountAddress)}";
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
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
            title: title,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: Text(I18n.of(context).how_much,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40.0, bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text('$amountText ', // ${viewModel.token.symbol}
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w900)),
                                  Text(viewModel.token.symbol,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900)),
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
                    ]),
              )
            ],
            footer: Center(
                child: SlideTransition(
              position: offset,
              child: PrimaryButton(
                labelFontWeight: FontWeight.normal,
                label: I18n.of(context).continue_with +
                    ' $amountText ${viewModel.token.symbol}',
                onPressed: () {
                  args.amount = num.parse(amountText);
                  Router.navigator
                      .pushNamed(Router.sendReviewScreen, arguments: args);
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
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return SendAmountViewModel(
        token: community.token, balance: community.tokenBalance);
  }
}
