import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:fusecash/models/app_state.dart';
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
  bool hasBalance = true;
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
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).canvasColor,
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          I18n.of(context).token,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Europa',
                            fontSize: 22,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            separatorBuilder: (_, int index) => Divider(
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onKeyPress(String value, {bool max = false, bool back = false}) {
    if (max) {
      amountText = value;
    } else if (back) {
      if (amountText.length == 0) return;
      amountText = amountText.substring(0, amountText.length - 1);
    } else {
      String newAmount = amountText + value;
      amountText = newAmount;
    }
    setState(() {});
    try {
      final bool hasFund =
          (Decimal.tryParse(amountText) ?? Decimal.zero).compareTo(
                Decimal.parse(
                  formatValue(
                    selectedToken?.amount,
                    selectedToken?.decimals,
                    withPrecision: true,
                  ),
                ),
              ) <=
              0;
      if (hasFund) {
        controller.forward();
      } else {
        controller.reverse();
      }
    } catch (e) {
      controller.reverse();
    }
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
        final bool hasFund =
            (Decimal.tryParse(amountText) ?? Decimal.zero).compareTo(
                  Decimal.parse(
                    formatValue(
                      selectedToken?.amount,
                      selectedToken?.decimals,
                      withPrecision: true,
                    ),
                  ),
                ) <=
                0;

        if (!hasFund) {
          controller.forward();
        }
        return MyScaffold(
          title: title,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      I18n.of(context).how_much,
                                      style:
                                          TextStyle(color: Color(0xFF898989)),
                                    ),
                                    InkWell(
                                      focusColor: Theme.of(context).canvasColor,
                                      highlightColor:
                                          Theme.of(context).canvasColor,
                                      onTap: () {
                                        // String maxValue = formatValue(
                                        //   selectedToken.amount,
                                        //   selectedToken.decimals,
                                        //   withPrecision: true,
                                        // );
                                        String max = selectedToken.getBalance();
                                        if (num.parse(max).compareTo(
                                                (num.tryParse(amountText) ??
                                                    0)) !=
                                            0) {
                                          _onKeyPress(max, max: true);
                                        }
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
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
                                            focusColor:
                                                Theme.of(context).canvasColor,
                                            highlightColor:
                                                Theme.of(context).canvasColor,
                                            onTap: () {
                                              showBottomMenu(viewModel);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      selectedToken?.symbol ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xFF808080)),
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
                                  thickness: 1.5,
                                ),
                              ),
                            ],
                          ),
                          NumericKeyboard(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            onKeyboardTap: _onKeyPress,
                            rightButtonFn: () {
                              _onKeyPress('', back: true);
                            },
                            rightIcon: Icon(
                              Icons.backspace,
                              color: Color(0xFF292929),
                            ),
                            leftButtonFn: () {
                              if (amountText.contains('.')) return;
                              _onKeyPress('.');
                            },
                            leftIcon: Icon(
                              Icons.fiber_manual_record,
                              size: 10,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: SlideTransition(
                        position: offset,
                        child: Column(
                          children: [
                            PrimaryButton(
                              opacity: 1,
                              bgColor: hasFund
                                  ? null
                                  : Theme.of(context).colorScheme.secondary,
                              labelColor: hasFund ? null : Color(0xFF797979),
                              label: hasFund
                                  ? I18n.of(context).next_button
                                  : I18n.of(context).insufficient_fund,
                              onPressed: () {
                                args.tokenToSend = selectedToken;
                                args.amount = num.parse(amountText);
                                ExtendedNavigator.root
                                    .pushSendReviewScreen(pageArgs: args);
                              },
                              preload: isPreloading,
                              disabled: isPreloading || !hasFund,
                            ),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
