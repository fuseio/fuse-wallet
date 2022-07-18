import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/home/widgets/price_change.dart';
import 'package:fusecash/features/home/widgets/token_price.dart';
import 'package:fusecash/features/shared/widgets/token_image.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/token_tile.dart';

class TokenTile extends StatefulWidget {
  const TokenTile({
    Key? key,
    required this.token,
    this.showBalance = true,
    this.showCurrentPrice = false,
    this.onTap,
    this.symbolHeight = 45.0,
    this.symbolWidth = 45.0,
  }) : super(key: key);
  final void Function()? onTap;
  final bool showBalance;
  final bool showCurrentPrice;
  final double symbolWidth;
  final double symbolHeight;
  final Token token;

  @override
  State<TokenTile> createState() => _TokenTileState();
}

class _TokenTileState extends State<TokenTile> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenTileViewModel>(
      distinct: true,
      converter: TokenTileViewModel.fromStore,
      builder: (_, viewModel) {
        final Widget leading = TokenImage(
          tokenSymbol: widget.token.symbol,
          tokenAddress: widget.token.address,
          imageUrl: widget.token.imageUrl,
        );
        Stack(
          alignment: Alignment.center,
          children: [
            TokenImage(
              tokenAddress: widget.token.address,
              tokenSymbol: widget.token.symbol,
              imageUrl: widget.token.imageUrl,
              width: widget.symbolWidth,
              height: widget.symbolHeight,
            ),
          ],
        );
        final Widget title = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: AutoSizeText(
                widget.token.name,
                maxLines: 1,
                presetFontSizes: const [15, 13, 12],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        );
        final Widget trailing = widget.showBalance
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.showCurrentPrice
                      ? TokenPrice(
                          address: widget.token.address,
                        )
                      : Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            verticalDirection: VerticalDirection.down,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  widget.token.hasPriceInfo
                                      ? '\$${widget.token.getFiatBalance()}'
                                      : '${widget.token.getBalance()} ${widget.token.symbol}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              widget.token.hasPriceInfo
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: AutoSizeText(
                                        '${widget.token.getBalance()} ${widget.token.symbol}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: lightGray,
                                            ),
                                        maxLines: 1,
                                        presetFontSizes: const [13],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                  widget.showCurrentPrice
                      ? TokenPriceChange(
                          address: widget.token.address,
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : const SizedBox.shrink();

        return ListTile(
          focusColor: Theme.of(context).colorScheme.secondary,
          hoverColor: Theme.of(context).colorScheme.secondary,
          title: title,
          leading: leading,
          trailing: trailing,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          onTap: widget.onTap ??
              () {
                context.router.push(
                  TokenRoute(
                    tokenAddress: widget.token.address,
                  ),
                );
              },
        );
      },
    );
  }
}
