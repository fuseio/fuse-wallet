import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:charge_wallet_sdk/models/models.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/review_swap.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';

class ReviewSwapPage extends StatefulWidget {
  final Trade tradeInfo;
  final Trade? rateInfo;
  final TradeRequestBody swapRequestBody;

  const ReviewSwapPage(
      {this.rateInfo,
      required this.tradeInfo,
      required this.swapRequestBody,
      Key? key})
      : super(key: key);

  @override
  State<ReviewSwapPage> createState() => _ReviewTradeScreenState();
}

class _ReviewTradeScreenState extends State<ReviewSwapPage> {
  bool isPreloading = false;

  void _onPress(ReviewSwapViewModel viewModel) async {
    setState(() {
      isPreloading = true;
    });

    viewModel.swap(
      widget.swapRequestBody,
      widget.tradeInfo,
      () {
        context.router.popUntilRoot();
        context.navigateTo(
          const HomeTab(
            children: [
              HomeRoute(),
            ],
          ),
        );
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      (errorData) {
        log.info('Oops error on swap ${errorData['error'].toString()}');
        setState(() {
          isPreloading = false;
        });
      },
    );
  }

  Widget infoCard() {
    final String payWithAmount = Formatter.isSmallThan(
            Decimal.parse(widget.tradeInfo.inputAmount))
        ? '${widget.tradeInfo.inputAmount} '
        : '${Formatter.padZeroIfNeeded(Decimal.parse(widget.tradeInfo.inputAmount))} ';

    final String receiveAmount = Formatter.isSmallThan(
            Decimal.parse(widget.tradeInfo.outputAmount))
        ? '${widget.tradeInfo.outputAmount} '
        : '${Formatter.padZeroIfNeeded(Decimal.parse(widget.tradeInfo.outputAmount))} ';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/swap_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                I10n.of(context).pay_with,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: payWithAmount,
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    TextSpan(
                      text: widget.tradeInfo.inputToken,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                maxLines: 1,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                I10n.of(context).receive,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: AutoSizeText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: receiveAmount,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      TextSpan(
                        text: widget.tradeInfo.outputToken,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget extraInfo() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 30,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              I10n.of(context).network_fee,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/approve_icon.svg',
                  width: 13,
                  height: 13,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  I10n.of(context).free,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25, bottom: 25),
          child: Divider(
            height: 1,
          ),
        ),
        if (widget.rateInfo != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                I10n.of(context).rate,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              AutoSizeText(
                '${Formatter.isSmallThan(Decimal.parse(widget.rateInfo!.inputAmount)) ? '${widget.rateInfo!.inputAmount} ' : '${Formatter.padZeroIfNeeded(Decimal.parse(widget.rateInfo!.inputAmount))} '}${widget.rateInfo!.inputToken}=${Formatter.isSmallThan(Decimal.parse(widget.rateInfo!.outputAmount)) ? '${widget.rateInfo!.outputAmount} ' : '${Formatter.padZeroIfNeeded(Decimal.parse(widget.rateInfo!.outputAmount))} '}${widget.rateInfo!.outputToken}',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
              )
            ],
          ),
        if (widget.rateInfo != null)
          const Padding(
            padding: EdgeInsets.only(top: 25, bottom: 25),
            child: Divider(
              height: 1,
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              I10n.of(context).slippage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '0.50%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      hasScrollBody: false,
      title: I10n.of(context).review_swap,
      bottomContent: StoreConnector<AppState, ReviewSwapViewModel>(
        distinct: true,
        converter: ReviewSwapViewModel.fromStore,
        builder: (_, viewModel) => GradientButton(
          width: MediaQuery.of(context).size.width * .9,
          text: I10n.of(context).swap,
          textColor: Theme.of(context).canvasColor,
          disabled: isPreloading,
          preload: isPreloading,
          onPressed: isPreloading ? null : () => _onPress(viewModel),
        ),
      ),
      body: Container(
        height: 1,
        padding: EdgeInsets.zero,
        child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          children: [
            infoCard(),
            extraInfo(),
          ],
        ),
      ),
    );
  }
}
