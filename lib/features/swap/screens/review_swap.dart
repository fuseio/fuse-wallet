import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/redux/viewsmodels/review_swap.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReviewSwapScreen extends StatefulWidget {
  final TradeInfo tradeInfo;
  final TradeInfo rateInfo;
  final SwapRequestBody swapRequestBody;

  const ReviewSwapScreen({
    required this.tradeInfo,
    required this.rateInfo,
    required this.swapRequestBody,
  });

  @override
  _ReviewTradeScreenState createState() => _ReviewTradeScreenState();
}

class _ReviewTradeScreenState extends State<ReviewSwapScreen> {
  bool isPreloading = false;
  @override
  void initState() {
    super.initState();
  }

  _onPress(ReviewSwapViewModel viewModel) async {
    setState(() {
      isPreloading = true;
    });
    SwapCallParameters swapCallParameters =
        await fuseSwapService.requestParameters(
      widget.swapRequestBody,
    );
    viewModel.swap(
      widget.swapRequestBody,
      swapCallParameters,
      widget.tradeInfo,
      () {
        context.router.popUntilRoot();
        context.navigateTo(
          HomeTab(
            children: [
              HomeScreen(),
            ],
          ),
        );
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
      },
      () {
        setState(() {
          isPreloading = false;
        });
      },
    );
  }

  Widget infoCard() {
    final String payWithAmount =
        smallNumberTest(num.parse(widget.tradeInfo.inputAmount))
            ? '${widget.tradeInfo.inputAmount} '
            : '${display(num.parse(widget.tradeInfo.inputAmount))} ';

    final String receiveAmount =
        smallNumberTest(num.parse(widget.tradeInfo.outputAmount))
            ? '${widget.tradeInfo.outputAmount} '
            : '${display(num.parse(widget.tradeInfo.outputAmount))} ';
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/swap_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                I10n.of(context).pay_with,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: payWithAmount,
                      // text:
                      //     '${display(num.parse(widget.tradeInfo.inputAmount))} ',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.tradeInfo.inputToken,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                I10n.of(context).receive,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: receiveAmount,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.tradeInfo.outputToken,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget extraInfo() {
    final String payWithRate =
        smallNumberTest(num.parse(widget.rateInfo.inputAmount))
            ? '${widget.rateInfo.inputAmount} '
            : '${display(num.parse(widget.rateInfo.inputAmount))}';

    final String receiveRate =
        smallNumberTest(num.parse(widget.rateInfo.outputAmount))
            ? '${widget.rateInfo.outputAmount} '
            : '${display(num.parse(widget.rateInfo.outputAmount))}';
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              I10n.of(context).network_fee,
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/approve_icon.svg',
                  width: 13,
                  height: 13,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  I10n.of(context).free,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 25, bottom: 25),
          child: Divider(
            height: 1,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              I10n.of(context).rate,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            AutoSizeText(
              payWithRate +
                  widget.rateInfo.inputToken +
                  '=' +
                  receiveRate +
                  widget.rateInfo.outputToken,
              style: TextStyle(
                fontSize: 16,
              ),
              maxLines: 1,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 25, bottom: 25),
          child: Divider(
            height: 1,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              I10n.of(context).slippage,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '0.50%',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).review_swap,
      body: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  infoCard(),
                  extraInfo(),
                ],
              ),
            ),
            Column(
              children: [
                StoreConnector<AppState, ReviewSwapViewModel>(
                  distinct: true,
                  converter: ReviewSwapViewModel.fromStore,
                  builder: (_, viewModel) => Center(
                    child: PrimaryButton(
                      label: I10n.of(context).swap,
                      disabled: isPreloading,
                      preload: isPreloading,
                      onPressed: () => _onPress(viewModel),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
