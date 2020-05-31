import 'package:digitalrand/screens/cash_home/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/community.dart';
import 'package:digitalrand/models/plugins/plugins.dart';
import 'package:digitalrand/screens/pro_routes.gr.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'dart:core';

class DepositDaiDialog extends StatefulWidget {
  @override
  createState() => new DepositDaiDialogState();
}

class DepositDaiDialogState extends State<DepositDaiDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Stack(
            children: <Widget>[
              new StoreConnector<AppState, DepositDaiDialogViewModel>(
                  distinct: true,
                  converter: DepositDaiDialogViewModel.fromStore,
                  builder: (_, viewModel) {
                    List depositPlugins =
                        viewModel?.plugins?.getDepositPlugins();
                    return Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Please choose how you want to deposit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: .2,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(5.0)),
                                    color: Theme.of(context).backgroundColor,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'From My Ethereum wallet',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (viewModel.isProMode) {
                                    ProRouter.navigator.pushNamed(
                                        ProRouter.proModeHomeScreen,
                                        arguments: ProModeScaffoldArguments(
                                            tabIndex: 3));
                                  } else {
                                    Router.navigator.pushNamed(
                                        Router.cashHomeScreen,
                                        arguments: CashModeScaffoldArguments(
                                            tabIndex: 3));
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  I18n.of(context).or,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(5.0)),
                                      color: Theme.of(context).backgroundColor,
                                      shape: BoxShape.rectangle),
                                  child: Center(
                                    child: Text('From my credit card',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                                onTap: () {
                                  dynamic url = depositPlugins[0].generateUrl();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                            pageArgs: WebViewPageArguments(
                                                url: url, title: 'Top up')),
                                        fullscreenDialog: true),
                                  );
                                  Segment.track(
                                      eventName: 'User clicked on top up');
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

class DepositDaiDialogViewModel {
  final Plugins plugins;
  final bool isProMode;
  DepositDaiDialogViewModel({this.plugins, this.isProMode});

  static DepositDaiDialogViewModel fromStore(Store<AppState> store) {
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return DepositDaiDialogViewModel(
      isProMode: store.state.userState.isProMode ?? false,
      plugins: community?.plugins,
    );
  }
}
