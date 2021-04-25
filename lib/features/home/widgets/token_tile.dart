import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    this.onPressed,
    this.text,
    this.icon,
    this.width,
  }) : super(key: key);
  final void Function() onPressed;
  final String text;
  final String icon;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * .425,
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
            AutoSizeText(
              text,
              style: TextStyle(
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
            padding: EdgeInsets.all(20),
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
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: (token.imageUrl != null &&
                                  token.imageUrl.isNotEmpty ||
                              viewModel.tokensImages
                                  .containsKey(token?.address?.toLowerCase()))
                          ? CachedNetworkImage(
                              width: 35,
                              height: 35,
                              imageUrl: viewModel.tokensImages.containsKey(
                                      token?.address?.toLowerCase())
                                  ? viewModel?.tokensImages[
                                      token?.address?.toLowerCase()]
                                  : token?.imageUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => DefaultLogo(
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
                        : Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          ),
                    Flexible(
                      child: Column(
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
                      width: isSwappable
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
      onWillChange: (previousViewModel, newViewModel) {},
      builder: (_, viewModel) {
        final bool hasPriceInfo =
            ![null, '', '0', 0].contains(token?.priceInfo?.quote);
        final String price = !showCurrentPrice
            ? token?.getFiatBalance()
            : display(num.tryParse(token?.priceInfo?.quote) ?? 0);
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
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Europa',
                      ),
                      children: <TextSpan>[
                        hasPriceInfo
                            ? TextSpan(
                                text: '\$' + price,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              )
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
                  hasPriceInfo && !showCurrentPrice
                      ? Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            token.getBalance() + ' ' + token.symbol,
                            style: TextStyle(
                              color: Color(0xFF8D8D8D),
                              fontSize: 10,
                            ),
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
