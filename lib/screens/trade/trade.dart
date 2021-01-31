import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/constans/swappable_tokens.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/trade/trade_router.gr.dart';
import 'package:fusecash/screens/home/widgets/token_tile.dart';
import 'package:fusecash/services.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/constans/exchangable_tokens.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/trade/card.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TradeScreen extends StatefulWidget {
  final Token primaryToken;
  const TradeScreen({Key key, this.primaryToken}) : super(key: key);

  @override
  _TradeState createState() => _TradeState();
}

class _TradeState extends State<TradeScreen> {
  TextEditingController receiveController = TextEditingController();
  TextEditingController payWithController = TextEditingController();
  Token tokenToPayWith;
  Token tokenToReceive;
  final _payWithDebouncer = Debouncer(milliseconds: 1000);
  final _receiveDebouncer = Debouncer(milliseconds: 1000);
  bool isFetchingPayWith = false;
  Map swapResponse;
  Map transactionsResponse;
  bool isFetchingReceive = false;
  bool isSwap = false;
  bool isFetchingPrice = false;
  String fromTokenAmountPay;
  String fromTokenAmountReceive;
  String toTokenAmountPay;
  String toTokenAmountReceive;

  @override
  void dispose() {
    payWithController.dispose();
    receiveController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void onPayWithDropDownChanged(Token token, walletAddress) {
    setState(() {
      tokenToPayWith = token;
    });
    fetchPrices(walletAddress, token, tokenToReceive);
  }

  void onReceiveDropDownChanged(Token token, walletAddress) {
    setState(() {
      tokenToReceive = token;
    });
    fetchPrices(walletAddress, token, tokenToPayWith);
  }

  void fetchSwapParameters(String amount, walletAddress) async {
    try {
      if (this.mounted) {
        setState(() {
          swapResponse = null;
          isFetchingPayWith = true;
        });
      }
      if (amount.isEmpty) {
        if (this.mounted) {
          setState(() {
            swapResponse = null;
            receiveController.text = '';
            isFetchingPayWith = false;
          });
        }
        return;
      }

      dynamic response = await swapService.swapCallParameters(
        tokenToPayWith.address, 
        tokenToReceive.address, 
        amount, 
        walletAddress);
      
      if (this.mounted) {
        setState(() {
          receiveController.text = '0.0';
          isFetchingPayWith = false;
          swapResponse = response;
        });
      }
    } catch (error) {
      if (this.mounted) {
        setState(() {
          swapResponse = null;
          isFetchingPayWith = false;
        });
      }
    }
  }

  showBottomMenu(List<Token> tokens, onTap) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        builder: (BuildContext context) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Theme.of(context).splashColor),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            color: Color(0xFFE8E8E8),
                            height: 0,
                          ),
                          itemCount: tokens?.length ?? 0,
                          itemBuilder: (context, index) => TokenTile(
                              token: tokens[index],
                              symbolWidth: 60,
                              symbolHeight: 60,
                              showPending: false,
                              onTap: () {
                                Navigator.of(context).pop();
                                onTap(tokens[index]);
                              }),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            )));
  }

  void swap() {
    if (this.mounted) {
      Token tokenPayWith = tokenToPayWith;
      Token tokenReceive = tokenToReceive;
      setState(() {
        isSwap = !isSwap;
        tokenToPayWith = tokenReceive;
        tokenToReceive = tokenPayWith;
      });
    }
  }

  void fetchPrices(String walletAddress, Token sourceToken, Token destinationToken) async {
    // TODO: fetch prices using SwapService
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _TradeViewModel>(
        converter: _TradeViewModel.fromStore,
        onInitialBuild: (viewModel) {
          final Token wethToken = viewModel.tokens['WETH'];
          final Token daiToken = viewModel.tokens['DAI'];              
          final Token payWithToken = widget.primaryToken ?? daiToken;
          fetchPrices(viewModel.walletAddress, payWithToken, wethToken);
          setState(() {
            tokenToPayWith = payWithToken;
            tokenToReceive = wethToken;
          });
        },
        builder: (_, viewModel) {
          final Token payWithToken =
              tokenToPayWith ?? widget.primaryToken ?? viewModel.tokens['DAI'];
          final Token receiveToken = tokenToReceive ?? viewModel.tokens['WETH'];
          num value = num.parse(formatValue(
              payWithToken.amount, payWithToken.decimals,
              withPrecision: true));
          bool payWithHasBalance = payWithController.text != null &&
                  payWithController.text.isNotEmpty
              ? value.compareTo(num.parse(payWithController.text ?? 0) ?? 0) !=
                  -1
              : true;
          // num receiveValue = num.parse(
          //     formatValue(receiveToken.amount, receiveToken.decimals, withPrecision: false));
          // bool receiveHasBalance = receiveController.text != null &&
          //         receiveController.text.isNotEmpty
          //     ? receiveValue.compareTo(
          //             num.tryParse(receiveController.text ?? 0) ?? 0) >=
          //         0
          //     : true;
          return MainScaffold(
            expandedHeight: MediaQuery.of(context).size.height / 12,
            withPadding: true,
            padding: 20.0,
            title: I18n.of(context).trade,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          TradeCard(
                            onTap: () {
                              showBottomMenu([... viewModel.tokens.values], (token) {
                                onPayWithDropDownChanged(token, viewModel.walletAddress);
                              });
                            },
                            useMaxWidget: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    String max = formatValue(
                                        tokenToPayWith.amount,
                                        tokenToPayWith.decimals,
                                        withPrecision: true);
                                    setState(() {
                                      payWithController.text = max;
                                    });
                                    _payWithDebouncer.run(() => {
                                    });
                                  },
                                  child: Text(
                                    I18n.of(context).use_max,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                            fromTokenAmount: !isSwap
                                ? fromTokenAmountPay
                                : fromTokenAmountReceive,
                            toTokenAmount: !isSwap
                                ? toTokenAmountPay
                                : toTokenAmountReceive,
                            isFetchingPrice: isFetchingPrice,
                            hasBalance: payWithHasBalance,
                            // hasBalance: value == 0
                            //     ? false
                            //     : (isSwap
                            //         ? payWithHasBalance
                            //         : receiveHasBalance),
                            // onDropDownChanged: (token) {
                            //   onPayWithDropDownChanged(
                            //       token, viewModel.walletAddress);
                            // },
                            onChanged: (value) {
                              _payWithDebouncer.run(() => {
                                fetchSwapParameters(value, viewModel.walletAddress)
                              });
                            },
                            walletAddress: viewModel.walletAddress,
                            textEditingController: payWithController,
                            isFetching: isFetchingReceive,
                            tokenToReceive: receiveToken,
                            token: payWithToken,
                            title: I18n.of(context).pay_with,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 0, bottom: 0),
                                child: SizedBox(
                                  child: Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFDBDBDB),
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: swap,
                                  child: SvgPicture.asset(
                                    'assets/images/swap_icon.svg',
                                    fit: BoxFit.fill,
                                    width: 40,
                                    height: 40,
                                  ))
                            ],
                          ),
                          TradeCard(
                            onTap: () {
                              showBottomMenu([... viewModel.tokens.values], (token) {
                                onReceiveDropDownChanged(
                                    token, viewModel.walletAddress);
                              });
                            },
                            fromTokenAmount: !isSwap
                                ? fromTokenAmountReceive
                                : fromTokenAmountPay,
                            toTokenAmount: !isSwap
                                ? toTokenAmountReceive
                                : toTokenAmountPay,
                            isFetchingPrice: isFetchingPrice,
                            // hasBalance: receiveValue == 0
                            //     ? false
                            //     : (isSwap
                            //         ? receiveHasBalance
                            //         : payWithHasBalance),
                            onChanged: (value) {
                              _receiveDebouncer.run(() => {
                                
                              });
                            },
                            walletAddress: viewModel.walletAddress,
                            textEditingController: receiveController,
                            isFetching: isFetchingPayWith,
                            tokenToReceive: payWithToken,
                            token: receiveToken,
                            title: I18n.of(context).receive,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
            footer: Center(
              child: PrimaryButton(
                labelFontWeight: FontWeight.normal,
                label: I18n.of(context).trade,
                fontSize: 15,
                disabled: swapResponse == null, 
                onPressed: () async {
                  if (swapResponse != null && swapResponse['rawTxn'] != null) {
                    ExtendedNavigator.named('tradeRouter').pushReviewTradeScreen(
                      swapObject: swapResponse,
                      fromToken: tokenToPayWith,
                      toToken: tokenToReceive,
                      amountIn: payWithController.text,
                      amountOut: '0.0',
                    );
                  }
                },
              ),
            ),
          );
        });
  }
}

class _TradeViewModel extends Equatable {
  final String walletAddress;
  final Map<String, Token> tokens;

  _TradeViewModel({
    this.walletAddress,
    this.tokens,
  });

  static _TradeViewModel fromStore(Store<AppState> store) {
    return _TradeViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: swappableTokens,
    );
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}