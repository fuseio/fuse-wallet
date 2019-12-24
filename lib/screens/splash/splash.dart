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
import 'dots_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  bool isPrimaryPreloading = false;
  bool isTransparentPreloading = false;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  bool isOpen = false;
  HouseController _slideController;
  ValueNotifier<double> notifier;
  int _previousPage;

  getPages() {
    return <Widget>[
      FlareActor(
        "assets/images/test2.flr",
        alignment: Alignment.center,
        fit: BoxFit.cover,
        animation: "Animations",
        controller: _slideController,
      ),
      Image.asset('assets/images/slide1.png', width: 160),
      Image.asset('assets/images/slide2.png', width: 160),
      Image.asset('assets/images/slide3.png', width: 160)
    ];
  }

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    notifier?.value = _pageController.page - _previousPage;
    print(_pageController.page);

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
                                    new PageView.builder(
                                      physics:
                                          new AlwaysScrollableScrollPhysics(),
                                      controller: _pageController,
                                      itemCount: 3,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return getPages()[index % 3];
                                      },
                                    ),
                                    new Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: new Container(
                                        padding: const EdgeInsets.all(20.0),
                                        child: new Center(
                                          child: new DotsIndicator(
                                            controller: _pageController,
                                            itemCount: 3,
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
                              SizedBox(
                                height: 180,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: PrimaryButton(
                                        label: viewModel.isLoggedOut
                                            ? "Login"
                                            : "Create a new wallet",
                                        onPressed: () {
                                          if (viewModel.isLoggedOut) {
                                            viewModel
                                                .initWeb3(viewModel.privateKey);
                                            Navigator.popUntil(context,
                                                ModalRoute.withName('/'));
                                            Navigator.pushNamed(
                                                context, '/Cash');
                                          } else {
                                            viewModel.createWallet(() {
                                              setState(() {
                                                isPrimaryPreloading = false;
                                              });
                                              Navigator.pushNamed(
                                                  context, '/Signup');
                                            });
                                            setState(() {
                                              isPrimaryPreloading = true;
                                            });
                                          }
                                        },
                                        preload: isPrimaryPreloading,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 30),
                                        child: TransparentButton(
                                            label: viewModel.isLoggedOut
                                                ? "Create a new wallet"
                                                : "Restore existing wallet",
                                            onPressed: () {
                                              if (viewModel.isLoggedOut) {
                                                viewModel.createWallet(() {
                                                  setState(() {
                                                    isTransparentPreloading = false;
                                                  });
                                                  Navigator.pushNamed(
                                                      context, '/Signup');
                                                });
                                                setState(() {
                                                  isTransparentPreloading = true;
                                                });
                                              }
                                            },
                                            preload: isTransparentPreloading))
                                  ],
                                ),
                              )
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
  final Function(VoidCallback successCallback) createWallet;

  SplashViewModel(
      {this.privateKey,
      this.jwtToken,
      this.isLoggedOut,
      this.initWeb3,
      this.createWallet});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
        privateKey: store.state.userState.privateKey,
        jwtToken: store.state.userState.jwtToken,
        isLoggedOut: store.state.userState.isLoggedOut,
        initWeb3: (privateKey) {
          store.dispatch(initWeb3Call(privateKey));
        },
        createWallet: (VoidCallback successCallback) {
          store.dispatch(createNewWalletCall(successCallback));
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
