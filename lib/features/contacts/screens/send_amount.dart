import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/numeric_keyboard.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';

class RegExInputFormatter implements TextInputFormatter {
  final RegExp _regExp;

  RegExInputFormatter._(this._regExp);

  factory RegExInputFormatter.withRegex(String regexString) {
    final regex = RegExp(regexString);
    return RegExInputFormatter._(regex);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = isValid(oldValue.text);
    final newValueValid = isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class SendAmountScreen extends StatefulWidget {
  final SendFlowArguments pageArgs;
  SendAmountScreen({required this.pageArgs});
  @override
  _SendAmountScreenState createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  late AnimationController controller;
  late Animation<Offset> offset;
  Token? selectedToken;
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    offset = Tween<Offset>(
      begin: Offset(0.0, 2.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutQuad,
      ),
    );
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
                                  textEditingController.text = "0";
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

  _onKeyPress(String value, {bool back = false}) {
    if (back) {
      if (textEditingController.text.length == 0) return;
      textEditingController.text = textEditingController.text
          .substring(0, textEditingController.text.length - 1);
    } else {
      if (textEditingController.text == '0' && value == '0') {
        textEditingController.text = textEditingController.text;
      } else {
        textEditingController.text = textEditingController.text + value;
      }
    }
    setState(() {});
    try {
      final bool hasFund =
          ![null, '', '0'].contains(textEditingController.text) &&
              (num.parse(textEditingController.text)).compareTo(
                    num.parse(
                      selectedToken?.getBalance(true) ?? '0',
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
      child: OutlinedButton(
        style: TextButton.styleFrom(
          primary: Theme.of(context).colorScheme.onSurface,
          textStyle: TextStyle(
            letterSpacing: 0,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2.0,
          ),
        ),
        child: Text(
          I10n.of(context).use_max,
        ),
        onPressed: () {
          String max = selectedToken?.getBalance(true) ?? '0';
          log.info('max $max');
          setState(() {
            textEditingController.text = max;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SendFlowArguments args = widget.pageArgs;
    String title =
        "${I10n.of(context).send_to} ${args.name ?? Formatter.formatEthAddress(args.accountAddress)}";
    return StoreConnector<AppState, SendAmountViewModel>(
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
            (num.tryParse(textEditingController.text) ?? 0).compareTo(
                      num.parse(
                        (selectedToken?.getBalance(true) ?? '0'),
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
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: AutoSizeTextField(
                                        maxLines: 1,
                                        readOnly: true,
                                        presetFontSizes: [
                                          40,
                                          30,
                                          20,
                                          18,
                                          16,
                                        ],
                                        inputFormatters: [_amountValidator],
                                        controller: textEditingController,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor:
                                              Theme.of(context).canvasColor,
                                          hintText: '0',
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
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
                                                      selectedToken?.symbol ??
                                                          '',
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
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 40,
                              top: 20,
                              bottom: 20,
                              right: 40,
                            ),
                            child: Divider(
                              thickness: 1.5,
                            ),
                          ),
                          NumericKeyboard(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            onKeyboardTap: _onKeyPress,
                            rightButtonFn: () {
                              _onKeyPress('', back: true);
                            },
                            rightIcon: SvgPicture.asset(
                              'assets/images/backspace.svg',
                              // width: 28,
                            ),
                            leftButtonFn: () {
                              if (textEditingController.text.contains('.')) {
                                return;
                              } else {
                                setState(() {
                                  textEditingController.text =
                                      textEditingController.text + '.';
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
                              disabled: !hasFund,
                              label: hasFund
                                  ? I10n.of(context).next_button
                                  : I10n.of(context).insufficient_fund,
                              onPressed: () {
                                args.tokenToSend = selectedToken;
                                args.amount =
                                    double.parse(textEditingController.text);
                                context.router
                                    .push(SendReviewScreen(pageArgs: args));
                              },
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
