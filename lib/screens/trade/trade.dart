import 'dart:core';
import 'package:digitalrand/models/community.dart';
import 'package:digitalrand/models/plugins/bridge_to_foreign_fee.dart';
import 'package:digitalrand/models/plugins/fee_base.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:digitalrand/widgets/activate_pro_mode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:digitalrand/redux/state/store.dart';
import 'package:digitalrand/services.dart';
import 'package:redux/redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:digitalrand/screens/trade/review_trade.dart';
import 'package:digitalrand/screens/pro_mode/assets_list.dart';
import 'package:digitalrand/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digitalrand/constans/exchangable_tokens.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/pro/token.dart';
import 'package:digitalrand/screens/trade/card.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:digitalrand/widgets/main_scaffold.dart';
import 'package:digitalrand/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({Key key}) : super(key: key);

  @override
  _ExchangeState createState() => _ExchangeState();
}

class _ExchangeState extends State<TradeScreen> {
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
          transactions: true,
          skipBalanceChecks: false);
      swapResponse = response;
      swapResponse['amount'] = num.parse(value);
      swapResponse['amountIn'] = num.parse(formatValue(
          BigInt.from(num.parse(response['destinationAmount'])),
          tokenToReceive.decimals,
          withPrecision: false));
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
          transactions: true,
          skipBalanceChecks: false);
      swapResponse = response;
      swapResponse['amount'] = num.parse(value);
      swapResponse['amountIn'] = num.parse(formatValue(
          BigInt.from(num.parse(response['destinationAmount'])),
          tokenToReceive.decimals,
          withPrecision: false));
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
              imageUrl: token.imageUrl != null && token.imageUrl.isNotEmpty
                  ? token.imageUrl
                  : getTokenUrl(checksumEthereumAddress(token.address)),
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
            // RichText(
            //     text: new TextSpan(
            //         style: TextStyle(
            //             color: Theme.of(context).primaryColor, fontSize: 16),
            //         children: <InlineSpan>[
            //       TextSpan(
            //         text: '${token.symbol} ',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //       // token.subtitle != null && token.subtitle.isNotEmpty
            //       exchangableTokens[checksumEthereumAddress(token.address)] != null &&
            //               exchangableTokens[checksumEthereumAddress(token.address)].subtitle != null
            //           ? TextSpan(
            //               text: '(${exchangableTokens[checksumEthereumAddress(token.address)].subtitle})',
            //               style: TextStyle(
            //                   fontSize: 14,
            //                   color: Color(0xFF888888)))
            //           : TextSpan(
            //               text: '',
            //               style: TextStyle(
            //                   fontSize: 14,
            //                   color: Color(0xFF888888)))
            //     ]))
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
        isSwap = !isSwap;
        tokenToPayWith = tokenReceive;
        tokenToReceive = tokenPayWith;
      });
    }
  }

  void fetchPrices(
      String walletAddress, Token soureToken, Token destinationToken) async {
    try {
      if (this.mounted) {
        setState(() {
          swapResponse = null;
          payWithController.text = '';
          receiveController.text = '';
          fromTokenAmountPay = null;
          toTokenAmountPay = null;
          isFetchingPricePay = true;
          fromTokenAmountReceive = null;
          toTokenAmountReceive = null;
          isFetchingPriceReceive = true;
        });
      }
      Map paywithResponse = await fetchSwap(
          walletAddress, soureToken.address, destinationToken.address,
          sourceAmount:
              toBigInt(num.parse('1'), soureToken.decimals).toString());
      Map receiceResponse = await fetchSwap(
          walletAddress, destinationToken.address, soureToken.address,
          sourceAmount:
              toBigInt(num.parse('1'), destinationToken.decimals).toString());
      String fromTokenPay = formatValue(
          BigInt.from(num.parse(paywithResponse['sourceAmount'])),
          soureToken.decimals);
      String toTokenPay = formatValue(
          BigInt.from(num.parse(paywithResponse['destinationAmount'])),
          destinationToken.decimals);
      String fromTokenReceive = formatValue(
          BigInt.from(num.parse(receiceResponse['sourceAmount'])),
          destinationToken.decimals);
      String toTokenReceive = formatValue(
          BigInt.from(num.parse(receiceResponse['destinationAmount'])),
          soureToken.decimals);
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
          swapResponse = null;
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
          final Token ethToken =
              viewModel.tokens.firstWhere((element) => element.symbol == 'ETH');
          final Token dzarToken = viewModel.tokens
              .firstWhere((element) => element.symbol == 'DZAR');
          final Token daiToken =
              viewModel.tokens.firstWhere((element) => element.symbol == 'DAI');
          final Token payWithToken =
              ethToken == viewModel.tokens[0] ? dzarToken : viewModel.tokens[0];
          fetchPrices(viewModel.walletAddress, payWithToken, daiToken);
          setState(() {
            tokenToPayWith = payWithToken;
            tokenToReceive = daiToken;
          });
        },
        builder: (_, viewModel) {
          final Token ethToken =
              viewModel.tokens.firstWhere((element) => element.symbol == 'ETH');
          final Token dzarToken = viewModel.tokens
              .firstWhere((element) => element.symbol == 'DZAR');
          final Token daiToken =
              viewModel.tokens.firstWhere((element) => element.symbol == 'DAI');
          final Token payWithToken = tokenToPayWith ??
              (ethToken == viewModel.tokens[0]
                  ? dzarToken
                  : viewModel.tokens[0]);
          final Token receiveToken = tokenToReceive ?? daiToken;
          num value = num.parse(formatValue(
              payWithToken.amount, payWithToken.decimals,
              withPrecision: false));
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
            automaticallyImplyLeading: false,
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
                                        withPrecision: false);
                                    setState(() {
                                      payWithController.text = max;
                                    });
                                    _payWithDebouncer.run(() =>
                                        getQuateForPayWith(
                                            max, viewModel.walletAddress));
                                  },
                                  child: Text(
                                    'Use max',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                            fromTokenAmount: isSwap
                                ? fromTokenAmountPay
                                : fromTokenAmountReceive,
                            toTokenAmount: isSwap
                                ? toTokenAmountPay
                                : toTokenAmountReceive,
                            isFetchingPrice: isFetchingPricePay,
                            hasBalance: payWithHasBalance,
                            // hasBalance: value == 0
                            //     ? false
                            //     : (isSwap
                            //         ? payWithHasBalance
                            //         : receiveHasBalance),
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
                            tokenToReceive: receiveToken,
                            token: payWithToken,
                            title: 'Pay with',
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
                            fromTokenAmount: isSwap
                                ? fromTokenAmountReceive
                                : fromTokenAmountPay,
                            toTokenAmount: isSwap
                                ? toTokenAmountReceive
                                : toTokenAmountPay,
                            isFetchingPrice: isFetchingPriceReceive,
                            // hasBalance: receiveValue == 0
                            //     ? false
                            //     : (isSwap
                            //         ? receiveHasBalance
                            //         : payWithHasBalance),
                            onDropDownChanged: (token) {
                              onReceiveDropDownChanged(
                                  token, viewModel.walletAddress);
                            },
                            items: _buildItems(viewModel.tokens),
                            onChanged: (value) {
                              _receiveDebouncer.run(() => getQuateForReceive(
                                  value, viewModel.walletAddress));
                            },
                            walletAddress: viewModel.walletAddress,
                            textEditingController: receiveController,
                            isFetching: isFetchingPayWith,
                            tokenToReceive: payWithToken,
                            token: receiveToken,
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
                  if (!viewModel.isProMode && !viewModel.isProModeActivated) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ActivateProModeDialog();
                        });
                    return;
                  } else if (!viewModel.isProMode &&
                      viewModel.isProModeActivated) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => SendAmountScreen(
                                pageArgs: SendAmountArguments(
                                    avatar: AssetImage(
                                      'assets/images/ethereume_icon.png',
                                    ),
                                    name: 'ethereum',
                                    feePlugin: viewModel.feePlugin,
                                    sendType: SendType.ETHEREUM_ADDRESS,
                                    accountAddress:
                                        viewModel.homeBridgeAddress))));
                    Segment.track(
                        eventName:
                            'Wallet: Choose amount to transfer - activate pro mode');
                    return;
                  } else {
                    if (swapResponse != null && swapResponse['tx'] != null) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ReviewTradeScreen(
                                    fromToken: tokenToPayWith.copyWith(),
                                    toToken: tokenToReceive.copyWith(),
                                    exchangeSummry: swapResponse,
                                  )));
                    }
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
  final bool isProMode;
  final bool isProModeActivated;
  final Function(bool isProMode) replaceNavigator;
  final FeePlugin feePlugin;
  final String homeBridgeAddress;

  _ExchangeViewModel({
    this.walletAddress,
    this.feePlugin,
    this.tokens,
    this.isProMode,
    this.isProModeActivated,
    this.replaceNavigator,
    this.homeBridgeAddress,
  });

  static _ExchangeViewModel fromStore(Store<AppState> store) {
    final List<Token> tokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: false))
                .compareTo(0) ==
            1)
        .toList()
        .reversed
        .toList();
    final List<Token> exchangable = exchangableTokens.values.toList()
      ..removeWhere((Token token) {
        dynamic foundToken = tokens.firstWhere(
            (element) =>
                element.address.toLowerCase() == token.address.toLowerCase(),
            orElse: () => null);
        if (foundToken != null) {
          return true;
        } else
          return false;
      });
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return _ExchangeViewModel(
        homeBridgeAddress: community.homeBridgeAddress,
        feePlugin: community.plugins.bridgeToForeign ??
            BridgeToForeignFeePlugin(
                name: 'bridgeToForeign',
                receiverAddress: '0x77D886e98133D99130179bdb41CE052a43d32c2F',
                isActive: true,
                type: 'fixed',
                amount: '0'),
        isProMode: store.state.userState.isProMode ?? false,
        walletAddress: store.state.userState.walletAddress,
        tokens: [...tokens, ...exchangable].toSet().toList(),
        isProModeActivated: store.state.userState.isProModeActivated,
        replaceNavigator: (isProMode) {
          store.dispatch(SwitchWalletMode(isProMode: isProMode));
        });
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}

Future<dynamic> fetchSwap(
    String walletAddress, String fromTokenAddress, String toTokenAddress,
    {String sourceAmount,
    String destinationAmount,
    bool transactions = false,
    bool skipBalanceChecks = true}) async {
  final logger = await AppFactory().getLogger('action');
  try {
    if (fromTokenAddress != null &&
        fromTokenAddress.isNotEmpty &&
        toTokenAddress != null &&
        toTokenAddress.isNotEmpty) {
      Map apiOptions = Map.from({
        'apiKey': DotEnv().env['TOTLE_API_KEY'],
        'swap': {
          'sourceAsset': fromTokenAddress,
          'destinationAsset': toTokenAddress,
        },
        'config': {
          'transactions': transactions,
          'skipBalanceChecks': skipBalanceChecks
        }
      });
      if (sourceAmount != null && sourceAmount.isNotEmpty) {
        apiOptions['swap']['sourceAmount'] = sourceAmount;
      }
      if (destinationAmount != null && destinationAmount.isNotEmpty) {
        apiOptions['swap']['destinationAmount'] = destinationAmount;
      }
      Map<String, dynamic> response =
          await exchangeApi.swap(walletAddress, options: apiOptions);
      bool success = response['success'] ?? false;
      if (success) {
        if (response['response'].containsKey('transactions')) {
          dynamic swapData = List.from(response['response']['transactions'])
              .firstWhere((element) => element['type'] == 'swap', orElse: null);
          if (swapData != null) {
            return Map.from(
                {...response['response']['summary'][0], 'tx': swapData['tx']});
          } else {
            return Map.from({...response['response']['summary'][0]});
          }
        } else {
          return Map.from({...response['response']['summary'][0]});
        }
      }
      throw response;
    }
    throw 'Error fromTokenAddress and toTokenAddress are empty';
  } catch (error) {
    logger.severe('ERROR in fetchSwap - ${error.toString()}');
    throw error;
  }
}
