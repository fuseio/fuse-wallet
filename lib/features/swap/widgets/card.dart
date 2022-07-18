import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:fusecash/features/shared/widgets/token_image.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/trade_card.dart';
import 'package:fusecash/utils/text_formatter/formatter.dart';

class TradeCard extends StatelessWidget {
  final Token? token;
  final String title;
  final bool autofocus;
  final bool showCurrent;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  final void Function() onTap;
  final bool isSwapped;
  final FocusNode? focusNode;
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  TradeCard({
    Key? key,
    this.autofocus = false,
    required this.title,
    this.focusNode,
    required this.isSwapped,
    required this.onTap,
    required this.onChanged,
    this.token,
    required this.textEditingController,
    this.showCurrent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = !isSwapped
        ? Theme.of(context).canvasColor
        : Theme.of(context).colorScheme.secondary;
    final BoxDecoration boxDecoration = !isSwapped
        ? BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            color: color,
            border: Border.all(
              width: 1,
              color: const Color(0xFFE8E8E8),
            ),
          )
        : BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            color: color,
            border: Border.all(
              width: 1,
              color: const Color(0xFFE8E8E8),
            ),
          );
    return StoreConnector<AppState, TradeCardViewModel>(
      distinct: true,
      converter: TradeCardViewModel.fromStore,
      builder: (_, viewModel) {
        return Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 20,
            top: 30,
            bottom: 30,
          ),
          decoration: boxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AutoSizeTextField(
                            maxLines: 1,
                            autofocus: autofocus,
                            inputFormatters: [_amountValidator],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            presetFontSizes: const [
                              28,
                              27,
                              26,
                              25,
                              22,
                              20,
                              15,
                            ],
                            focusNode: focusNode,
                            onChanged: onChanged,
                            controller: textEditingController,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: color,
                              hintText: '0',
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(
                                      .09,
                                    ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -12,
                            left: 10,
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              focusColor: Theme.of(context).canvasColor,
                              highlightColor: Theme.of(context).canvasColor,
                              onTap: onTap,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TokenImage(
                                    width: 40,
                                    height: 40,
                                    imageUrl: token?.imageUrl,
                                    tokenAddress: token?.address ?? '',
                                    tokenSymbol: token?.symbol ?? '',
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    token?.symbol ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const Icon(Icons.expand_more)
                                ],
                              ),
                            ),
                          ],
                        ),
                        showCurrent
                            ? Positioned(
                                bottom: -20,
                                right: 23,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${token?.getBalance() ?? ''} ${I10n.of(context).available}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
