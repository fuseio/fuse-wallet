import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/features/account/screens/crypto_deposit.dart';
import 'package:fusecash/features/shared/widgets/bounce.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/remote_config.dart';

void openDepositWebview({
  required BuildContext context,
  required String url,
}) {
  FlutterWebBrowser.openWebPage(
    url: url,
    customTabsOptions: const CustomTabsOptions(
      shareState: CustomTabsShareState.on,
      instantAppsEnabled: true,
      showTitle: true,
      urlBarHidingEnabled: true,
    ),
    safariVCOptions: const SafariViewControllerOptions(
      barCollapsingEnabled: true,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,
    ),
  );
}

class DepositBottomSheet extends StatelessWidget {
  const DepositBottomSheet({Key? key}) : super(key: key);

  void onPurchaseCreated(Purchase purchase, String token, String url) {
    Analytics.track(
      eventName: AnalyticsEvents.rampPurchaseCreated,
      properties: {
        'id': purchase.id,
        'asset': purchase.asset,
        'receiverAddress': purchase.receiverAddress,
        'cryptoAmount': purchase.cryptoAmount,
        'fiatCurrency': purchase.fiatCurrency,
        'status': purchase.status,
        'finalTxHash': purchase.finalTxHash,
        'paymentMethodType': purchase.paymentMethodType,
        'endTime': purchase.endTime,
        'token': token,
        'url': url,
      },
    );
  }

  void onRampFailed() {
    Analytics.track(eventName: AnalyticsEvents.rampWidgetFailed);
  }

  void onRampClosed() {
    Analytics.track(eventName: AnalyticsEvents.rampWidgetClosed);
  }

  void showRamp(
    bool showUSDC,
    walletAddress, {
    String type = 'creditCard',
  }) {
    final String projectApiKey = dotenv.env['PUBLIC_API_KEY']!;
    Analytics.track(
      eventName: AnalyticsEvents.deposit,
      properties: {
        'type': type,
        'provider': 'ramp',
      },
    );
    Configuration configuration = Configuration();
    configuration.deepLinkScheme = Strings.appTitle;
    configuration.hostAppName = Strings.appTitle;
    configuration.finalUrl = Variables.privacyPolicyPage;
    configuration.defaultAsset = showUSDC ? 'USDC' : 'FUSE_FUSD';
    configuration.swapAsset = showUSDC ? 'USDC' : 'FUSE_FUSD';
    configuration.userAddress =
        showUSDC ? Addresses.userAddressOnMainnet : walletAddress;
    configuration.hostApiKey = dotenv.env['RAMP_API_KEY']!;
    configuration.webhookStatusUrl =
        '${Variables.webhookStatusUrl}/$walletAddress/$projectApiKey';
    RampFlutter.showRamp(
      configuration,
      onPurchaseCreated,
      onRampClosed,
      onRampFailed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 30,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: FutureBuilder<Response>(
          future: getIt<Dio>().get('http://ip-api.com/json'),
          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(I10n.of(context).something_went_wrong),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                      '${I10n.of(context).close} & ${I10n.of(context).try_again.toLowerCase()}'),
                ],
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const SizedBox.shrink();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Column(
                  children: [
                    Text(
                        '${I10n.of(context).loading} ${I10n.of(context).options}'),
                    const SizedBox(
                      height: 30,
                    ),
                    const Preloader(
                      width: 25,
                      height: 25,
                    )
                  ],
                );
              case ConnectionState.done:
                final Map countryData = Map.from(snapshot.data?.data ?? {});
                final String currentCountry = countryData['country'];
                final bool showXanpool = getIt<RemoteConfigService>()
                    .withXanpool
                    .any((country) => country == currentCountry);
                final showUSDC = getIt<RemoteConfigService>()
                    .withOnrampUSDC
                    .any((country) => country == currentCountry);
                final showWireTransfer = getIt<RemoteConfigService>()
                    .getWithWireTransfer
                    .any((country) => country == currentCountry);

                return StoreConnector<AppState, TopUpViewModel>(
                  distinct: true,
                  converter: TopUpViewModel.fromStore,
                  builder: (context, viewModel) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          I10n.of(context).deposit_fusd,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 5),
                        AutoSizeText.rich(
                          TextSpan(
                            children: [
                              // TextSpan(
                              //   text:
                              //       '${I10n.of(context).deposit_bonus_explained} ',
                              //   style: Theme.of(context).textTheme.bodyMedium,
                              // ),
                              TextSpan(
                                text: I10n.of(context).learn_more,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        _DepositBottomSheetItem(
                          boxShadow: boxShadow,
                          backColor: Theme.of(context).colorScheme.primary,
                          textColor: Theme.of(context).canvasColor,
                          icon: 'deposit_credit_card',
                          text: I10n.of(context).credit_card,
                          onPressed: () {
                            showRamp(
                              showUSDC,
                              viewModel.walletAddress,
                            );
                          },
                        ),
                        if (dotenv.env['XANPOOL_API_KEY'] != null)
                          showWireTransfer || showXanpool
                              ? _DepositBottomSheetItem(
                                  backColor: lightGreen,
                                  icon: 'wire_transfer',
                                  text: I10n.of(context).wire_transfer,
                                  onPressed: () {
                                    final xanpoolTopupWidgetUrl =
                                        'https://widget.xanpool.com?isWebView=true&apiKey=${dotenv.env['XANPOOL_API_KEY']}&cryptoCurrency=FUSD&transactionType=buy&redirectUrl=https://fuse.cash/pending';
                                    if (showXanpool) {
                                      final String projectApiKey =
                                          dotenv.env['PUBLIC_API_KEY']!;
                                      final String partnerData =
                                          '${viewModel.walletAddress}_$projectApiKey';
                                      Analytics.track(
                                        eventName: AnalyticsEvents.deposit,
                                        properties: {
                                          'type': 'wireTransfer',
                                          'provider': 'xanpool'
                                        },
                                      );
                                      openDepositWebview(
                                        context: context,
                                        url:
                                            '$xanpoolTopupWidgetUrl&wallet=${viewModel.walletAddress}&partnerData=$partnerData',
                                      );
                                    } else {
                                      showRamp(
                                        showUSDC,
                                        viewModel.walletAddress,
                                        type: 'wireTransfer',
                                      );
                                    }
                                  },
                                )
                              : const SizedBox.shrink(),
                        _DepositBottomSheetItem(
                          backColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.25),
                          icon: 'deposit_from_eth',
                          text: I10n.of(context).deposit_from_ethereum,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CryptoDepositScreen(
                                  'https://app.voltage.finance/#/bridge?sourceChain=1&recipient=${viewModel.walletAddress}',
                                  I10n.of(context).crypto_deposit_eth,
                                ),
                              ),
                            );
                          },
                        ),
                        _DepositBottomSheetItem(
                          backColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.25),
                          icon: 'deposit_from_bsc',
                          text: I10n.of(context).deposit_from_BSC,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CryptoDepositScreen(
                                  'https://app.voltage.finance/#/bridge?sourceChain=56&recipient=${viewModel.walletAddress}',
                                  I10n.of(context).crypto_deposit_bsc,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _InfoWidget(
                                prefixIcon: SvgPicture.asset(
                                  'assets/images/contact_us_icon.svg',
                                ),
                                text: I10n.of(context).contact_us,
                                onPressed: () {},
                              ),
                              _InfoWidget(
                                prefixIcon: Image.asset(
                                  'assets/images/fuse_dollar_green.png',
                                  width: 22,
                                  height: 22,
                                ),
                                text: I10n.of(context).what_is_fuse_dollar,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

extension DepositSheetExtension on DepositBottomSheet {
  Future<T?> showSheet<T>(
    BuildContext context,
    String fromScreen,
  ) {
    Analytics.track(
      eventName: AnalyticsEvents.topUp,
      properties: Map.from({
        "fromScreen": fromScreen,
      }),
    );
    return showBarModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) => this,
    );
  }
}

class _InfoWidget extends StatelessWidget {
  final Widget prefixIcon;
  final String text;
  final VoidCallback onPressed;

  const _InfoWidget({
    Key? key,
    required this.prefixIcon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          prefixIcon,
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _DepositBottomSheetItem extends StatelessWidget {
  final String text;
  final Color backColor;
  final Color textColor;
  final String icon;
  final VoidCallback onPressed;
  final List<BoxShadow>? boxShadow;

  const _DepositBottomSheetItem({
    required this.backColor,
    this.textColor = Colors.black,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 200),
      onTap: onPressed,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 7.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: backColor,
          boxShadow: boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/images/$icon.svg',
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                        color: textColor,
                      ),
                ),
              ],
            ),
            Icon(
              Icons.navigate_next,
              size: 20,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
