import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:ceu_do_mapia/generated/i18n.dart';
import 'package:ceu_do_mapia/models/app_state.dart';
import 'package:ceu_do_mapia/models/views/backup.dart';
import 'package:ceu_do_mapia/screens/routes.gr.dart';
import 'package:ceu_do_mapia/widgets/snackbars.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class ColorsPincodeScreen extends StatefulWidget {
  @override
  _ColorsPincodeScreenState createState() => _ColorsPincodeScreenState();
}

class _ColorsPincodeScreenState extends State<ColorsPincodeScreen> {
  final pincodeController = TextEditingController(text: "");
  String lastPincode;
  bool isRetype = false;

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
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF4C7567),
              Color(0xFF74A391),
              Color(0xFF74A391)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
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
                    // Expanded(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       // Image.asset('assets/images/pincode_logo.png',
                    //       //     width: 71, height: 61),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I18n.of(context).enter_pincode,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Theme(
                            data: ThemeData(
                                hintColor:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: StoreConnector<AppState,
                                    LockScreenViewModel>(
                                converter: LockScreenViewModel.fromStore,
                                builder: (_, viewModel) => Container(
                                      width: 250,
                                      child: PinInputTextField(
                                        pinLength: 6,
                                        decoration: UnderlineDecoration(
                                            hintTextStyle: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            colorBuilder:
                                                FixedColorListBuilder([
                                              Color(0xFF575757),
                                              Color(0xFF575757),
                                              Color(0xFF575757),
                                              Color(0xFF575757),
                                              Color(0xFF575757),
                                              Color(0xFF575757),
                                            ]),
                                            obscureStyle: ObscureStyle(
                                                isTextObscure: true,
                                                obscureText: '●')),
                                        controller: pincodeController,
                                        autoFocus: true,
                                        onSubmit: (value) {
                                          if (value == viewModel.pincode) {
                                            ExtendedNavigator.root
                                                .replace(Routes.homePage);
                                          } else {
                                            transactionFailedSnack(
                                                I18n.of(context)
                                                    .invalid_pincode,
                                                title: I18n.of(context).oops,
                                                duration: Duration(seconds: 3),
                                                context: context);
                                          }
                                        },
                                      ),
                                    )))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
