import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/bottom_sheets/tokens.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/features/shared/widgets/numeric_keyboard.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/text_formatter/formatter.dart';

class SendAmountPage extends StatefulWidget {
  final SendFlowArguments pageArgs;
  const SendAmountPage({required this.pageArgs, Key? key}) : super(key: key);
  @override
  State<SendAmountPage> createState() => _SendAmountPageState();
}

class _SendAmountPageState extends State<SendAmountPage>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  bool? hasEnoughFunds;
  Token? selectedToken;
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  void _onKeyPress(String value, {bool back = false}) {
    if (back) {
      if (textEditingController.text.isEmpty) {
        setState(() {
          hasEnoughFunds = null;
        });
        return;
      }
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
              Decimal.parse(textEditingController.text).compareTo(
                    Formatter.fromWei(
                      selectedToken?.amount ?? BigInt.zero,
                      selectedToken?.decimals ?? 18,
                    ),
                  ) <=
                  0;
      if (hasFund && _amountValidator.isValid(textEditingController.text)) {
        setState(() {
          hasEnoughFunds = true;
        });
      } else {
        setState(() {
          hasEnoughFunds = false;
        });
      }
    } catch (e) {
      setState(() {
        hasEnoughFunds = false;
      });
    }
  }

  Widget useMax() {
    return ButtonTheme(
      child: OutlinedButton(
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                letterSpacing: 0,
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
          String max = Formatter.fromWei(
            selectedToken?.amount ?? BigInt.zero,
            selectedToken?.decimals ?? 18,
          ).toString();
          setState(() {
            textEditingController.text = max;
          });
          textEditingController.selection = TextSelection.fromPosition(
            TextPosition(
              offset: max.length,
            ),
          );
          setState(() {
            hasEnoughFunds = true;
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
            setState(() {
              selectedToken = viewModel.tokens[0];
            });
          }
        }
      },
      builder: (_, viewModel) {
        return InnerScaffold(
          title: title,
          body: Container(
            height: 1,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              I10n.of(context).how_much,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF898989),
                                  ),
                            ),
                            useMax(),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AutoSizeTextField(
                                maxLines: 1,
                                readOnly: true,
                                presetFontSizes: const [
                                  40,
                                  30,
                                  20,
                                  18,
                                  16,
                                ],
                                inputFormatters: [_amountValidator],
                                controller: textEditingController,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Theme.of(context).canvasColor,
                                  hintText: '0',
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            viewModel.tokens.isNotEmpty
                                ? InkWell(
                                    focusColor: Theme.of(context).canvasColor,
                                    highlightColor:
                                        Theme.of(context).canvasColor,
                                    onTap: () {
                                      TokensBottomSheet(
                                        tokens: viewModel.tokens,
                                        showCurrentPrice: false,
                                        onTap: (token) {
                                          textEditingController.clear();
                                          setState(() {
                                            selectedToken = token;
                                          });
                                        },
                                        title: I10n.of(context).token,
                                      ).showSheet(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            selectedToken?.symbol ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/dropdown_icon.svg',
                                            width: 9,
                                            height: 9,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1.5,
                      height: 50,
                    ),
                    NumericKeyboard(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      onKeyboardTap: _onKeyPress,
                      rightButtonFn: () {
                        _onKeyPress('', back: true);
                      },
                      rightIcon: SvgPicture.asset(
                        'assets/images/backspace.svg',
                      ),
                      leftButtonFn: () {
                        if (textEditingController.text.contains('.')) {
                          return;
                        } else {
                          if ([null, ''].contains(textEditingController.text)) {
                            setState(() {
                              textEditingController.text =
                                  '${textEditingController.text}0.';
                            });
                          } else {
                            setState(() {
                              textEditingController.text =
                                  '${textEditingController.text}.';
                            });
                          }
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
                GradientButton(
                  textColor: Theme.of(context).canvasColor,
                  disabled: hasEnoughFunds == null || hasEnoughFunds == false,
                  width: MediaQuery.of(context).size.width,
                  text: hasEnoughFunds == true
                      ? I10n.of(context).next_button
                      : hasEnoughFunds == false
                          ? I10n.of(context).insufficient_fund
                          : I10n.of(context).insert_amount,
                  onPressed: hasEnoughFunds == null || hasEnoughFunds == false
                      ? () {}
                      : () {
                          if (viewModel.tokens.isNotEmpty &&
                              selectedToken != null) {
                            args.tokenToSend = selectedToken;
                            args.amount = textEditingController.text;
                            Analytics.track(
                              eventName: AnalyticsEvents.send3ChooseAmount,
                            );
                            context.router.push(
                              SendReviewRoute(
                                pageArgs: args,
                              ),
                            );
                          }
                        },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
