import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/features/swap/widgets/card.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/viewsmodels/trade.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/swap/router/swap_router.gr.dart';

class SwapScreen extends StatefulWidget {
  final Token primaryToken;
  SwapScreen({Key key, this.primaryToken}) : super(key: key);

  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final tokenOutDebouncer = Debouncer(milliseconds: 1000);
  final tokenInDebouncer = Debouncer(milliseconds: 1000);
  TextEditingController tokenInController = TextEditingController();
  TextEditingController tokenOutController = TextEditingController();
  SwapRequestBody swapRequestBody = SwapRequestBody();
  TradeInfo info;
  bool isFetchingPrice = false;
  Token tokenOut;
  Token tokenIn;
  List<Token> tokenList;

  @override
  void dispose() {
    tokenOutController.dispose();
    tokenInController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void onTokenOutChanged(Token token) {
    setState(() {
      tokenOut = token;
      swapRequestBody = swapRequestBody.copyWith(
        currencyIn: token.address,
      );
      getTradeInfo(
        swapRequestBody.amountIn,
        (info) => setState(() {
          tokenOutController.text = info.outputAmount;
        }),
      );
    });
  }

  void onTokenInChanged(Token token) {
    setState(() {
      tokenIn = token;
      swapRequestBody = swapRequestBody.copyWith(
        currencyOut: token.address,
      );
      getTradeInfo(
        swapRequestBody.amountIn,
        (info) => setState(() {
          tokenInController.text = info.outputAmount;
        }),
      );
    });
  }

  void getTradeInfo(
    String value,
    Function onSuccess,
  ) async {
    Function resetFields = () {
      setState(() {
        isFetchingPrice = false;
        tokenOutController.text = '';
        tokenInController.text = '';
      });
    };
    try {
      if (value.isNotEmpty) {
        setState(() {
          isFetchingPrice = true;
          swapRequestBody = swapRequestBody.copyWith(
            amountIn: value,
          );
        });
        TradeInfo tradeInfo = await swapService.trade(
          swapRequestBody.currencyIn,
          swapRequestBody.currencyOut,
          swapRequestBody.amountIn,
          swapRequestBody.recipient,
        );
        setState(() {
          info = tradeInfo;
          isFetchingPrice = false;
        });
        onSuccess(tradeInfo);
      } else {
        resetFields();
      }
    } catch (e) {
      resetFields();
    }
  }

  showBottomMenu(List<Token> tokens, onTap) {
    showModalBottomSheet(
      context: ExtendedNavigator.named('swapRouter').context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).splashColor,
        ),
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
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Stack swapWidgetIcon() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
          child: SizedBox(
            child: Divider(
              thickness: 1.0,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (this.mounted) {
              Token tokenPayWith = tokenOut.copyWith();
              Token tokenReceive = tokenIn.copyWith();
              String amountOut = tokenOutController.text;
              String amountIn = tokenInController.text;
              setState(() {
                tokenOut = tokenReceive;
                tokenIn = tokenPayWith;
                tokenInController.text = amountOut;
                tokenOutController.text = amountIn;
                swapRequestBody = swapRequestBody.copyWith(
                  currencyIn: tokenReceive.address,
                  currencyOut: tokenPayWith.address,
                );
              });
            }
          },
          child: SvgPicture.asset(
            'assets/images/swap_icon.svg',
            fit: BoxFit.fill,
            width: 40,
            height: 40,
          ),
        )
      ],
    );
  }

  Widget maxButton() {
    return Container(
      child: InkWell(
        onTap: () {
          String max = formatValue(
            tokenOut.amount,
            tokenOut.decimals,
            withPrecision: true,
          );
          setState(() {
            tokenOutController.text = max;
          });
          getTradeInfo(
            max,
            (info) => setState(() {
              tokenInController.text = info.outputAmount;
            }),
          );
        },
        child: Text(
          I18n.of(context).use_max,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I18n.of(context).swap,
      body: StoreConnector<AppState, TradeViewModel>(
        distinct: true,
        converter: TradeViewModel.fromStore,
        onInit: (store) {
          store.dispatch(fetchSwapList());
        },
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel.tokens != newViewModel.tokens) {
            setState(() {
              tokenOut = newViewModel.tokens[0];
              tokenIn = newViewModel.tokens[1];
              swapRequestBody = swapRequestBody.copyWith(
                recipient: newViewModel.walletAddress,
                currencyOut: newViewModel.tokens[1].address,
                currencyIn: newViewModel.tokens[0].address,
              );
            });
          }
        },
        builder: (_, viewModel) {
          if (viewModel.tokens.isEmpty) {
            return Preloader();
          } else
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  TradeCard(
                                    onTap: () {
                                      showBottomMenu(
                                        viewModel.tokens,
                                        onTokenOutChanged,
                                      );
                                    },
                                    onChanged: (value) {
                                      tokenOutDebouncer.run(
                                        () => getTradeInfo(
                                          value,
                                          (info) => setState(() {
                                            tokenInController.text =
                                                info.outputAmount;
                                          }),
                                        ),
                                      );
                                    },
                                    useMaxWidget: maxButton(),
                                    textEditingController: tokenOutController,
                                    token: tokenOut,
                                    title: I18n.of(context).pay_with,
                                  ),
                                  swapWidgetIcon(),
                                  TradeCard(
                                    onTap: () {
                                      showBottomMenu(
                                        viewModel.tokens,
                                        onTokenInChanged,
                                      );
                                    },
                                    onChanged: (value) {
                                      tokenInDebouncer.run(
                                        () => getTradeInfo(
                                          value,
                                          (info) => setState(() {
                                            tokenOutController.text =
                                                info.outputAmount;
                                          }),
                                        ),
                                      );
                                    },
                                    textEditingController: tokenInController,
                                    token: tokenIn,
                                    title: I18n.of(context).receive,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: PrimaryButton(
                          disabled: isFetchingPrice,
                          preload: isFetchingPrice,
                          labelFontWeight: FontWeight.normal,
                          label: I18n.of(context).swap,
                          fontSize: 15,
                          onPressed: () {
                            ExtendedNavigator.named('swapRouter')
                                .pushReviewSwapScreen(
                              swapRequestBody: swapRequestBody,
                              tradeInfo: info,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            );
        },
      ),
    );
    // return new;
  }
}
