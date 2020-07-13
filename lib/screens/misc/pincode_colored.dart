import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/backup.dart';
import 'package:fusecash/screens/routes.gr.dart';
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
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
            body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFB1FDC0),
              Color(0xFFE6FD99),
              Color(0xFFFEFD86)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset('assets/images/fuse_logo.svg',
                              width: 65, height: 65, color: Color(0xFF656565)),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Enter your Pin code',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: 280,
                      child: Theme(
                          data: ThemeData(
                              hintColor:
                                  Theme.of(context).scaffoldBackgroundColor),
                          child: StoreConnector<AppState, LockScreenViewModel>(
                              converter: LockScreenViewModel.fromStore,
                              builder: (_, viewModel) => PinInputTextField(
                                  pinLength: 6,
                                  decoration: UnderlineDecoration(
                                      color: Color(0xFF575757),
                                      enteredColor: Color(0xFF575757),
                                      obscureStyle: ObscureStyle(
                                          isTextObscure: true,
                                          obscureText: '●')),
                                  controller: pincodeController,
                                  autoFocus: true,
                                  textInputAction: TextInputAction.go,
                                  onSubmit: (value) {
                                    if (value == viewModel.pincode) {
                                      Router.navigator.pushNamedAndRemoveUntil(
                                          Router.cashHomeScreen,
                                          (Route<dynamic> route) => false);
                                    }
                                  }))),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
