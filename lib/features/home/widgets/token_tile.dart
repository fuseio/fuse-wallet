import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fusecash/features/home/widgets/price_line_chart.dart';
import 'package:fusecash/features/home/widgets/token_activities.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/redux/viewsmodels/token_tile.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    this.onPressed,
    this.text,
    this.icon,
  }) : super(key: key);
  final void Function() onPressed;
  final String text;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .425,
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.0,
            ),
          ),
        ),
        color: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/$icon.svg',
              height: 14,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TokenTile extends StatelessWidget {
  TokenTile({
    Key key,
    this.token,
    this.showPending = true,
    this.showBalance = true,
    this.onTap,
    this.quate,
    this.symbolHeight = 45.0,
    this.symbolWidth = 45.0,
  }) : super(key: key);
  final Function() onTap;
  final double quate;
  final bool showPending;
  final bool showBalance;
  final double symbolWidth;
  final double symbolHeight;
  final Token token;

  showBottomMenu(TokenTileViewModel viewModel, context) {
    final bool hasPriceInfo =
        ![null, '', '0', 0].contains(token.priceInfo.quote);
    final bool isSwappable = viewModel.tokensImages.containsKey(token.address);
    showModalBottomSheet(
      isScrollControlled: true,
      context: ExtendedNavigator.named('homeRouter').context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: (token.imageUrl != null &&
                                          token.imageUrl.isNotEmpty ||
                                      viewModel.tokensImages.containsKey(
                                          token?.address?.toLowerCase()))
                                  ? CachedNetworkImage(
                                      width: 35,
                                      height: 35,
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: hasPriceInfo
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.start,
                          children: [
                            !hasPriceInfo
                                ? SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        I18n.of(context).price,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  I18n.of(context).your_balance,
                                  style: TextStyle(
                                    fontFamily: 'Europa',
                                    fontSize: 13,
                                  ),
                                  softWrap: true,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  verticalDirection: VerticalDirection.down,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    !hasPriceInfo
                                        ? SizedBox.shrink()
                                        : Text(
                                            '\$${display(num.parse(token.priceInfo.total))} ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                    Text(
                                      token.getBalance() + ' ${token.symbol}',
                                      style: TextStyle(
                                        fontSize: hasPriceInfo ? 13 : 25,
                                        fontWeight: hasPriceInfo
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: isSwappable
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.start,
                          children: [
                            isSwappable
                                ? Button(
                                    text: I18n.of(context).swap,
                                    icon: 'swap_action',
                                    onPressed: () {
                                      ExtendedNavigator.root.pushSwapScreen(
                                        primaryToken: token,
                                      );
                                    },
                                  )
                                : SizedBox.shrink(),
                            Button(
                              text: I18n.of(context).send_button,
                              icon: 'send_action',
                              onPressed: () {
                                ExtendedNavigator.root.pushSendAmountScreen(
                                  pageArgs: SendAmountArguments(
                                    tokenToSend: token,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   child: SimpleLineChart.withRandomData(),
                        //   height: 200,
                        // ),
                        TokenActivities(
                          tokenAddress: token.address,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String price = token.priceInfo != null
        ? display(num.parse(token?.priceInfo?.total))
        : '0';
    // final bool isFuseTxs = token.originNetwork != null;
    return StoreConnector<AppState, TokenTileViewModel>(
      distinct: true,
      converter: TokenTileViewModel.fromStore,
      onWillChange: (previousViewModel, newViewModel) {},
      builder: (_, viewModel) {
        final bool isCommunityToken = viewModel.communities.any(
          (element) =>
              element?.homeTokenAddress?.toLowerCase() != null &&
              element?.homeTokenAddress?.toLowerCase() == token?.address &&
              ![false, null].contains(element.metadata.isDefaultImage),
        );
        final Widget leading = Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (token.imageUrl != null && token.imageUrl.isNotEmpty ||
                      viewModel.tokensImages
                          .containsKey(token?.address?.toLowerCase()))
                  ? CachedNetworkImage(
                      width: symbolWidth,
                      height: symbolHeight,
                      imageUrl: viewModel.tokensImages
                              .containsKey(token?.address?.toLowerCase())
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
            // showPending &&
            //         token.transactions.list
            //             .any((transfer) => transfer.isPending())
            //     ? Container(
            //         width: symbolWidth,
            //         height: symbolHeight,
            //         child: CircularProgressIndicator(
            //           backgroundColor: Theme.of(context)
            //               .colorScheme
            //               .onSurface,
            //           strokeWidth: 3,
            //           valueColor: AlwaysStoppedAnimation<Color>(
            //               Theme.of(context)
            //                   .colorScheme
            //                   .onSurface),
            //         ))
            //     : SizedBox.shrink(),
            isCommunityToken
                ? Text(
                    token.symbol,
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
              token.name,
              maxLines: 1,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
              ),
            ),
            showBalance
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
            ? Stack(
                overflow: Overflow.visible,
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Europa',
                      ),
                      children: <TextSpan>[
                        token.priceInfo != null
                            ? TextSpan(
                                text: '\$' + price,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ))
                            : TextSpan(
                                text: token.getBalance() + ' ' + token.symbol,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                      ],
                    ),
                  ),
                  token.priceInfo != null
                      ? Positioned(
                          bottom: -20,
                          child: Padding(
                            child: Text(
                              token.getBalance() + ' ' + token.symbol,
                              style: TextStyle(
                                color: Color(0xFF8D8D8D),
                                fontSize: 10,
                              ),
                            ),
                            padding: EdgeInsets.only(top: 10),
                          ),
                        )
                      : SizedBox.shrink()
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
                  showBottomMenu(viewModel, context);
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
