import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:charge_wallet_sdk/models/models.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/bottom_sheets/tokens.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/my_new_scaffold.dart';
import 'package:fusecash/features/shared/widgets/percentage_action_bar.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';
import 'package:fusecash/features/shared/widgets/should_rebuild.dart';
import 'package:fusecash/features/swap/widgets/card.dart';
import 'package:fusecash/features/swap/widgets/insufficient_fund.dart';
import 'package:fusecash/features/swap/widgets/quote.dart';
import 'package:fusecash/features/swap/widgets/swap_icon.dart';
import 'package:fusecash/features/swap/widgets/topup_your_account.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/viewsmodels/swap.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/debouncer.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/text_formatter/formatter.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class SwapPage extends StatefulWidget {
  final Token? primaryToken;
  const SwapPage({Key? key, this.primaryToken}) : super(key: key);

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends SfWidget<SwapPage> {
  final tokenOutDebouncer = Debouncer(milliseconds: 1000);
  final tokenInDebouncer = Debouncer(milliseconds: 1000);
  TextEditingController tokenInController = TextEditingController();
  TextEditingController tokenOutController = TextEditingController();
  TradeRequestBody swapRequestBody = TradeRequestBody();
  final _tokenOutInFocus = FocusNode();

  Trade? tradeInfo;
  Trade? rateInfo;
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

  void resetState({bool focus = true}) {
    setState(() {
      isFetchingPrice = false;
      tokenOutController.clear();
      tokenInController.clear();
      rateInfo = null;
      tradeInfo = null;
      hasFund = null;
      swapRequestBody = swapRequestBody.copyWith(
        amountIn: '0',
      );
    });
    if (focus) {
      _tokenOutInFocus.requestFocus();
    }
  }

  void onTokenOutChanged(Token token) {
    if (token.address == swapRequestBody.currencyOut) {
      Token tokenPayWith = tokenOut!.copyWith();
      Token tokenReceive = tokenIn!.copyWith();
      setState(() {
        tokenOut = tokenReceive;
        tokenIn = tokenPayWith;
        swapRequestBody = swapRequestBody.copyWith(
          currencyIn: tokenReceive.address,
          currencyOut: tokenPayWith.address,
        );
      });
    } else {
      setState(() {
        tokenOut = token;
        swapRequestBody = swapRequestBody.copyWith(
          currencyIn: token.address,
        );
      });
    }
    resetState();
  }

  void onTokenInChanged(Token token) {
    if (token.address == swapRequestBody.currencyIn) {
      Token tokenPayWith = tokenOut!.copyWith();
      Token tokenReceive = tokenIn!.copyWith();
      setState(() {
        tokenOut = tokenReceive;
        tokenIn = tokenPayWith;
        swapRequestBody = swapRequestBody.copyWith(
          currencyIn: tokenReceive.address,
          currencyOut: tokenPayWith.address,
        );
      });
    } else {
      setState(() {
        tokenIn = token;
        swapRequestBody = swapRequestBody.copyWith(
          currencyOut: token.address,
        );
      });
    }
    resetState();
  }

  void getTradeInfo(
    String value,
    Function onSuccess,
  ) async {
    try {
      if (value == '0') {
        return;
      }
      getRateInfo();
      if (Formatter.isNumeric(value)) {
        setState(() {
          isFetchingPrice = true;
          swapRequestBody = swapRequestBody.copyWith(
            amountIn: value,
          );
        });
        final Trade info = await chargeApi.quote(swapRequestBody);
        setState(() {
          tradeInfo = info;
          isFetchingPrice = false;
        });
        validateBalance();
        onSuccess(tradeInfo);
      } else {
        validateBalance();
        resetState();
      }
    } catch (e) {
      _tokenOutInFocus.unfocus();
      log.info(
        'Erorr getTradeInfo ',
        error: e,
      );
      super.throwAlert(
        context,
        e.toString(),
        type: AlertsTypeEnum.ERROR,
      );
      validateBalance();
      resetState(focus: false);
    }
  }

  void getRateInfo() async {
    try {
      final rate = await chargeApi.quote(swapRequestBody);
      setState(() {
        rateInfo = rate;
      });
    } catch (e) {
      log.error('getRateInfo Error ${e.toString()}');
    }
  }

  void validateBalance() {
    final bool hasEnough = tradeInfo != null &&
        Decimal.parse(swapRequestBody.amountIn).compareTo(Formatter.fromWei(
              tokenOut!.amount,
              tokenOut!.decimals,
            )) <=
            0;
    setState(() {
      hasFund = hasEnough;
    });
  }

  void initiatePage(SwapViewModel viewModel) {
    final Token payWith = widget.primaryToken != null
        ? viewModel.tokens.firstWhere(
            (element) => widget.primaryToken?.address == element.address,
          )
        : viewModel.tokens.first;
    final Token receiveToken = viewModel.receiveTokens.firstWhere(
      (element) => element.address != payWith.address,
    );
    setState(() {
      hasFund = null;
      tokenOutController.clear();
      tokenInController.clear();
      tradeInfo = null;
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: StoreConnector<AppState, SwapViewModel>(
        distinct: true,
        converter: SwapViewModel.fromStore,
        onInit: (store) {
          if (store.state.swapState.tokens.isEmpty) {
            store.dispatch(fetchSwapList());
          }
        },
        onInitialBuild: (viewModel) {
          if (!viewModel.isFetching && (tokenOut == null || tokenIn == null)) {
            initiatePage(viewModel);
          }
        },
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel?.tokens != newViewModel.tokens &&
              newViewModel.tokens.isNotEmpty &&
              !newViewModel.isFetching) {
            initiatePage(newViewModel);
          }
        },
        builder: (_, viewModel) {
          final bool isDisabled =
              isFetchingPrice || hasFund == null || hasFund == false;
          return MyNewScaffold(
            hasScrollBody: false,
            resizeToAvoidBottomInset: true,
            title: I10n.of(context).swap,
            body: viewModel.isFetching
                ? const SizedBox(
                    height: 1,
                    child: Preloader(),
                  )
                : SizedBox(
                    height: 1,
                    child: KeyboardActions(
                      tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
                      config: KeyboardActionsConfig(
                        actions: [
                          KeyboardActionsItem(
                            focusNode: _tokenOutInFocus,
                            displayArrows: false,
                            displayActionBar: false,
                            footerBuilder: (context) {
                              return PercentageActionBar(
                                onTap: (value) {
                                  setState(() {
                                    hasFund = null;
                                    swapRequestBody = swapRequestBody.copyWith(
                                      currencyIn: tokenOut!.address,
                                      currencyOut: tokenIn!.address,
                                    );
                                  });
                                  if (_amountValidator.isValid(value)) {
                                    if (Formatter.isSmallThan(
                                        Decimal.parse(value))) {
                                      setState(() {
                                        tokenOutController.text =
                                            Formatter.padZeroIfNeeded(
                                                Decimal.parse(value));
                                      });
                                    } else {
                                      setState(() {
                                        tokenOutController.text =
                                            Formatter.padZeroIfNeeded(
                                                Decimal.parse(value));
                                      });
                                    }
                                    tokenOutDebouncer.run(
                                      () => getTradeInfo(
                                        value,
                                        (info) {
                                          if (Formatter.isSmallThan(
                                              Decimal.parse(
                                                  info.outputAmount))) {
                                            setState(() {
                                              tokenInController.text =
                                                  info.outputAmount;
                                            });
                                          } else {
                                            setState(() {
                                              tokenInController.text =
                                                  Formatter.padZeroIfNeeded(
                                                      Decimal.parse(
                                                          info.outputAmount));
                                            });
                                          }
                                        },
                                      ),
                                    );
                                    tokenOutController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                        offset: tokenOutController.text.length,
                                      ),
                                    );
                                  } else {
                                    resetState();
                                  }
                                },
                                available: Formatter.fromWei(
                                  tokenOut?.amount ?? BigInt.zero,
                                  tokenOut?.decimals ?? 18,
                                ),
                                node: _tokenOutInFocus,
                              );
                            },
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TradeCard(
                                          focusNode: _tokenOutInFocus,
                                          showCurrent: true,
                                          autofocus: false,
                                          onTap: () {
                                            TokensBottomSheet(
                                              tokens: viewModel.tokens,
                                              onTap: onTokenOutChanged,
                                              showCurrentPrice: false,
                                              title: I10n.of(context).pay_with,
                                            ).showSheet(context);
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
                                            if (_amountValidator
                                                .isValid(value)) {
                                              tokenOutDebouncer.run(
                                                () => getTradeInfo(
                                                  value,
                                                  (info) {
                                                    if (Formatter.isSmallThan(
                                                        Decimal.parse(info
                                                            .outputAmount))) {
                                                      setState(() {
                                                        tokenInController.text =
                                                            info.outputAmount;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        tokenInController.text =
                                                            Formatter.padZeroIfNeeded(
                                                                Decimal.parse(info
                                                                    .outputAmount));
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
                                          textEditingController:
                                              tokenOutController,
                                          token: tokenOut,
                                          title: I10n.of(context).pay_with,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TradeCard(
                                          onTap: () {
                                            TokensBottomSheet(
                                              tokens: viewModel.receiveTokens,
                                              onTap: onTokenInChanged,
                                              showCurrentPrice: true,
                                              title: I10n.of(context).receive,
                                            ).showSheet(context);
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
                                            if (_amountValidator
                                                .isValid(value)) {
                                              tokenInDebouncer.run(
                                                () => getTradeInfo(
                                                  value,
                                                  (info) {
                                                    if (Formatter.isSmallThan(
                                                        Decimal.parse(info
                                                            .outputAmount))) {
                                                      setState(() {
                                                        tokenOutController
                                                                .text =
                                                            info.outputAmount;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        tokenOutController
                                                                .text =
                                                            Formatter.padZeroIfNeeded(
                                                                Decimal.parse(info
                                                                    .outputAmount));
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
                                          textEditingController:
                                              tokenInController,
                                          token: tokenIn,
                                          title: I10n.of(context).you_get,
                                        ),
                                      ],
                                    ),
                                    SwapIcon(
                                      isSwapped: isSwapped,
                                      onTap: () {
                                        Token tokenPayWith =
                                            tokenOut!.copyWith();
                                        Token tokenReceive =
                                            tokenIn!.copyWith();
                                        String amountOut =
                                            tokenOutController.text;
                                        String amountIn =
                                            tokenInController.text;
                                        setState(() {
                                          hasFund = null;
                                          isSwapped = !isSwapped;
                                          tokenOut = tokenReceive;
                                          tokenIn = tokenPayWith;
                                          tokenInController.text = amountOut;
                                          tokenOutController.text = amountIn;
                                          swapRequestBody =
                                              swapRequestBody.copyWith(
                                            currencyIn: tokenReceive.address,
                                            currencyOut: tokenPayWith.address,
                                            recipient: viewModel.walletAddress,
                                          );
                                        });
                                        getTradeInfo(
                                          swapRequestBody.amountIn,
                                          (info) {
                                            tokenOutController.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset: amountIn.length,
                                              ),
                                            );
                                            _tokenOutInFocus.requestFocus();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                ShouldRebuild<Quote>(
                                  shouldRebuild: (oldWidget, newWidget) =>
                                      (oldWidget.tokenInAddress !=
                                          newWidget.tokenInAddress) ||
                                      (oldWidget.tokenOutAddress !=
                                          newWidget.tokenOutAddress),
                                  child: Quote(
                                    tokenInAddress: tokenIn?.address,
                                    tokenOutAddress: tokenOut?.address,
                                  ),
                                ),
                                InsufficientFund(
                                  hasFund: hasFund,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TopupYourAccount(),
                                Flexible(
                                  child: GradientButton(
                                    textColor: Theme.of(context).canvasColor,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    disabled: isFetchingPrice ||
                                        hasFund == null ||
                                        hasFund == false,
                                    preload: isFetchingPrice,
                                    text: I10n.of(context).review_swap,
                                    onPressed: isDisabled
                                        ? () {}
                                        : () {
                                            Analytics.track(
                                              eventName:
                                                  AnalyticsEvents.reviewSwap,
                                            );
                                            context.router.push(
                                              ReviewSwapRoute(
                                                tradeInfo: tradeInfo!,
                                                rateInfo: rateInfo,
                                                swapRequestBody:
                                                    swapRequestBody,
                                              ),
                                            );
                                          },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
