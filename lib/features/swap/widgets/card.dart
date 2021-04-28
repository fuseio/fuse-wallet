import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/viewsmodels/token_tile.dart';
import 'package:fusecash/widgets/default_logo.dart';
import 'package:fusecash/models/app_state.dart';

class TradeCard extends StatelessWidget {
  final Token token;
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
    this.onChanged,
    this.token,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenTileViewModel>(
      distinct: true,
      converter: TokenTileViewModel.fromStore,
      builder: (_, viewModel) {
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
                      flex: 1,
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
                                    CachedNetworkImage(
                                      width: 30,
                                      height: 30,
                                      imageUrl: viewModel.tokensImages
                                              .containsKey(
                                                  token?.address?.toLowerCase())
                                          ? viewModel?.tokensImages[
                                              token?.address?.toLowerCase()]
                                          : token?.imageUrl,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          DefaultLogo(
                                        symbol: token?.symbol,
                                        width: 35,
                                        height: 35,
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
                          useMaxWidget != null
                              ? Text(
                                  (token?.getBalance() ?? '0') +
                                      ' ' +
                                      I18n.of(context).available,
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AutoSizeTextField(
                        maxLines: 1,
                        minFontSize: 15,
                        maxFontSize: 25,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        presetFontSizes: [
                          25,
                          20,
                          15,
                        ],
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
              ),
            ],
          ),
        );
      },
    );
  }
}
