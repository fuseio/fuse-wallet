import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
// import 'package:flutter_segment/flutter_segment.dart';
// import 'package:fusecash/features/account/screens/top_up.dart';
import 'package:fusecash/features/contacts/screens/send_amount.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/features/swap/widgets/card.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/redux/viewsmodels/swap.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/debouncer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SwapScreen extends StatefulWidget {
  final Token? primaryToken;
  SwapScreen({Key? key, this.primaryToken}) : super(key: key);

  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final tokenOutDebouncer = Debouncer(milliseconds: 1000);
  final tokenInDebouncer = Debouncer(milliseconds: 1000);
  TextEditingController tokenInController = TextEditingController();
  TextEditingController tokenOutController = TextEditingController();
  SwapRequestBody swapRequestBody = SwapRequestBody();
  TradeInfo? info;
  TradeInfo? rateInfo;
  bool isFetchingPrice = false;
  Token? tokenOut;
  Token? tokenIn;
  bool isSwapped = false;
  bool? hasFund;
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');
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

  void resetState() {
    setState(() {
      isFetchingPrice = false;
      tokenOutController.text = '';
      tokenInController.text = '';
      rateInfo = null;
      info = null;
      hasFund = null;
      swapRequestBody = swapRequestBody.copyWith(
        amountIn: '0',
      );
    });
  }

  void onTokenOutChanged(Token token) {
    setState(() {
      tokenOut = token;
      swapRequestBody = swapRequestBody.copyWith(
        currencyIn: token.address,
      );
    });
    resetState();
  }

  void onTokenInChanged(Token token) {
    setState(() {
      tokenIn = token;
      swapRequestBody = swapRequestBody.copyWith(
        currencyOut: token.address,
      );
    });
    resetState();
  }

  void getTradeInfo(
    String value,
    Function onSuccess,
  ) async {
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
        final TradeInfo rate = result[1];
        setState(() {
          rateInfo = rate;
          info = tradeInfo;
          isFetchingPrice = false;
        });
        onSuccess(tradeInfo);
        validateBalance();
      } else {
        validateBalance();
        resetState();
      }
    } catch (e) {
      validateBalance();
      resetState();
    }
  }

  showBottomMenu(
    List<Token> tokens,
    Function(Token token) onTap,
    bool showCurrentPrice,
    String title,
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
                          title,
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
                              : ListView(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    showCurrentPrice
                                        ? ListTile(
                                            contentPadding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  I10n.of(context).price,
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  '24H',
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: ClampingScrollPhysics(),
                                      separatorBuilder: (_, int index) =>
                                          Divider(
                                        height: 0,
                                      ),
                                      itemCount: tokens.length,
                                      itemBuilder: (context, index) =>
                                          TokenTile(
                                        token: tokens[index],
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
          Token tokenPayWith = tokenOut!.copyWith();
          Token tokenReceive = tokenIn!.copyWith();
          String amountOut = tokenOutController.text;
          String amountIn = tokenInController.text;
          setState(() {
            hasFund = null;
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
          getTradeInfo(
            swapRequestBody.amountIn,
            (info) {},
          );
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
          String max = tokenOut!.getBalance(true);
          if ((Decimal.tryParse(max) ?? Decimal.zero) > Decimal.zero) {
            setState(() {
              tokenOutController.text = display(num.tryParse(max));
            });
            getTradeInfo(
              max,
              (info) => setState(() {
                tokenInController.text =
                    display(num.tryParse(info.outputAmount));
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

  Widget topUpYourAccount(SwapViewModel viewModel) {
    List depositPlugins = viewModel.plugins.getDepositPlugins();
    return viewModel.tokens.isNotEmpty &&
            viewModel.payWithTokens.isEmpty &&
            depositPlugins.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Todo - Top up button
                  // Segment.track(
                  //   eventName: 'Top up Button Press',
                  //   properties: Map.from({"fromScreen": 'swapScreen'}),
                  // );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TopUpScreen(),
                  //   ),
                  // );
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
                              text:
                                  I10n.of(context).your_balance_is_empty + ' ',
                            ),
                            TextSpan(
                              text: I10n.of(context).top_up_your_account,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
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
          )
        : SizedBox.shrink();
  }

  void validateBalance() {
    final bool hasEnough = rateInfo != null &&
        info != null &&
        (num.parse(swapRequestBody.amountIn)).compareTo(
              num.parse(tokenOut!.getBalance(true)),
            ) <=
            0;
    setState(() {
      hasFund = hasEnough;
    });
  }

  void onInitialBuild(SwapViewModel viewModel) {
    final Token payWith = widget.primaryToken != null
        ? viewModel.tokens.firstWhere(
            (element) => widget.primaryToken?.address == element.address)
        : viewModel.tokens.firstWhere(
            (element) => element.address == fuseDollarToken.address);
    final Token receiveToken = viewModel.receiveTokens
        .firstWhere((element) => element.address != payWith.address);
    setState(() {
      hasFund = null;
      tokenOutController.text = '';
      tokenInController.text = '';
      info = null;
      rateInfo = null;
      tokenOut = payWith;
      tokenIn = receiveToken;
      swapRequestBody = swapRequestBody.copyWith(
        recipient: viewModel.walletAddress,
        currencyOut: receiveToken.address,
        currencyIn: payWith.address,
        amountIn: '0',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).swap,
      body: StoreConnector<AppState, SwapViewModel>(
        distinct: true,
        converter: SwapViewModel.fromStore,
        onInitialBuild: onInitialBuild,
        // onInit: (store) {
        //   store.dispatch(fetchSwapList());
        // },
        onWillChange: (previousViewModel, newViewModel) {
          onInitialBuild(newViewModel);
        },
        builder: (_, viewModel) {
          if (viewModel.tokens.isEmpty &&
              (viewModel.receiveTokens.isEmpty ||
                  viewModel.payWithTokens.isEmpty)) {
            return Preloader();
          } else {
            return InkWell(
              focusColor: Theme.of(context).canvasColor,
              highlightColor: Theme.of(context).canvasColor,
              onTap: () {
                WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
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
                                  showCurrent: true,
                                  autofocus: true,
                                  onTap: () {
                                    showBottomMenu(
                                      viewModel.payWithTokens,
                                      onTokenOutChanged,
                                      false,
                                      I10n.of(context).pay_with,
                                    );
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      hasFund = null;
                                      swapRequestBody =
                                          swapRequestBody.copyWith(
                                        currencyIn: tokenOut!.address,
                                        currencyOut: tokenIn!.address,
                                      );
                                    });
                                    if (_amountValidator.isValid(value)) {
                                      tokenOutDebouncer.run(
                                        () => getTradeInfo(
                                          value,
                                          (info) {
                                            if (smallNumberTest(
                                                num.parse(info.outputAmount))) {
                                              setState(() {
                                                tokenInController.text =
                                                    info.outputAmount;
                                              });
                                            } else {
                                              setState(() {
                                                tokenInController.text =
                                                    display(num.tryParse(
                                                        info.outputAmount));
                                              });
                                            }
                                          },
                                        ),
                                      );
                                    } else {
                                      resetState();
                                    }
                                  },
                                  isSwapped: isSwapped,
                                  // useMaxWidget: maxButton(),
                                  textEditingController: tokenOutController,
                                  token: tokenOut,
                                  title: I10n.of(context).pay_with,
                                ),
                                TradeCard(
                                  onTap: () {
                                    showBottomMenu(
                                      viewModel.receiveTokens
                                        ..removeWhere((element) =>
                                            element.address ==
                                            tokenOut!.address),
                                      onTokenInChanged,
                                      true,
                                      I10n.of(context).receive,
                                    );
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      hasFund = null;
                                      swapRequestBody =
                                          swapRequestBody.copyWith(
                                        currencyIn: tokenIn!.address,
                                        currencyOut: tokenOut!.address,
                                      );
                                    });
                                    if (_amountValidator.isValid(value)) {
                                      tokenInDebouncer.run(
                                        () => getTradeInfo(
                                          value,
                                          (info) {
                                            if (smallNumberTest(
                                                num.parse(info.outputAmount))) {
                                              setState(() {
                                                tokenOutController.text =
                                                    info.outputAmount;
                                              });
                                            } else {
                                              setState(() {
                                                tokenOutController.text =
                                                    display(num.tryParse(
                                                        info.outputAmount));
                                              });
                                            }
                                          },
                                        ),
                                      );
                                    } else {
                                      resetState();
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
                      ),
                      hasFund == null
                          ? SizedBox.shrink()
                          : hasFund == true
                              ? SizedBox.shrink()
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      I10n.of(context).insufficient_fund,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      topUpYourAccount(
                        viewModel,
                      ),
                      Center(
                        child: Column(
                          children: [
                            PrimaryButton(
                              disabled: isFetchingPrice ||
                                  hasFund == null ||
                                  hasFund == false,
                              preload: isFetchingPrice,
                              label: I10n.of(context).review_swap,
                              onPressed: () {
                                context.router.push(
                                  ReviewSwapScreen(
                                    tradeInfo: info!,
                                    rateInfo: rateInfo!,
                                    swapRequestBody: swapRequestBody,
                                  ),
                                );
                              },
                            )
                          ],
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
          }
        },
      ),
    );
  }
}
