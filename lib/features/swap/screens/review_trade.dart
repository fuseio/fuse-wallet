import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/redux/viewsmodels/review_trade.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReviewSwapScreen extends StatefulWidget {
  final TradeInfo tradeInfo;
  final SwapRequestBody swapRequestBody;

  const ReviewSwapScreen({
    this.tradeInfo,
    this.swapRequestBody,
  });

  @override
  _ReviewTradeScreenState createState() => _ReviewTradeScreenState();
}

class _ReviewTradeScreenState extends State<ReviewSwapScreen> {
  bool isPreloading = false;
  @override
  void initState() {
    super.initState();
  }

  _onPress(ReviewSwapViewModel viewModel) async {
    setState(() {
      isPreloading = true;
    });
    SwapCallParameters swapCallParameters =
        await swapService.swapCallParameters(
      widget.swapRequestBody.currencyIn,
      widget.swapRequestBody.currencyOut,
      widget.swapRequestBody.amountIn,
      widget.swapRequestBody.recipient,
    );
    viewModel.swap(
      widget.swapRequestBody,
      swapCallParameters,
      () {
        ExtendedNavigator.named('swapRouter').popUntilRoot();
        BottomNavigationBar navigationBar = AppKeys.bottomBarKey.currentWidget;
        navigationBar.onTap(0);
        ExtendedNavigator.root.popUntilPath(Routes.homeScreen);
      },
      () {
        setState(() {
          isPreloading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I18n.of(context).review_trade,
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFDEDEDE),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20),
                              constraints: BoxConstraints(
                                  minHeight: 165,
                                  minWidth: MediaQuery.of(context).size.width,
                                  maxWidth: MediaQuery.of(context).size.width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    I18n.of(context).pay_with,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText.rich(TextSpan(children: [
                                    TextSpan(
                                      text: '${widget.tradeInfo.inputAmount} ',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                    TextSpan(
                                      text: widget.tradeInfo.inputToken,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]))
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/stroke.svg',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              constraints: BoxConstraints(
                                  minHeight: 165,
                                  minWidth: MediaQuery.of(context).size.width,
                                  maxWidth: MediaQuery.of(context).size.width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    I18n.of(context).receive,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${widget.tradeInfo.outputAmount} ',
                                          style: TextStyle(fontSize: 40),
                                        ),
                                        TextSpan(
                                          text: widget.tradeInfo.outputToken,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                StoreConnector<AppState, ReviewSwapViewModel>(
                  distinct: true,
                  converter: ReviewSwapViewModel.fromStore,
                  builder: (_, viewModel) => Center(
                    child: PrimaryButton(
                      labelFontWeight: FontWeight.normal,
                      label: I18n.of(context).trade,
                      disabled: isPreloading,
                      preload: isPreloading,
                      onPressed: () => _onPress(viewModel),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
