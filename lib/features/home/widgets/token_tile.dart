import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:flutter_segment/flutter_segment.dart';
// import 'package:fusecash/features/account/screens/top_up.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/features/home/widgets/button.dart';
import 'package:fusecash/features/home/widgets/price.dart';
import 'package:fusecash/features/home/widgets/price_change.dart';
// import 'package:fusecash/features/home/widgets/price_diff.dart';
// import 'package:fusecash/features/home/widgets/price_line_chart.dart';
import 'package:fusecash/features/home/widgets/token_activities.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/redux/viewsmodels/token_tile.dart';
// import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/features/shared/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TokenTile extends StatefulWidget {
  TokenTile({
    Key? key,
    required this.token,
    this.showBalance = true,
    this.showCurrentPrice = false,
    this.onTap,
    this.symbolHeight = 50.0,
    this.symbolWidth = 50.0,
  }) : super(key: key);
  final void Function()? onTap;
  final bool showBalance;
  final bool showCurrentPrice;
  final double symbolWidth;
  final double symbolHeight;
  final Token token;

  @override
  _TokenTileState createState() => _TokenTileState();
}

class _TokenTileState extends State<TokenTile> {
  showBottomMenu(
    TokenTileViewModel viewModel,
    BuildContext context,
    bool hasPriceInfo,
  ) {
    // final bool isSwappable =
    //     viewModel.tokensImages.containsKey(widget.token.address);
    // List depositPlugins = viewModel.plugins.getDepositPlugins();
    // final bool isFUSD = (widget.token.address == fuseDollarToken.address) &&
    //     depositPlugins.isNotEmpty;
    showBarModalBottomSheet(
      context: context,
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
                        child: (widget.token.imageUrl != null &&
                                    widget.token.imageUrl!.isNotEmpty ||
                                viewModel.tokensImages.containsKey(
                                    widget.token.address.toLowerCase())
                            ? CachedNetworkImage(
                                width: widget.symbolWidth,
                                height: widget.symbolHeight,
                                imageUrl: (viewModel.tokensImages[
                                        widget.token.address.toLowerCase()] ??
                                    widget.token.imageUrl)!,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    DefaultLogo(
                                  symbol: widget.token.symbol,
                                  width: widget.symbolWidth,
                                  height: widget.symbolHeight,
                                ),
                              )
                            : DefaultLogo(
                                symbol: widget.token.symbol,
                                width: widget.symbolWidth,
                                height: widget.symbolHeight,
                              )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          widget.token.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          maxLines: 1,
                          presetFontSizes: [30, 28, 26],
                        ),
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
                                    '\$${display(num.parse(widget.token.priceInfo?.quote ?? '0'))}',
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    widget.token.getBalance(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    presetFontSizes: [25, 24, 23, 22],
                                    maxLines: 1,
                                  ),
                                ),
                                Text(
                                  ' ${widget.token.symbol}',
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisAlignment: isSwappable || isFUSD
                    //     ? MainAxisAlignment.spaceBetween
                    //     : MainAxisAlignment.start,
                    children: [
                      // isSwappable
                      //     ? Button(
                      //         width: isFUSD
                      //             ? MediaQuery.of(context).size.width * .285
                      //             : null,
                      //         text: I10n.of(context).swap,
                      //         icon: 'swap_action',
                      //         onPressed: () {
                      //           viewModel.getSwapListBalances();
                      //           context.router.pop();
                      //           context.navigateTo(
                      //             SwapTab(
                      //               children: [
                      //                 SwapScreen(
                      //                   primaryToken: widget.token,
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //       )
                      //     : SizedBox.shrink(),
                      Button(
                        text: I10n.of(context).send_button,
                        icon: 'send_action',
                        width: MediaQuery.of(context).size.width * .9,
                        onPressed: () {
                          context.router.pop();
                          context.navigateTo(
                            ContactsTab(
                              children: [
                                ContactsList(
                                  pageArgs: SendFlowArguments(
                                    tokenToSend: widget.token,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // isFUSD
                      //     ? Button(
                      //         text: I10n.of(context).buy,
                      //         icon: 'buy_fUSD',
                      //         width: MediaQuery.of(context).size.width * .285,
                      //         onPressed: () {
                      //           Navigator.of(context).pop();
                      //           Segment.track(
                      //             eventName: 'Top up Button Press',
                      //             properties: Map.from(
                      //                 {"fromScreen": 'fuseDollarScreen'}),
                      //           );
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => TopUpScreen(),
                      //             ),
                      //           );
                      //         },
                      //       )
                      //     : SizedBox.shrink(),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 40,
                // ),
                // Container(
                //   padding: EdgeInsets.only(
                //     top: 30,
                //     bottom: 30,
                //   ),
                //   color: Theme.of(context).colorScheme.secondary,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       PriceDiff(
                //         tokenAddress: widget.token.address,
                //       ),
                //       PriceLineChart(
                //         tokenAddress: widget.token.address,
                //         // stats: widget.token.stats,
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TokenActivities(
                    tokenAddress: widget.token.address,
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
            ![null, '', '0', 0, 'NaN'].contains(widget.token.priceInfo?.quote);
        final bool isCommunityToken = viewModel.communities.any(
          (element) =>
              ![null, ''].contains(element.homeTokenAddress) &&
              element.homeTokenAddress!.toLowerCase() == widget.token.address &&
              ![false, null].contains(element.metadata?.isDefaultImage),
        );
        final Widget leading = Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (widget.token.imageUrl != null &&
                          widget.token.imageUrl!.isNotEmpty ||
                      viewModel.tokensImages
                          .containsKey(widget.token.address.toLowerCase())
                  ? CachedNetworkImage(
                      width: widget.symbolWidth,
                      height: widget.symbolHeight,
                      imageUrl: (viewModel.tokensImages[
                              widget.token.address.toLowerCase()] ??
                          widget.token.imageUrl)!,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => DefaultLogo(
                        symbol: widget.token.symbol,
                        width: widget.symbolWidth,
                        height: widget.symbolHeight,
                      ),
                    )
                  : DefaultLogo(
                      symbol: widget.token.symbol,
                      width: widget.symbolWidth,
                      height: widget.symbolHeight,
                    )),
            ),
            isCommunityToken
                ? Text(
                    widget.token.symbol,
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
            Flexible(
              child: AutoSizeText(
                widget.token.name,
                maxLines: 1,
                presetFontSizes: [15, 13, 12],
              ),
            ),
            widget.showBalance && !widget.showCurrentPrice
                ? Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                    ],
                  )
                : SizedBox.shrink()
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
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Europa',
                                      color: Color(0xFF292929),
                                    ),
                                    children: <TextSpan>[
                                      hasPriceInfo
                                          ? TextSpan(
                                              text: '\$' +
                                                  widget.token.getFiatBalance(),
                                            )
                                          : TextSpan(
                                              text: widget.token.getBalance() +
                                                  ' ' +
                                                  widget.token.symbol,
                                            ),
                                    ],
                                  ),
                                  presetFontSizes: [15],
                                ),
                              ),
                              hasPriceInfo
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: AutoSizeText(
                                        widget.token.getBalance() +
                                            ' ' +
                                            widget.token.symbol,
                                        style: TextStyle(
                                          color: Color(0xFF292929),
                                        ),
                                        maxLines: 1,
                                        presetFontSizes: [10],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                  widget.showCurrentPrice
                      ? TokenPriceChange(
                          address: widget.token.address,
                        )
                      : SizedBox.shrink(),
                ],
              )
            : SizedBox.shrink();

        return ListTile(
          focusColor: Theme.of(context).colorScheme.secondary,
          hoverColor: Theme.of(context).colorScheme.secondary,
          title: title,
          leading: leading,
          trailing: trailing,
          contentPadding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          onTap: widget.onTap != null
              ? widget.onTap
              : () {
                  viewModel.fetchTokenPrice(widget.token);
                  viewModel.fetchTokenAction(widget.token);
                  showBottomMenu(viewModel, context, hasPriceInfo);
                },
        );
      },
    );
  }
}
