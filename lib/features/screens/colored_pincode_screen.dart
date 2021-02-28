import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/widgets/snackbars.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class ColoredPincodeScreen extends StatefulWidget {
  @override
  _ColoredPincodeScreenState createState() => _ColoredPincodeScreenState();
}

class _ColoredPincodeScreenState extends State<ColoredPincodeScreen> {
  final pincodeController = TextEditingController(text: "");
  String lastPincode;
  bool isRetype = false;
  bool showError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pincodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/pincode-screen');
    return WillPopScope(
      onWillPop: () async {
        ExtendedNavigator.root.pop<bool>(false);
        return false;
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.height * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/splash.png',
                            width: 71,
                            height: 61,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I18n.of(context).enter_pincode,
                          style: TextStyle(fontSize: 25),
                        ),
                        Theme(
                          data: ThemeData(
                              hintColor:
                                  Theme.of(context).scaffoldBackgroundColor),
                          child: StoreConnector<AppState, LockScreenViewModel>(
                            converter: LockScreenViewModel.fromStore,
                            builder: (_, viewModel) => Container(
                              width: 250,
                              child: PinInputTextField(
                                pinLength: 6,
                                decoration: UnderlineDecoration(
                                  textStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                  hintTextStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  colorBuilder: FixedColorListBuilder(
                                    List<Color>.filled(
                                      6,
                                      Color(0xFF575757),
                                    ),
                                  ),
                                  obscureStyle: ObscureStyle(
                                    isTextObscure: true,
                                    obscureText: '●',
                                  ),
                                ),
                                controller: pincodeController,
                                autoFocus: true,
                                onChanged: (value) {
                                  if (value.length == 6) {
                                    if (value == viewModel.pincode) {
                                      ExtendedNavigator.root
                                          .replace(Routes.homeScreen);
                                    } else {
                                      if (!showError) {
                                        showErrorSnack(
                                          message:
                                              I18n.of(context).invalid_pincode,
                                          title: I18n.of(context).oops,
                                          duration: Duration(seconds: 3),
                                          context: context,
                                        );
                                      }
                                      setState(() {
                                        showError = true;
                                      });
                                      Future.delayed(
                                        Duration(milliseconds: 2500),
                                        () {
                                          setState(() {
                                            showError = false;
                                          });
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
