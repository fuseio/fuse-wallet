import 'dart:core';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/account/screens/top_up.dart';
import 'package:fusecash/features/earn/dialogs/learn_more.dart';
import 'package:fusecash/features/shared/widgets/countup.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/earn.dart';
import 'package:fusecash/utils/format.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

final num MINIMUM_FOR_CLAIM = 0.01;

double formatter(
  BigInt? value,
  int? decimals,
  double? price, {
  int fractionDigits = 2,
}) {
  if (value == null || decimals == null || price == null) return 0.0;
  num formattedValue =
      num.parse(((value / BigInt.from(pow(10, decimals))) * price).toString());
  return formattedValue.toDouble();
}

class EarnScreen extends StatefulWidget {
  @override
  _EarnScreenState createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  Widget didntTopup() {
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
            child: depositFUSD(),
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
                InkWell(
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
  }

  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).earn,
      body: StoreConnector<AppState, EarnViewModel>(
        distinct: true,
        onWillChange: (previousViewModel, newViewModel) {
          if ((previousViewModel?.token?.amount ?? BigInt.zero)
                  .compareTo(newViewModel.token?.amount ?? BigInt.zero) !=
              0) {
            newViewModel.updateReward();
          }
        },
        converter: EarnViewModel.fromStore,
        builder: (_, viewModel) {
          if (viewModel.rewardClaim == null) {
            return didntTopup();
          }
          final Jiffy nextClaimTimestamp = Jiffy.unix(
            viewModel.rewardClaim?.nextClaimTimestamp ??
                DateTime.now().millisecondsSinceEpoch,
          );
          final bool hasEnoughToClaim =
              (viewModel.rewardClaim?.humanAmount ?? 0)
                      .compareTo(MINIMUM_FOR_CLAIM) >=
                  0;
          final bool canClaim =
              nextClaimTimestamp.isBefore(Jiffy()) && hasEnoughToClaim;
          final double yourBalance = formatter(
            (viewModel.token?.amount ?? BigInt.zero),
            (viewModel.token?.decimals ?? 18),
            double.tryParse(viewModel.token?.priceInfo?.quote ?? '0'),
          );
          final double yourProjectedBalance = formatter(
            BigInt.from(num.parse(viewModel.rewardClaim?.amount ?? '0')) +
                (viewModel.token?.amount ?? BigInt.zero),
            viewModel.token?.decimals,
            double.tryParse(viewModel.token?.priceInfo?.quote ?? '0'),
          );
          final double amountToBeClaim = formatter(
            BigInt.from(num.parse(viewModel.rewardClaim?.amount ?? '0')),
            viewModel.token?.decimals,
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
                      nextClaimTimestamp.isAfter(Jiffy())
                          ? Row(
                              children: [
                                Text(
                                  '${I10n.of(context).next_claim} ',
                                ),
                                CountdownTimer(
                                  endTime: viewModel
                                          .rewardClaim!.nextClaimTimestamp
                                          .toInt() *
                                      1000,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      !hasEnoughToClaim && nextClaimTimestamp.isBefore(Jiffy())
                          ? Row(
                              children: [
                                Text(
                                  I10n.of(context).min_to_claim,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20,
                      ),
                      !viewModel.hasFUSD && !canClaim
                          ? depositFUSD()
                          : OutlinedButton(
                              style: canClaim
                                  ? enableButtonStyle()
                                  : disableButtonStyle(),
                              child: Text(
                                I10n.of(context).claim +
                                    ' \$${smallValuesConvertor(amountToBeClaim)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              onPressed: canClaim
                                  ? () {
                                      viewModel.claimReward(
                                        () {
                                          context.navigateTo(
                                            HomeTab(
                                              children: [
                                                HomeScreen(),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  : null,
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
                      viewModel.rewardClaim != null || canClaim
                          ? Column(
                              children: [
                                Text(
                                  I10n.of(context).your_projected_balance,
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
                                    Countup(
                                      begin: yourBalance,
                                      end: yourProjectedBalance,
                                      prefix: '\$',
                                      precision: 3,
                                      duration: Duration(milliseconds: 3000),
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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

  Widget depositFUSD() {
    return OutlinedButton(
      style: enableButtonStyle(),
      child: Text(
        // 'Deposit Fuse Dollar',
        I10n.of(context).deposit_fuse_dollar,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
      ),
      onPressed: () {
        Segment.track(
          eventName: 'Top up Button Press',
          properties: Map.from({"fromScreen": 'EarnScreen'}),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopUpScreen(),
          ),
        );
      },
    );
  }

  ButtonStyle disableButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(MediaQuery.of(context).size.width * .7, 50),
      primary: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
        width: 2.0,
      ),
    );
  }

  ButtonStyle enableButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(MediaQuery.of(context).size.width * .7, 50),
      primary: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.onSurface,
        width: 2.0,
      ),
    );
  }
}
