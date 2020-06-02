import 'dart:core';
import 'package:redux/redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:fusecash/screens/exchange/review_exchange.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/constans/exchangable_tokens.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/screens/exchange/card.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';

final _tokens = List<Token>.from(exchangableTokens.values);

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key key}) : super(key: key);

  @override
  _ExchangeState createState() => _ExchangeState();
}

class _ExchangeState extends State<ExchangeScreen> {
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
  bool isFetchingPricePay = true;
  bool isFetchingPriceReceive = true;
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
    Segment.screen(screenName: '/trade-screen');
    super.initState();
  }

  onPayWithDropDownChanged(Token token, walletAddress) async {
    fetchPrices(walletAddress, token, tokenToReceive);
    setState(() {
      tokenToPayWith = token;
    });
  }

  onReceiveDropDownChanged(Token token, walletAddress) async {
    fetchPrices(walletAddress, token, tokenToPayWith);
    setState(() {
      tokenToReceive = token;
    });
  }

  void getQuateForPayWith(String value, String walletAddress) async {
    try {
      if (this.mounted) {
        setState(() {
          swapResponse = null;
          isFetchingPayWith = true;
        });
      }
      if (value.isEmpty) {
        if (this.mounted) {
          setState(() {
            swapResponse = null;
            receiveController.text = '';
            isFetchingPayWith = false;
          });
        }
        return;
      }
      dynamic response = await fetchSwap(
          walletAddress, tokenToPayWith.address, tokenToReceive.address,
          sourceAmount: toBigInt(value, tokenToPayWith.decimals).toString(),
          transactions: true);
      swapResponse = response;
      swapResponse['amount'] = num.parse(value);
      String toTokenAmount = formatValue(
          BigInt.from(num.parse(response['destinationAmount'])),
          tokenToReceive.decimals);
      if (this.mounted) {
        setState(() {
          receiveController.text = toTokenAmount;
          isFetchingPayWith = false;
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

  void getQuateForReceive(String value, String walletAddress) async {
    try {
      if (this.mounted) {
        setState(() {
          swapResponse = null;
          isFetchingReceive = true;
        });
      }
      if (value.isEmpty) {
        if (this.mounted) {
          setState(() {
            swapResponse = null;
            payWithController.text = '';
            isFetchingReceive = false;
          });
        }
        return;
      }
      dynamic response = await fetchSwap(
          walletAddress, tokenToReceive.address, tokenToPayWith.address,
          sourceAmount: toBigInt(value, tokenToReceive.decimals).toString(),
          transactions: true);
      swapResponse = response;
      swapResponse['amount'] = num.parse(value);
      String fromTokenAmount = formatValue(
          BigInt.from(num.parse(response['destinationAmount'])),
          tokenToPayWith.decimals);
      if (this.mounted) {
        setState(() {
          payWithController.text = fromTokenAmount;
          isFetchingReceive = false;
        });
      }
    } catch (error) {
      if (this.mounted) {
        setState(() {
          swapResponse = null;
          isFetchingReceive = false;
        });
      }
    }
  }

  List<DropdownMenuItem<Token>> _buildItems(List<Token> tokens) {
    return tokens.map((Token token) {
      return DropdownMenuItem<Token>(
        value: token,
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              width: 33,
              height: 33,
              imageUrl: getTokenUrl(checksumEthereumAddress(token.address)),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 18,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              token.symbol,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }).toList();
  }

  void swap() {
    if (this.mounted) {
      Token tokenPayWith = tokenToPayWith;
      Token tokenReceive = tokenToReceive;
      setState(() {
        tokenToPayWith = tokenReceive;
        tokenToReceive = tokenPayWith;
      });
    }
  }

  fetchPrices(
      String walletAddress, Token tokenToPayWith, Token tokenToReceive) async {
    if (this.mounted) {
      setState(() {
        fromTokenAmountPay = null;
        toTokenAmountPay = null;
        isFetchingPricePay = true;
        fromTokenAmountReceive = null;
        toTokenAmountReceive = null;
        isFetchingPriceReceive = true;
      });
    }
    try {
      Map paywithResponse = await fetchSwap(
          walletAddress, tokenToPayWith.address, tokenToReceive.address,
          sourceAmount:
              toBigInt(num.parse('1'), tokenToPayWith.decimals).toString());
      dynamic receiceResponse = await fetchSwap(
          walletAddress, tokenToReceive.address, tokenToPayWith.address,
          sourceAmount:
              toBigInt(num.parse('1'), tokenToReceive.decimals).toString());
      String fromTokenPay = formatValue(
          BigInt.from(num.parse(paywithResponse['sourceAmount'])),
          tokenToPayWith.decimals);
      String toTokenPay = formatValue(
          BigInt.from(num.parse(paywithResponse['destinationAmount'])),
          tokenToReceive.decimals);
      String fromTokenReceive = formatValue(
          BigInt.from(num.parse(receiceResponse['sourceAmount'])),
          tokenToReceive.decimals);
      String toTokenReceive = formatValue(
          BigInt.from(num.parse(receiceResponse['destinationAmount'])),
          tokenToPayWith.decimals);
      if (this.mounted) {
        setState(() {
          fromTokenAmountPay = fromTokenPay;
          toTokenAmountPay = toTokenPay;
          isFetchingPricePay = false;
          fromTokenAmountReceive = fromTokenReceive;
          toTokenAmountReceive = toTokenReceive;
          isFetchingPriceReceive = false;
        });
      }
    } catch (e) {
      if (this.mounted) {
        setState(() {
          fromTokenAmountPay = null;
          toTokenAmountPay = null;
          isFetchingPricePay = false;
          fromTokenAmountReceive = null;
          toTokenAmountReceive = null;
          isFetchingPriceReceive = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ExchangeViewModel>(
        converter: _ExchangeViewModel.fromStore,
        onInitialBuild: (viewModel) {
          fetchPrices(viewModel.walletAddress, viewModel.tokens[0], _tokens[0]);
          setState(() {
            tokenToPayWith = viewModel.tokens[0];
            tokenToReceive = _tokens[0];
          });
        },
        builder: (_, viewModel) {
          bool payWithHasBalance = payWithController.text != null &&
                  payWithController.text.isNotEmpty
              ? num.tryParse((formatValue(
                              (tokenToPayWith ?? viewModel.tokens[0]).amount,
                              (tokenToPayWith ?? viewModel.tokens[0])
                                  .decimals) ??
                          0))
                      .compareTo((num.tryParse(payWithController.text) ?? 0)) >=
                  0
              : true;
          bool receiveHasBalance = receiveController.text != null &&
                  receiveController.text.isNotEmpty
              ? num.tryParse((formatValue((tokenToReceive ?? _tokens[0]).amount,
                              (tokenToReceive ?? _tokens[0]).decimals) ??
                          0))
                      .compareTo((num.tryParse(receiveController.text) ?? 0)) >=
                  0
              : true;
          return MainScaffold(
            automaticallyImplyLeading: false,
            withPadding: true,
            title: I18n.of(context).exchnage,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                String max = formatValue(tokenToPayWith.amount,
                                    tokenToPayWith.decimals);
                                setState(() {
                                  payWithController.text = max;
                                });
                                _payWithDebouncer.run(() => getQuateForPayWith(
                                    max, viewModel.walletAddress));
                              },
                              child: Text(
                                'Use max',
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        border: Border.all(
                          color: Color(0xFFDBDBDB),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          ExchangeCard(
                            fromTokenAmount: fromTokenAmountPay,
                            toTokenAmount: toTokenAmountPay,
                            isFetchingPrice: isFetchingPricePay,
                            hasBalance: payWithHasBalance,
                            onDropDownChanged: (token) {
                              onPayWithDropDownChanged(
                                  token, viewModel.walletAddress);
                            },
                            items: _buildItems(viewModel.tokens),
                            onChanged: (value) {
                              _payWithDebouncer.run(() => getQuateForPayWith(
                                  value, viewModel.walletAddress));
                            },
                            walletAddress: viewModel.walletAddress,
                            textEditingController: payWithController,
                            isFetching: isFetchingReceive,
                            tokenToReceive: tokenToReceive ?? _tokens[0],
                            token: tokenToPayWith ?? viewModel.tokens[0],
                            title: 'Pay with',
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
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
                          ExchangeCard(
                            fromTokenAmount: fromTokenAmountReceive,
                            toTokenAmount: toTokenAmountReceive,
                            isFetchingPrice: isFetchingPriceReceive,
                            hasBalance: receiveHasBalance,
                            onDropDownChanged: (token) {
                              onReceiveDropDownChanged(
                                  token, viewModel.walletAddress);
                            },
                            items: _buildItems(_tokens),
                            onChanged: (value) {
                              _receiveDebouncer.run(() => getQuateForReceive(
                                  value, viewModel.walletAddress));
                            },
                            walletAddress: viewModel.walletAddress,
                            textEditingController: receiveController,
                            isFetching: isFetchingPayWith,
                            tokenToReceive:
                                tokenToPayWith ?? viewModel.tokens[0],
                            token: tokenToReceive ?? _tokens[0],
                            title: 'Receive',
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
                  if (swapResponse != null && swapResponse['tx'] != null) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => ReviewExchange(
                                  exchangeSummry: swapResponse,
                                )));
                  }
                },
              ),
            ),
          );
        });
  }
}

class _ExchangeViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  _ExchangeViewModel({this.walletAddress, this.tokens});

  static _ExchangeViewModel fromStore(Store<AppState> store) {
    // List<Token> tokens = List<Token>.from(
    //         store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
    //     .where((Token token) =>
    //         num.parse(formatValue(token.amount, token.decimals)) > 0)
    //     .toList()
    //     .reversed
    //     .toList();
    return _ExchangeViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: [daiToken, ...exchangableTokens.values].toSet().toList(),
      // tokens: tokens.isEmpty
      //     ? List.from([daiToken, ...exchangableTokens.values].toSet().toList())
      //     : tokens
      //   ..sort((a, b) => b.amount.compareTo(a.amount)),
    );
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}
