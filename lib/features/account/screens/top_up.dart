import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/features/account/screens/crypto_deposit.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:fusecash/utils/onramp.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/url.dart';
import 'package:fusecash/utils/webview.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class CustomTile extends StatelessWidget {
  final void Function() onTap;
  final String menuIcon;
  final String subtitle;
  final String title;

  const CustomTile({
    Key? key,
    required this.onTap,
    required this.menuIcon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      onTap: onTap,
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF888888),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        Icons.navigate_next,
        color: Colors.black,
      ),
      leading: SvgPicture.asset(
        'assets/images/${menuIcon}.svg',
      ),
    );
  }
}

class TopUpScreen extends StatefulWidget {
  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  bool showWireTransfer = false;
  bool showTransak = false;
  onInit(store) async {
    try {
      final dio = getIt<Dio>();
      Response response = await dio.get('http://ip-api.com/json');
      Map countryData = Map.from(response.data);
      final String currentCountry = countryData['country'];
      setState(() {
        showTransak =
            countriesWithTransak.any((country) => country == currentCountry);
        showWireTransfer = countriesWithWireTransfer
            .any((country) => country == currentCountry);
      });
    } catch (e) {
      log.error('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).top_up,
      body: StoreConnector<AppState, TopUpViewModel>(
        distinct: true,
        converter: TopUpViewModel.fromStore,
        onInit: onInit,
        builder: (_, viewModel) {
          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomTile(
                      title: I10n.of(context).credit_card,
                      menuIcon: 'credit_card',
                      subtitle: showTransak ? '(Transak)' : '(Ramp network)',
                      onTap: () {
                        final String url = showTransak
                            ? viewModel.plugins.transak!.widgetUrl
                            : viewModel.plugins.rampInstant!.widgetUrl;
                        openDepositWebview(
                          context: context,
                          withBack: true,
                          url: url,
                        );
                        Segment.track(
                          eventName: 'Deposit: Credit Card',
                          properties: Map.from(
                            {'provider': showTransak ? 'Transak' : 'Ramp'},
                          ),
                        );
                      },
                    ),
                    showWireTransfer
                        ? CustomTile(
                            title: I10n.of(context).wire_transfer,
                            menuIcon: 'credit_card',
                            subtitle: '(Ramp network)',
                            onTap: () {
                              final String url =
                                  viewModel.plugins.rampInstant!.widgetUrl;
                              openDepositWebview(
                                context: context,
                                withBack: true,
                                url: url,
                              );
                              Segment.track(
                                eventName: 'Deposit: Wire Transfer',
                                properties: Map.from(
                                  {
                                    'provider': showTransak ? 'Transak' : 'Ramp'
                                  },
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink(),
                    CustomTile(
                      title: I10n.of(context).deposit_from_ethereum,
                      menuIcon: 'etheruem',
                      subtitle: I10n.of(context).bridge_from_ethereum,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoDepositScreen(
                              'https://fuseswap.com/#/bridge?sourceChain=1&recipient=${viewModel.walletAddress}',
                              'If you have USDC on Ethereum please use the URL below with your Metamask account on a desktop browser to deposit to Fuse:',
                            ),
                          ),
                        );
                      },
                    ),
                    CustomTile(
                      title: I10n.of(context).deposit_from_BSC,
                      menuIcon: 'usdc',
                      subtitle: I10n.of(context).bridge_from_BSC,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoDepositScreen(
                              'https://fuseswap.com/#/bridge?sourceChain=56&recipient=${viewModel.walletAddress}',
                              'If you have ETH, BNB or FUSE on Binance Smart Chain (BSC) please use the URL below with your Metamask account on a desktop browser to deposit to Fuse:',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      onTap: () {
                        final Uri _emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'hello@fuse.io',
                        );
                        launchUrl(_emailLaunchUri.toString());
                        Segment.track(
                            eventName: 'Contact us',
                            properties:
                                Map.from({"fromScreen": 'TopUpScreen'}));
                      },
                      title: Text(
                        I10n.of(context).contact_us_for_support,
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                      leading: SvgPicture.asset(
                        'assets/images/support.svg',
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
  }
}
