import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/features/swap/widgets/card.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/viewsmodels/swap.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/webview.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SwapScreen extends StatefulWidget {
  final Token primaryToken;
  SwapScreen({Key key, this.primaryToken}) : super(key: key);

  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen>
    with SingleTickerProviderStateMixin {
  final tokenOutDebouncer = Debouncer(milliseconds: 1000);
  final tokenInDebouncer = Debouncer(milliseconds: 1000);
  TextEditingController tokenInController = TextEditingController();
  TextEditingController tokenOutController = TextEditingController();
  SwapRequestBody swapRequestBody = SwapRequestBody();
  TradeInfo info;
  TradeInfo rateInfo;
  bool isFetchingPrice = false;
  Token tokenOut;
  Token tokenIn;
  List<Token> tokenList;
  bool isSwapped = false;
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void dispose() {
    controller?.dispose();
    tokenOutController.dispose();
    tokenInController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Segment.screen(screenName: '/swap-screen');
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
    super.initState();
  }

  void onTokenOutChanged(Token token) {
    setState(() {
      tokenOut = token;
      tokenOutController.text = '';
      swapRequestBody = swapRequestBody.copyWith(
        currencyIn: token.address,
        amountIn: '0',
      );
    });
    getTradeInfo(
      swapRequestBody.amountIn,
      (info) => setState(() {
        tokenOutController.text =
            display(num.tryParse(info.outputAmount) ?? '0');
      }),
    );
  }

  void onTokenInChanged(Token token) {
    setState(() {
      tokenIn = token;
      tokenInController.text = '';
      swapRequestBody = swapRequestBody.copyWith(
        currencyOut: token.address,
      );
    });
    getTradeInfo(
      swapRequestBody.amountIn,
      (info) => setState(() {
        tokenInController.text =
            display(num.tryParse(info.outputAmount) ?? '0');
      }),
    );
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
        rateInfo = null;
        info = null;
        swapRequestBody = swapRequestBody.copyWith(
          amountIn: '0',
        );
      });
      controller.reverse();
    };
    try {
      if (isNumeric(value)) {
        setState(() {
          isFetchingPrice = true;
          swapRequestBody = swapRequestBody.copyWith(
            amountIn: value,
          );
        });
        Future<List<TradeInfo>> swapInfo = Future.wait([
          fuseSwapService.quote(swapRequestBody),
          fuseSwapService.quote(
            swapRequestBody..copyWith(amountIn: '1').toJson(),
          ),
        ]);
        List<TradeInfo> result = await swapInfo;
        final TradeInfo tradeInfo = result[0];
        // log.info('amountIn: ${swapRequestBody.amountIn}');
        // log.info(
        //     'tradeInfo: inputAmount - ${tradeInfo.inputAmount} outputAmount - ${tradeInfo.outputAmount}');
        final TradeInfo rate = result[1];
        setState(() {
          rateInfo = rate;
          info = tradeInfo;
          isFetchingPrice = false;
        });
        onSuccess(tradeInfo);
        controller.forward();
      }
    } catch (e) {
      resetFields();
    }
  }

  showBottomMenu(
    List<Token> tokens,
    Function onTap,
    bool showCurrentPrice,
  ) {
    showBarModalBottomSheet(
      useRootNavigator: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).canvasColor,
        ),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          I10n.of(context).token,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Europa',
                            fontSize: 22,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          tokens.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Text(
                                    I10n.of(context).no_swap_option,
                                    style: TextStyle(
                                      color: Color(0xFF979797),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  separatorBuilder: (_, int index) => Divider(
                                    height: 0,
                                  ),
                                  itemCount: tokens?.length ?? 0,
                                  itemBuilder: (context, index) => TokenTile(
                                    token: tokens[index],
                                    symbolWidth: 60,
                                    symbolHeight: 60,
                                    showCurrentPrice: showCurrentPrice,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      onTap(tokens[index]);
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget swapWidgetIcon() {
    return InkWell(
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      onTap: () {
        if (this.mounted) {
          Token tokenPayWith = tokenOut.copyWith();
          Token tokenReceive = tokenIn.copyWith();
          String amountOut = tokenOutController.text;
          String amountIn = tokenInController.text;
          setState(() {
            isSwapped = !isSwapped;
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
        'assets/images/${isSwapped ? 'swap_icon2.svg' : 'swap_icon.svg'}',
        fit: BoxFit.fill,
        width: 55,
        height: 55,
      ),
    );
  }

  Widget maxButton() {
    return Container(
      child: InkWell(
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onTap: () {
          String max = formatValue(
            tokenOut.amount,
            tokenOut.decimals,
            withPrecision: true,
          );
          if ((Decimal.tryParse(max) ?? Decimal.zero) > Decimal.zero) {
            setState(() {
              tokenOutController.text = display(num.tryParse(max) ?? '0');
            });
            getTradeInfo(
              max,
              (info) => setState(() {
                tokenInController.text =
                    display(num.tryParse(info.outputAmount) ?? '0');
              }),
            );
          }
        },
        child: Text(
          I10n.of(context).use_max,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget topUpYourAccount(String url) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            openDepositWebview(
              withBack: true,
              url: url,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: AutoSizeText.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: I10n.of(context).your_balance_is_empty + ' ',
                      ),
                      TextSpan(
                        text: I10n.of(context).top_up_your_account,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_right_outlined,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).swap,
      body: StoreConnector<AppState, SwapViewModel>(
        distinct: true,
        converter: SwapViewModel.fromStore,
        onInit: (store) {
          store.dispatch(fetchSwapList());
        },
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel.tokens != newViewModel.tokens) {
            final Token payWith = widget.primaryToken != null
                ? newViewModel.tokens.firstWhere(
                    (element) => widget.primaryToken.address == element.address)
                : newViewModel.tokens[0];
            final Token receiveToken = newViewModel.tokens
                .firstWhere((element) => element.address != payWith.address);
            setState(() {
              tokenOutController.text = '';
              tokenInController.text = '';
              info = null;
              rateInfo = null;
              tokenOut = payWith;
              tokenIn = receiveToken;
              swapRequestBody = swapRequestBody.copyWith(
                recipient: newViewModel.walletAddress,
                currencyOut: receiveToken.address,
                currencyIn: payWith.address,
                amountIn: '0',
              );
            });
          }
        },
        builder: (_, viewModel) {
          if (viewModel.tokens.isEmpty &&
              (tokenOut == null || tokenIn == null)) {
            return Preloader();
          } else {
            List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
            final bool hasFund = rateInfo != null &&
                info != null &&
                (Decimal.parse(swapRequestBody?.amountIn)).compareTo(
                      Decimal.parse(
                        formatValue(
                          tokenOut?.amount,
                          tokenOut?.decimals,
                          withPrecision: true,
                        ),
                      ),
                    ) <=
                    0 &&
                viewModel.payWithTokens.isNotEmpty;
            return InkWell(
              focusColor: Theme.of(context).canvasColor,
              highlightColor: Theme.of(context).canvasColor,
              onTap: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Column(
                              children: [
                                TradeCard(
                                  onTap: () {
                                    showBottomMenu(
                                      viewModel.payWithTokens,
                                      onTokenOutChanged,
                                      false,
                                    );
                                  },
                                  onChanged: (value) {
                                    if (isNumeric(value)) {
                                      tokenOutDebouncer.run(
                                        () => getTradeInfo(
                                          value,
                                          (info) => setState(() {
                                            tokenInController.text = display(
                                                num.tryParse(
                                                        info.outputAmount) ??
                                                    '0');
                                          }),
                                        ),
                                      );
                                    }
                                  },
                                  isSwapped: isSwapped,
                                  useMaxWidget: maxButton(),
                                  textEditingController: tokenOutController,
                                  token: tokenOut,
                                  title: I10n.of(context).pay_with,
                                ),
                                TradeCard(
                                  onTap: () {
                                    showBottomMenu(
                                      viewModel.receiveTokens,
                                      onTokenInChanged,
                                      true,
                                    );
                                  },
                                  onChanged: (value) {
                                    if (isNumeric(value)) {
                                      tokenInDebouncer.run(
                                        () => getTradeInfo(
                                          value,
                                          (info) => setState(() {
                                            tokenOutController.text = display(
                                                num.tryParse(
                                                        info.outputAmount) ??
                                                    '0');
                                          }),
                                        ),
                                      );
                                    }
                                  },
                                  isSwapped: !isSwapped,
                                  textEditingController: tokenInController,
                                  token: tokenIn,
                                  title: I10n.of(context).receive,
                                ),
                              ],
                            ),
                            swapWidgetIcon()
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      viewModel.payWithTokens.isEmpty &&
                              depositPlugins.isNotEmpty
                          ? topUpYourAccount(depositPlugins[0].widgetUrl)
                          : SizedBox.shrink(),
                      Center(
                        child: SlideTransition(
                          position: offset,
                          child: Column(
                            children: [
                              PrimaryButton(
                                disabled: isFetchingPrice || !hasFund,
                                preload: isFetchingPrice,
                                labelColor: hasFund ? null : Color(0xFF797979),
                                bgColor: hasFund
                                    ? null
                                    : Theme.of(context).colorScheme.secondary,
                                label: hasFund
                                    ? I10n.of(context).review_swap
                                    : I10n.of(context).insufficient_fund,
                                onPressed: () {
                                  ExtendedNavigator.root.pushReviewSwapScreen(
                                    rateInfo: rateInfo,
                                    swapRequestBody: swapRequestBody,
                                    tradeInfo: info,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
