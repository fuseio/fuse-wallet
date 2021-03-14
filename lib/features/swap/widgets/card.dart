import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:flutter/material.dart';

class TradeCard extends StatelessWidget {
  final Token token;
  final bool hasBalance;
  final String title;
  final Widget useMaxWidget;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  final void Function() onTap;
  final bool isSwapped;

  TradeCard({
    this.title,
    this.isSwapped,
    this.onTap,
    this.useMaxWidget,
    this.hasBalance = true,
    this.onChanged,
    this.token,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              useMaxWidget != null ? useMaxWidget : SizedBox.shrink(),
            ],
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            focusColor: Theme.of(context).canvasColor,
                            highlightColor: Theme.of(context).canvasColor,
                            onTap: onTap,
                            child: Row(
                              children: [
                                Text(
                                  token?.symbol ?? '',
                                  style: TextStyle(fontSize: 27),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          )
                        ],
                      ),
                      useMaxWidget != null
                          ? Text(
                              token.getBalance() +
                                  ' ' +
                                  I18n.of(context).available,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    child: TextFormField(
                      autofocus: false,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.end,
                      onChanged: onChanged,
                      controller: textEditingController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: isSwapped
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).colorScheme.secondary,
                        hintText: '0',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
