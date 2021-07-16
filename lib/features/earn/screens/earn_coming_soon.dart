import 'dart:core';
import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/account/screens/top_up.dart';
import 'package:fusecash/features/earn/dialogs/learn_more.dart';
// import 'package:fusecash/features/shared/widgets/animated_flip_counter.dart';
import 'package:fusecash/features/shared/widgets/countup.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/earn.dart';
import 'package:fusecash/utils/format.dart';
import 'package:jiffy/jiffy.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

double formatter(
  BigInt? value,
  int? decimals,
  double? price, {
  int fractionDigits = 2,
}) {
  if (value == null || decimals == null || price == null) return 0.0;
  Decimal formattedValue = Decimal.parse(
      ((value / BigInt.from(pow(10, decimals))) * price).toString());
  return formattedValue.toDouble();
}

class EarnComingSoonScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).earn,
      body: StoreConnector<AppState, EarnViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(getRewardData());
        },
        converter: EarnViewModel.fromStore,
        builder: (_, viewModel) {
          final Jiffy jiffy2 = Jiffy.unix(
            viewModel.rewardClaim!.nextClaimTimestamp,
          );
          final bool canClaim = Jiffy().isAfter(jiffy2);
          // log.info('diff ${jiffy2.diff(Jiffy())}');
          // log.info('canClaim ${canClaim}');
          // log.info('fromNow ${jiffy2.fromNow()}');
          // log.info('isBefore ${Jiffy().isAfter(jiffy2)}');
          // final BigInt value = viewModel.token!.amount +
          //     BigInt.from(
          //       num.parse(
          //         viewModel.rewardClaim!.amount,
          //       ),
          //     );
          // final String totalBalanceUSD = getFiatValue(
          //   value, viewModel.token!.decimals,
          //   double.tryParse(viewModel.token?.priceInfo?.quote ?? '0'),
          //   // fractionDigits: 10,
          // );
          final double amountToBeClaim = formatter(
            BigInt.from(num.parse(viewModel.rewardClaim!.amount)),
            viewModel.token!.decimals,
            double.tryParse(viewModel.token?.priceInfo?.quote ?? '0'),
          );

          return Container(
            color: Theme.of(context).colorScheme.primary,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: SvgPicture.asset(
                    'assets/images/green_fusd.svg',
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: SvgPicture.asset(
                    'assets/images/white_fusd.svg',
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: -50,
                  child: SvgPicture.asset(
                    'assets/images/white_fusd.svg',
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: -30,
                  child: SvgPicture.asset(
                    'assets/images/green_fusd.svg',
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Column(
                    children: [
                      viewModel.hasFUSD && viewModel.rewardClaim != null
                          ? Row(
                              children: [
                                Text(
                                  'Next claim in ',
                                  style: TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SlideCountdownClock(
                                  duration: Duration(
                                    milliseconds: jiffy2.diff(Jiffy()).toInt(),
                                  ),
                                  slideDirection: SlideDirection.Down,
                                  separator: ":",
                                  textStyle: TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onDone: () {
                                    // _scaffoldKey.currentState.showSnackBar(
                                    //     SnackBar(content: Text('Clock 1 finished')));
                                  },
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        style: TextButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * .7, 50),
                          primary: Theme.of(context).colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          side: BorderSide(
                            color: canClaim
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          viewModel.hasFUSD
                              ? 'Claim \$${smallValuesConvertor(amountToBeClaim)}'
                              : 'Deposit Fuse Dollar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                        ),
                        onPressed: canClaim
                            ? () {
                                viewModel.claimReward();
                              }
                            : () {
                                Segment.track(
                                  eventName: 'Top up Button Press',
                                  properties:
                                      Map.from({"fromScreen": 'EarnScreen'}),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TopUpScreen(),
                                  ),
                                );
                              },
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/earn_header.svg',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Text(
                          I10n.of(context).earn_description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      viewModel.hasFUSD
                          ? Column(
                              children: [
                                Text(
                                  'Your balance',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${viewModel.token!.getFiatBalance()}',
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Countup(
                                      begin: 0,
                                      end: amountToBeClaim,
                                      // end: viewModel.rewardClaim!.humanAmount,
                                      precision: 3,
                                      duration: Duration(milliseconds: 3000),
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                    // AnimatedFlipCounter(
                                    //   value: .005,
                                    //   fractionDigits: 2, // decimal precision
                                    //   // suffix: "%",
                                    //   textStyle: TextStyle(
                                    //     fontSize: 50,
                                    //     fontWeight: FontWeight.bold,
                                    //     color: Theme.of(context).canvasColor,
                                    //   ),
                                    // )
                                  ],
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => LearnMoreDialog(),
                                );
                              },
                              focusColor: Theme.of(context).canvasColor,
                              highlightColor: Theme.of(context).canvasColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    I10n.of(context).learn_about_fuse_dollar,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/deposit_arrow.svg',
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
