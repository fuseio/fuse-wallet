import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peepl/models/tokens/token.dart';
import 'package:peepl/redux/actions/pro_mode_wallet_actions.dart';
import 'package:peepl/screens/routes.gr.dart';
import 'package:peepl/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:peepl/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final num amount = widget.exchangeSummry['amount'];
    final bool withFee = fees.containsKey(widget.fromToken.symbol);
    final num feeAmount = withFee ? fees[widget.fromToken.symbol] : 0;
    final amountToSwap = formatValue(
        BigInt.from(num.parse(widget.exchangeSummry['sourceAmount'])),
        int.parse(widget.exchangeSummry['sourceAsset']['decimals']),
        withPrecision: true);
    final amountToReceive = formatValue(
        BigInt.from(num.parse(widget.exchangeSummry['destinationAmount'])),
        int.parse(widget.exchangeSummry['destinationAsset']['decimals']),
        withPrecision: true);
    final num tokenBalance = num.parse(formatValue(
        widget.fromToken.amount, widget.fromToken.decimals,
        withPrecision: true));
    final bool hasFund = (amount + feeAmount).compareTo(tokenBalance) <= 0;
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
                              I18n.of(context).pay_with,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AutoSizeText.rich(TextSpan(children: [
                              TextSpan(
                                text: '$amountToSwap ',
                                style: TextStyle(fontSize: 40),
                              ),
                              TextSpan(
                                text: widget.exchangeSummry['sourceAsset']
                                    ['symbol'],
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
                            AutoSizeText.rich(TextSpan(children: [
                              TextSpan(
                                text: '$amountToReceive ',
                                style: TextStyle(fontSize: 40),
                              ),
                              TextSpan(
                                text: widget.exchangeSummry['destinationAsset']
                                    ['symbol'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ]))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                withFee
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              I18n.of(context).fee_amount +
                                  ' $feeAmount ${widget.fromToken.symbol}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF777777))),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              I18n.of(context).total_amount +
                                  ' ${(num.parse(amountToSwap) + feeAmount)} ${widget.fromToken.symbol}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(
                            height: 10,
                          ),
                          !hasFund
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Text(
                                          I18n.of(context).not_enough_balance,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red)),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      )
                    : SizedBox.shrink(),
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
                    disabled: isPreloading || !hasFund,
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
                        ExtendedNavigator.root.replace(Routes.homePage);
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
