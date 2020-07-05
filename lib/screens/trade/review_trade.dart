import 'dart:core';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';

class ReviewTradeScreen extends StatefulWidget {
  final Token fromToken;
  final Token toToken;
  final Map exchangeSummry;
  const ReviewTradeScreen(
      {Key key, this.exchangeSummry, this.fromToken, this.toToken})
      : super(key: key);

  @override
  _ReviewTradeScreenState createState() => _ReviewTradeScreenState();
}

class _ReviewTradeScreenState extends State<ReviewTradeScreen> {
  bool isPreloading = false;
  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/exchange-screen');
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        withPadding: true,
        title: I18n.of(context).review_trade,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                              'Pay with',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              verticalDirection: VerticalDirection.down,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  formatValue(
                                      BigInt.from(num.parse(widget
                                          .exchangeSummry['sourceAmount'])),
                                      int.parse(
                                          widget.exchangeSummry['sourceAsset']
                                              ['decimals']),
                                      withPrecision: false),
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.exchangeSummry['sourceAsset']
                                      ['symbol'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
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
                              'Receive',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              verticalDirection: VerticalDirection.down,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  formatValue(
                                      BigInt.from(num.parse(
                                          widget.exchangeSummry[
                                              'destinationAmount'])),
                                      int.parse(widget.exchangeSummry[
                                          'destinationAsset']['decimals']),
                                      withPrecision: false),
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.exchangeSummry['destinationAsset']
                                      ['symbol'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
        footer: new StoreConnector<AppState, ReviewTradeScreenViewModel>(
            distinct: true,
            converter: ReviewTradeScreenViewModel.fromStore,
            builder: (_, viewModel) => Center(
                  child: PrimaryButton(
                    labelFontWeight: FontWeight.normal,
                    label: I18n.of(context).trade,
                    fontSize: 15,
                    disabled: isPreloading,
                    preload: isPreloading,
                    onPressed: () {
                      setState(() {
                        isPreloading = true;
                      });
                      viewModel.swap(
                          widget.fromToken,
                          widget.toToken,
                          widget.exchangeSummry['sourceAsset']['address'],
                          widget.exchangeSummry['amount'],
                          widget.exchangeSummry['amountIn'],
                          widget.exchangeSummry['tx']['to'],
                          widget.exchangeSummry['tx']['data'], () {
                        Router.navigator.pushNamedAndRemoveUntil(
                            Router.cashHomeScreen, (route) => false);
                      }, () {
                        setState(() {
                          isPreloading = false;
                        });
                      });
                    },
                  ),
                )));
  }
}

class ReviewTradeScreenViewModel extends Equatable {
  final String walletAddress;
  final Function(
      Token fromToken,
      Token toToken,
      String tokenAddress,
      num tokensAmount,
      num tokensAmountIn,
      String swapContractAddress,
      String swapData,
      VoidCallback sendSuccessCallback,
      VoidCallback sendFailureCallback) swap;

  ReviewTradeScreenViewModel({this.walletAddress, this.swap});

  static ReviewTradeScreenViewModel fromStore(Store<AppState> store) {
    return ReviewTradeScreenViewModel(
        walletAddress: store.state.userState.walletAddress,
        swap: (Token fromToken,
            Token toToken,
            String tokenAddress,
            num tokensAmount,
            num tokensAmountIn,
            String swapContractAddress,
            String swapData,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback) {
          store.dispatch(swapHandler(
              fromToken,
              toToken,
              tokenAddress,
              tokensAmount,
              tokensAmountIn,
              swapContractAddress,
              swapData,
              sendSuccessCallback,
              sendFailureCallback));
        });
  }

  @override
  List<Object> get props => [walletAddress];
}
