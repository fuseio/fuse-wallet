import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/numeric_keyboard.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SendAmountScreen extends StatefulWidget {
  final SendFlowArguments pageArgs;
  SendAmountScreen({required this.pageArgs});
  @override
  _SendAmountScreenState createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "0";
  bool hasBalance = true;
  late AnimationController controller;
  late Animation<Offset> offset;
  bool isPreloading = false;
  late Token selectedToken;

  @override
  void dispose() {
    controller.dispose();
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

  showBottomMenu(SendAmountViewModel viewModel) {
    showBarModalBottomSheet(
      useRootNavigator: true,
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
          shrinkWrap: true,
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
                          I10n.of(context).token,
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
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 20, bottom: 30),
                            separatorBuilder: (_, int index) => Divider(
                              height: 0,
                            ),
                            itemCount: viewModel.tokens.length,
                            itemBuilder: (context, index) => TokenTile(
                              token: viewModel.tokens[index],
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  amountText = "0";
                                  selectedToken = viewModel.tokens[index];
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
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
    } else if (amountText == '.') {
      amountText = amountText + value;
    } else {
      if (amountText == '0' && value == '0') {
        amountText = '0';
      } else {
        String newAmount = amountText + value;
        amountText = Decimal.parse(newAmount).toString();
      }
    }
    setState(() {});
    try {
      final bool hasFund = ![null, '', '0'].contains(amountText) &&
          (Decimal.parse(amountText)).compareTo(
                Decimal.parse(
                  selectedToken.getBalance(true),
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

  Widget useMax() {
    return ButtonTheme(
      minWidth: 68,
      height: 28,
      child: OutlinedButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        // focusColor: Theme.of(context).colorScheme.onSurface,
        // hoverColor: Theme.of(context).colorScheme.onSurface,
        // highlightedBorderColor: Theme.of(context).colorScheme.onSurface,
        // padding: EdgeInsets.all(0),
        // textColor: Theme.of(context).colorScheme.onSurface,
        // borderSide: BorderSide(
        //   color: Theme.of(context).colorScheme.onSurface,
        //   width: 2.0,
        // ),
        child: Text(
          I10n.of(context).use_max,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
        ),
        onPressed: () {
          String max = selectedToken.getBalance(true);
          if (Decimal.parse(max).compareTo(Decimal.parse(amountText)) != 0) {
            _onKeyPress(max, max: true);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SendFlowArguments args = this.widget.pageArgs;
    String title =
        "${I10n.of(context).send_to} ${args.name != null ? args.name : formatAddress(args.accountAddress)}";
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      onInitialBuild: (viewModel) {
        if (args.tokenToSend != null) {
          setState(() {
            selectedToken = args.tokenToSend!;
          });
        } else {
          if (viewModel.tokens.isNotEmpty) {
            if ([null, ''].contains(args.tokenToSend)) {
              setState(() {
                selectedToken = viewModel.tokens[0];
              });
            }
          }
        }
      },
      builder: (_, viewModel) {
        final bool hasFund =
            (Decimal.tryParse(amountText) ?? Decimal.zero).compareTo(
                      Decimal.parse(
                        selectedToken.getBalance(true),
                      ),
                    ) <=
                    0 &&
                viewModel.tokens.isNotEmpty;

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      I10n.of(context).how_much,
                                      style: TextStyle(
                                        color: Color(
                                          0xFF898989,
                                        ),
                                      ),
                                    ),
                                    // useMax(),
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
                                    !args.useBridge &&
                                            viewModel.tokens.isNotEmpty
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
                                                      .colorScheme
                                                      .secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      selectedToken.symbol,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
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
                                padding: EdgeInsets.only(
                                  left: 40,
                                  top: 40,
                                  right: 40,
                                ),
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
                            rightIcon: SvgPicture.asset(
                              'assets/images/backspace.svg',
                              width: 28,
                            ),
                            leftButtonFn: () {
                              if (amountText.contains('.')) {
                                return;
                              } else {
                                String newAmount = amountText + '.';
                                setState(() {
                                  amountText = newAmount;
                                });
                              }
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
                              label: hasFund
                                  ? I10n.of(context).next_button
                                  : I10n.of(context).insufficient_fund,
                              onPressed: () {
                                args.tokenToSend = selectedToken;
                                args.amount = double.parse(amountText);
                                context.router
                                    .push(SendReviewScreen(pageArgs: args));
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
