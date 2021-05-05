import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/features/home/widgets/button.dart';
import 'package:fusecash/features/home/widgets/price_line_chart.dart';
import 'package:fusecash/features/home/widgets/token_activities.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/redux/viewsmodels/token_tile.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/webview.dart';
import 'package:fusecash/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import "package:collection/collection.dart";

class TokenTile extends StatelessWidget {
  TokenTile({
    Key key,
    this.token,
    this.showBalance = true,
    this.showCurrentPrice = false,
    this.onTap,
    this.symbolHeight = 45.0,
    this.symbolWidth = 45.0,
  }) : super(key: key);
  final Function() onTap;
  final bool showBalance;
  final bool showCurrentPrice;
  final double symbolWidth;
  final double symbolHeight;
  final Token token;

  showBottomMenu(
    TokenTileViewModel viewModel,
    BuildContext context,
    bool hasPriceInfo,
  ) {
    final bool isSwappable =
        viewModel?.tokensImages?.containsKey(token.address) ?? false;
    List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
    final bool isFUSD =
        (token.address == fuseDollarToken.address) && depositPlugins.isNotEmpty;
    showBarModalBottomSheet(
      useRootNavigator: true,
      context: ExtendedNavigator.named('homeRouter').context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.975,
        child: SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: (token.imageUrl != null &&
                                    token.imageUrl.isNotEmpty ||
                                (viewModel?.tokensImages?.containsKey(
                                        token?.address?.toLowerCase()) ??
                                    false))
                            ? CachedNetworkImage(
                                width: symbolWidth,
                                height: symbolHeight,
                                imageUrl: (viewModel?.tokensImages?.containsKey(
                                            token?.address?.toLowerCase()) ??
                                        false)
                                    ? viewModel?.tokensImages[
                                        token?.address?.toLowerCase()]
                                    : token?.imageUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    DefaultLogo(
                                  symbol: token?.symbol,
                                  width: symbolWidth,
                                  height: symbolHeight,
                                ),
                              )
                            : DefaultLogo(
                                symbol: token?.symbol,
                                width: symbolWidth,
                                height: symbolHeight,
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        token.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Europa',
                          fontSize: 30,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: hasPriceInfo
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      !hasPriceInfo
                          ? SizedBox.shrink()
                          : Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    I10n.of(context).price,
                                    style: TextStyle(
                                      fontFamily: 'Europa',
                                      fontSize: 13,
                                    ),
                                    softWrap: true,
                                  ),
                                  Text(
                                    '\$${display(num.parse(token.priceInfo.quote))}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Europa',
                                      fontSize: 25,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              I10n.of(context).your_balance,
                              style: TextStyle(
                                fontFamily: 'Europa',
                                fontSize: 13,
                              ),
                              softWrap: true,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              verticalDirection: VerticalDirection.down,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  token.getBalance(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  ' ${token.symbol}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: isSwappable || isFUSD
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      isSwappable
                          ? Button(
                              width: isFUSD
                                  ? MediaQuery.of(context).size.width * .285
                                  : null,
                              text: I10n.of(context).swap,
                              icon: 'swap_action',
                              onPressed: () {
                                viewModel.getSwapList();
                                ExtendedNavigator.root.pushSwapScreen(
                                  primaryToken: token,
                                );
                              },
                            )
                          : SizedBox.shrink(),
                      Button(
                        text: I10n.of(context).send_button,
                        icon: 'send_action',
                        width: isFUSD
                            ? MediaQuery.of(context).size.width * .285
                            : isSwappable
                                ? null
                                : MediaQuery.of(context).size.width * .9,
                        onPressed: () {
                          ExtendedNavigator.root.pushContactsList(
                            automaticallyImplyLeading: true,
                            pageArgs: SendFlowArguments(
                              tokenToSend: token,
                            ),
                          );
                        },
                      ),
                      isFUSD
                          ? Button(
                              text: I10n.of(context).buy,
                              icon: 'buy_fUSD',
                              width: MediaQuery.of(context).size.width * .285,
                              onPressed: () {
                                String url = depositPlugins[0].widgetUrl;
                                openDepositWebview(
                                  withBack: true,
                                  url: url,
                                );
                              },
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                // (token?.stats?.isEmpty ?? [])
                //     ? SizedBox.shrink()
                //     : PriceLineChart(stats: token?.stats),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TokenActivities(
                    tokenAddress: token?.address,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenTileViewModel>(
      distinct: true,
      converter: TokenTileViewModel.fromStore,
      builder: (_, viewModel) {
        final bool hasPriceInfo =
            ![null, '', '0', 0, 'NaN'].contains(token?.priceInfo?.quote);
        final String price = !showCurrentPrice
            ? token?.getFiatBalance()
            : display(num.tryParse(token?.priceInfo?.quote) ?? 0);
        final bool isCommunityToken = viewModel.communities.any(
          (element) =>
              element?.homeTokenAddress?.toLowerCase() != null &&
              element?.homeTokenAddress?.toLowerCase() == token?.address &&
              ![false, null].contains(element?.metadata?.isDefaultImage),
        );
        final Widget leading = Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (token.imageUrl != null && token.imageUrl.isNotEmpty ||
                      (viewModel?.tokensImages
                              ?.containsKey(token?.address?.toLowerCase()) ??
                          false))
                  ? CachedNetworkImage(
                      width: symbolWidth,
                      height: symbolHeight,
                      imageUrl: (viewModel?.tokensImages?.containsKey(
                                  token?.address?.toLowerCase()) ??
                              false)
                          ? viewModel
                              ?.tokensImages[token?.address?.toLowerCase()]
                          : token?.imageUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => DefaultLogo(
                        symbol: token?.symbol,
                        width: symbolWidth,
                        height: symbolHeight,
                      ),
                    )
                  : DefaultLogo(
                      symbol: token?.symbol,
                      width: symbolWidth,
                      height: symbolHeight,
                    ),
            ),
            isCommunityToken
                ? Text(
                    token?.symbol,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  )
                : SizedBox.shrink()
          ],
        );

        final Widget title = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(
              token?.name,
              maxLines: 1,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
              ),
            ),
            showBalance && !showCurrentPrice
                ? Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/images/go_to_pro.svg',
                        width: 10,
                        height: 10,
                      ),
                    ],
                  )
                : SizedBox.shrink()
          ],
        );
        final Widget trailing = showBalance
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Europa',
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          children: <TextSpan>[
                            hasPriceInfo
                                ? TextSpan(
                                    text: '\$' + price,
                                  )
                                : TextSpan(
                                    text: token.getBalance() +
                                        ' ' +
                                        token?.symbol,
                                  ),
                          ],
                        ),
                        presetFontSizes: [15],
                      ),
                      hasPriceInfo && !showCurrentPrice
                          ? Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                token.getBalance() + ' ' + token?.symbol,
                                style: TextStyle(
                                  color: Color(0xFF8D8D8D),
                                  fontSize: 10,
                                ),
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                  // showCurrentPrice
                  //     ? Row(
                  //         children: [
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             token?.getPriceChange(),
                  //             style: TextStyle(
                  //               color: Color(0xFF8D8D8D),
                  //               fontSize: 12,
                  //             ),
                  //           )
                  //         ],
                  //       )
                  //     : SizedBox.shrink()
                ],
              )
            : SizedBox.shrink();

        return ListTile(
          leading: leading,
          onTap: onTap != null
              ? onTap
              : () {
                  viewModel.fetchTokenPrice(token);
                  viewModel.fetchTokenAction(token);
                  showBottomMenu(viewModel, context, hasPriceInfo);
                },
          contentPadding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          title: title,
          trailing: trailing,
          // subtitle: !showBalance
          //     ? Text(
          //         token.symbol,
          //         style: TextStyle(
          //           fontSize: 12,
          //         ),
          //       )
          //     : SizedBox.shrink(),
        );
      },
    );
  }
}
