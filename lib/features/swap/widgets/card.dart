import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/contacts/screens/send_amount.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/trade_card.dart';
import 'package:fusecash/features/shared/widgets/default_logo.dart';

class TradeCard extends StatelessWidget {
  final Token? token;
  final String title;
  final Widget? useMaxWidget;
  final bool autofocus;
  final bool showCurrent;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  final void Function() onTap;
  final bool isSwapped;
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  TradeCard({
    this.autofocus = false,
    required this.title,
    required this.isSwapped,
    required this.onTap,
    required this.onChanged,
    this.token,
    required this.textEditingController,
    this.showCurrent = false,
    this.useMaxWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TradeCardViewModel>(
      distinct: true,
      converter: TradeCardViewModel.fromStore,
      builder: (_, viewModel) {
        return Container(
          height: 150,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          color: isSwapped
              ? Theme.of(context).canvasColor
              : Theme.of(context).colorScheme.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 13),
                  ),
                  useMaxWidget != null ? useMaxWidget! : SizedBox.shrink(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              focusColor: Theme.of(context).canvasColor,
                              highlightColor: Theme.of(context).canvasColor,
                              onTap: onTap,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      width: 35,
                                      height: 35,
                                      imageUrl: viewModel
                                              .tokensImages[token?.address] ??
                                          '',
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          DefaultLogo(
                                        symbol: token?.symbol ?? '',
                                        width: 35,
                                        height: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    token?.symbol ?? '',
                                    style: TextStyle(fontSize: 27),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ],
                        ),
                        showCurrent
                            ? Positioned(
                                bottom: -30,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (token?.getBalance() ?? '') +
                                          ' ' +
                                          I10n.of(context).available,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AutoSizeTextField(
                      maxLines: 1,
                      autofocus: autofocus,
                      inputFormatters: [_amountValidator],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      presetFontSizes: [
                        25,
                        20,
                        15,
                      ],
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.end,
                      onChanged: onChanged,
                      controller: textEditingController,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: isSwapped
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).colorScheme.secondary,
                        hintText: '0',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
