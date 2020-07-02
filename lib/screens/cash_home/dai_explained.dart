import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/community.dart';
import 'package:peepl/models/plugins/fee_base.dart';
import 'package:peepl/screens/cash_home/prize.dart';
import 'package:peepl/screens/cash_home/webview_page.dart';
import 'package:peepl/screens/send/send_amount.dart';
import 'package:peepl/screens/send/send_amount_arguments.dart';
import 'package:peepl/utils/addresses.dart';
import 'package:peepl/widgets/activate_pro_mode.dart';
import 'package:peepl/widgets/deposit_dai_popup.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:redux/redux.dart';

class DaiExplainedScreen extends StatefulWidget {
  @override
  _DaiExplainedScreenState createState() => _DaiExplainedScreenState();
}

class _DaiExplainedScreenState extends State<DaiExplainedScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        automaticallyImplyLeading: false,
        title: I18n.of(context).dai_points,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFF7FFF8),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                    border: Border.all(color: Color(0xFFECF7EF))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/dai_points_logo.png",
                          width: 75,
                          height: 75,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '''DAI points is the default token of the Fuse wallet. Get some points to start exploring the features:''',
                          style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.secondary),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '1 DAI = \$1 = 100 DAI points',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00BE66)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Win up to 100 points!',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SvgPicture.asset('assets/images/v_sign.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Get 20 points for installing the app',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset('assets/images/v_sign.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      'Get 40 points after sending money to a friend',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset('assets/images/v_sign.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      'Get 40 points for backing-up your wallet',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                  width: 260.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Theme.of(context).primaryColorLight,
                                          Theme.of(context).primaryColorDark,
                                        ],
                                      ),
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(30.0)),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withAlpha(14))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  PrizeScreen()));
                                      Segment.track(
                                          eventName: "User open prize page");
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Win a weekly prize!',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .button
                                                      .color,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/gift_black.svg',
                                          ),
                                        ]),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new StoreConnector<AppState, _DaiPointsViewModel>(
                distinct: true,
                onInit: (store) {
                  Segment.screen(screenName: '/dai-explained-screen');
                },
                converter: _DaiPointsViewModel.fromStore,
                builder: (_, vm) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (vm.isProModeActivate) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DepositDaiDialog();
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ActivateProModeDialog();
                                      });
                                  Segment.track(
                                      eventName: "Wallet: ADD DAI clicked");
                                }
                              },
                              child: Text(
                                I18n.of(context).addDai,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              'assets/images/arrow_black.png',
                              width: 15,
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (vm.isProModeActivate) {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => SendAmountScreen(
                                        pageArgs: SendAmountArguments(
                                            avatar: AssetImage(
                                              'assets/images/ethereume_icon.png',
                                            ),
                                            name: 'Send to ethereum',
                                            feePlugin: vm.feePlugin,
                                            sendType: SendType.ETHEREUM_ADDRESS,
                                            accountAddress: vm
                                                .daiPointsHomeBridgeAddress))));
                            Segment.track(
                                eventName:
                                    'Wallet: Choose amount to transfer - activate pro mode');
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ActivateProModeDialog();
                                });
                            Segment.track(
                                eventName: "Wallet: Withdraw DAI clicked");
                          }
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                I18n.of(context).withdrawDAI,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'assets/images/arrow_black.png',
                                width: 15,
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => WebViewPage(
                                pageArgs: WebViewPageArguments(
                                    url:
                                        'https://docs.fuse.io/the-mobile-wallet/what-is-dai-points',
                                    title: 'What is dai points?'),
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Still have question?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.secondary)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '''Learn more''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              )
            ],
          )
        ]);
  }
}

class _DaiPointsViewModel {
  final bool isProModeActivate;
  final String daiPointsHomeBridgeAddress;
  final FeePlugin feePlugin;
  _DaiPointsViewModel({
    this.isProModeActivate,
    this.daiPointsHomeBridgeAddress,
    this.feePlugin,
  });

  static _DaiPointsViewModel fromStore(Store<AppState> store) {
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return _DaiPointsViewModel(
      feePlugin: community.plugins.bridgeToForeign,
      daiPointsHomeBridgeAddress: community.homeBridgeAddress,
      isProModeActivate: store.state.userState.isProModeActivated,
    );
  }
}
