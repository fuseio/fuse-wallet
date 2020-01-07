import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/screens/splash/slide_animation_controller.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/transparent_button.dart';
import 'package:redux/redux.dart';
import 'create_wallet.dart';
import 'dots_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  static const _kDuration = const Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  bool isOpen = false;
  HouseController _slideController;
  ValueNotifier<double> notifier;
  int _previousPage;

  getPages() {
    return <Widget>[
      Container(
        color: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Pay and get paid using crypto\nwithout fees or friction",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ))),
      ),
      Container(
        color: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Use the wallet to send\nmoney to friends",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ))),
      ),
      Container(
        color: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Hold Ethereum assets and\naccess decentralized finance",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ))),
      ),
      Container(
        color: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CreateWallet())),
      )
    ];
  }

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    notifier?.value = _pageController.page - _previousPage;

    _slideController.rooms = _pageController.page;
  }

  @override
  void initState() {
    _slideController = HouseController(demoUpdated: _update);

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    notifier = ValueNotifier<double>(0);

    _previousPage = _pageController.initialPage;

    super.initState();
  }

  _update() => setState(() {});

  void gotoPage(page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return SplashViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          var drawer = Drawer();

          return Scaffold(
              drawer: drawer,
              body: new StoreBuilder(onInitialBuild: (store) {
                if (viewModel.privateKey != '' &&
                    viewModel.jwtToken != '' &&
                    !viewModel.isLoggedOut) {
                  viewModel.initWeb3(viewModel.privateKey);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.popAndPushNamed(context, '/Cash');
                }
              }, builder: (BuildContext context, Store<AppState> store) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 20,
                      child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: new Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: FlareActor(
                                        "assets/images/animation.flr",
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        //animation: "part1",
                                        controller: _slideController,
                                      ),
                                    ),
                                    new PageView.builder(
                                      physics:
                                          new AlwaysScrollableScrollPhysics(),
                                      controller: _pageController,
                                      itemCount: 4,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return getPages()[index % 4];
                                      },
                                    ),
                                    new Positioned(
                                      bottom: 15.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: new Container(
                                        padding: const EdgeInsets.all(20.0),
                                        child: new Center(
                                          child: new DotsIndicator(
                                            controller: _pageController,
                                            itemCount: 4,
                                            onPageSelected: (int page) {
                                              gotoPage(page);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ));
              }));
        });
  }
}

class SplashViewModel {
  final String privateKey;
  final String jwtToken;
  final bool isLoggedOut;
  final Function(String) initWeb3;
  final Function(VoidCallback successCallback) createLocalAccount;

  SplashViewModel(
      {this.privateKey,
      this.jwtToken,
      this.isLoggedOut,
      this.initWeb3,
      this.createLocalAccount});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
        privateKey: store.state.userState.privateKey,
        jwtToken: store.state.userState.jwtToken,
        isLoggedOut: store.state.userState.isLoggedOut,
        initWeb3: (privateKey) {
          store.dispatch(initWeb3Call(privateKey));
        },
        createLocalAccount: (VoidCallback successCallback) {
          store.dispatch(createLocalAccountCall(successCallback));
        }
        // accountAddress: store.state.userState.accountAddress,
        // loginRequestSuccess: store.state.userState.loginRequestSuccess,
        // loginVerifySuccess: store.state.userState.loginVerifySuccess,
        // signUp: (countryCode, phoneNumber, successCallback, failCallback) {
        //   store.dispatch(loginRequestCall(countryCode, phoneNumber, successCallback, failCallback));
        // },
        // verify: (countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback) {
        //   store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback));
        // }
        );
  }

  bool operator ==(other) {
    if (other is SplashViewModel) {
      if (privateKey == other.privateKey &&
          jwtToken == other.jwtToken &&
          isLoggedOut == other.isLoggedOut) return true;
    }
    return false;
  }
}
