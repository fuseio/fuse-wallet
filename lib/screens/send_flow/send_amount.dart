import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gooddollar/generated/i18n.dart';
import 'package:gooddollar/models/tokens/token.dart';
import 'package:gooddollar/models/views/send_amount.dart';
import 'package:gooddollar/screens/home/widgets/token_tile.dart';
import 'package:gooddollar/screens/routes.gr.dart';
import 'package:gooddollar/screens/contacts/send_amount_arguments.dart';
import 'package:gooddollar/utils/format.dart';
import 'package:gooddollar/widgets/main_scaffold.dart';
import 'package:gooddollar/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:gooddollar/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
  Token selectedToken;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/send-amount-screen');
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
  }

  showBottomMenu(SendAmountViewModel viewModel) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        builder: (BuildContext context) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Theme.of(context).splashColor),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            color: Color(0xFFE8E8E8),
                            height: 0,
                          ),
                          itemCount: viewModel.tokens?.length ?? 0,
                          itemBuilder: (context, index) => TokenTile(
                              token: viewModel.tokens[index],
                              symbolWidth: 60,
                              symbolHeight: 60,
                              showPending: false,
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  amountText = "0";
                                  selectedToken = viewModel.tokens[index];
                                });
                              }),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = this.widget.pageArgs;
    String title =
        "${I18n.of(context).send_to} ${args.name != null ? args.name : formatAddress(args.accountAddress)}";
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      onInitialBuild: (viewModel) {
        if ([null, ''].contains(args.tokenToSend)) {
          setState(() {
            selectedToken = viewModel.tokens[0];
          });
        } else {
          setState(() {
            selectedToken = args.tokenToSend;
          });
        }
      },
      builder: (_, viewModel) {
        _onKeyPress(VirtualKeyboardKey key, {bool max = false}) {
          if (key.keyType == VirtualKeyboardKeyType.String) {
            if (amountText == "0") {
              amountText = "";
            }
            if (max) {
              amountText = key.text;
            } else {
              amountText = amountText + key.text;
            }
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
                selectedToken.amount >=
                    toBigInt(amount, selectedToken.decimals)) {
              controller.forward();
            } else {
              controller.reverse();
            }
          } catch (e) {
            controller.reverse();
          }
        }

        final BigInt balance = selectedToken?.amount;
        final int decimals = selectedToken?.decimals;
        final num currentTokenBalance =
            num.parse(formatValue(balance, decimals, withPrecision: true));
        final bool hasFund = (num.tryParse(amountText ?? 0) ?? 0)
                .compareTo(currentTokenBalance) <=
            0;

        if (!hasFund) {
          controller.forward();
        }

        return MainScaffold(
            withPadding: true,
            title: title,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  I18n.of(context).how_much,
                                  style: TextStyle(color: Color(0xFF898989)),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        String max = formatValue(
                                            selectedToken.amount,
                                            selectedToken.decimals,
                                            withPrecision: true);
                                        if (num.parse(max).compareTo(
                                                num.parse(amountText)) !=
                                            0) {
                                          _onKeyPress(
                                              VirtualKeyboardKey(
                                                  text: max,
                                                  keyType:
                                                      VirtualKeyboardKeyType
                                                          .String),
                                              max: true);
                                        }
                                      },
                                      child: Text(
                                        I18n.of(context).use_max,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ],
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
                                !args.useBridge
                                    ? InkWell(
                                        onTap: () {
                                          showBottomMenu(viewModel);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  selectedToken?.symbol ?? '',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF808080)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/images/dropdown_icon.svg',
                                                  width: 9,
                                                  height: 9,
                                                )
                                              ],
                                            )),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Divider(
                              color: Color(0xFFE8E8E8),
                              thickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                      VirtualKeyboard(
                          height: MediaQuery.of(context).size.height * 0.37,
                          fontSize: 28,
                          alwaysCaps: true,
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
                opacity: 1,
                colors: !hasFund
                    ? [
                        Theme.of(context).bottomAppBarColor,
                        Theme.of(context).bottomAppBarColor,
                      ]
                    : null,
                labelFontWeight: FontWeight.normal,
                label: hasFund
                    ? I18n.of(context).continue_with +
                        ' $amountText ${selectedToken?.symbol}'
                    : I18n.of(context).insufficient_fund,
                onPressed: () {
                  args.tokenToSend = selectedToken;
                  args.amount = num.parse(amountText);
                  ExtendedNavigator.root.pushSendReviewScreen(pageArgs: args);
                },
                preload: isPreloading,
                disabled: isPreloading || !hasFund,
                width: 300,
              ),
            )));
      },
    );
  }
}
