import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:esol/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:esol/models/views/send_amount.dart';
import 'package:esol/screens/home/widgets/token_tile.dart';
import 'package:esol/screens/routes.gr.dart';
import 'package:esol/screens/contacts/send_amount_arguments.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/widgets/main_scaffold.dart';
import 'package:esol/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:esol/models/app_state.dart';
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
                              symbolWidth: 45,
                              symbolHeight: 45,
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
    // String title =
    //     "${I18n.of(context).send_to} ${args.name != null ? args.name : formatAddress(args.accountAddress)}";
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
          drawerIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).splashColor,
                  borderRadius: new BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
          ),
          expandedHeight: MediaQuery.of(context).size.height * 0.26,
          newHeaderAppBar: Header(
            image: args.avatar,
            imageshow: false,
            contactEmpty: true,
            textshow: true,
          ),
          withPadding: true,
          title:
              FittedBox(child: Container(width: 100, child: Text(args.name))),
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 40),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       // Text(
                  //       //   I18n.of(context).how_much,
                  //       //   style: TextStyle(color: Color(0xFF898989)),
                  //       // ),
                  //       // Container(
                  //       //   padding: EdgeInsets.symmetric(
                  //       //       vertical: 3, horizontal: 15),
                  //       //   decoration: BoxDecoration(
                  //       //     borderRadius:
                  //       //         BorderRadius.all(Radius.circular(10)),
                  //       //   ),
                  //       //   child: InkWell(
                  //       //       onTap: () {
                  //       //         String max = formatValue(
                  //       //             selectedToken.amount,
                  //       //             selectedToken.decimals,
                  //       //             withPrecision: true);
                  //       //         if (num.parse(max).compareTo(
                  //       //                 num.parse(amountText)) !=
                  //       //             0) {
                  //       //           _onKeyPress(
                  //       //               VirtualKeyboardKey(
                  //       //                   text: max,
                  //       //                   keyType:
                  //       //                       VirtualKeyboardKeyType
                  //       //                           .String),
                  //       //               max: true);
                  //       //         }
                  //       //       },
                  //       //       child: Text(
                  //       //         I18n.of(context).use_max,
                  //       //         style: TextStyle(
                  //       //             fontSize: 15,
                  //       //             fontWeight: FontWeight.bold),
                  //       //       )),
                  //       // )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            amountText,
                            style: TextStyle(
                              fontSize: 40.0,
                              // fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          !args.useBridge
                              ? InkWell(
                                  onTap: () {
                                    showBottomMenu(viewModel);
                                  },
                                  child: Text(
                                    'E-SOL' ?? '',
                                    style: TextStyle(
                                      fontSize: 40,
                                      // fontWeight: FontWeight.bold,
                                      // color: Color(0xFF808080),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: 40, vertical: 20),
                  //   child: Divider(
                  //     color: Color(0xFFE8E8E8),
                  //     thickness: 1.5,
                  //   ),
                  // ),
                  Expanded(flex: 1, child: SizedBox.shrink()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: Cro,
                    children: [
                      Text('Balance disponible: '),
                      Text(
                        ' E-SOL ${formatValue(selectedToken?.amount, selectedToken?.decimals, withPrecision: true)}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(218, 225, 249, 1),
                        ),
                        child:
                            Image.asset('assets/images/another_eye_hide.png'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: VirtualKeyboard(
                        height: MediaQuery.of(context).size.height * 0.4,
                        fontSize: 28,
                        alwaysCaps: true,
                        textColor: Theme.of(context).primaryColor,
                        type: VirtualKeyboardType.Numeric,
                        onKeyPress: _onKeyPress),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                      ))
                ],
              ),
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
                    ? I18n.of(context).continue_with + ' $amountText E-SOL'
                    : I18n.of(context).insufficient_fund,
                onPressed: () {
                  args.tokenToSend = selectedToken;
                  args.amount = num.parse(amountText);
                  ExtendedNavigator.root.replace(Routes.sendReviewScreen,
                      arguments: SendReviewScreenArguments(pageArgs: args));
                },
                preload: isPreloading,
                disabled: isPreloading || !hasFund,
                width: 300,
              ),
            ),
          ),
        );
      },
    );
  }
}
