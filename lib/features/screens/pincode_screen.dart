import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatefulWidget {
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final pincodeController = TextEditingController(text: "");
  String currentText = "";
  Flushbar flush;
  final formKey = GlobalKey<FormState>();
  // StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    Segment.screen(screenName: '/pincode-screen');
    super.initState();
  }

  @override
  void dispose() {
    // errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ExtendedNavigator.root.pop<bool>(false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/images/fusecash.svg',
            width: 143,
            height: 28,
          ),
        ),
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            I10n.of(context).enter_pincode,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StoreConnector<AppState, LockScreenViewModel>(
                            converter: LockScreenViewModel.fromStore,
                            builder: (_, viewModel) => Form(
                              key: formKey,
                              child: Container(
                                width: 250,
                                child: PinCodeTextField(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  length: 6,
                                  showCursor: false,
                                  autoFocus: true,
                                  appContext: context,
                                  enableActiveFill: true,
                                  obscureText: true,
                                  enablePinAutofill: false,
                                  keyboardType: TextInputType.phone,
                                  animationType: AnimationType.fade,
                                  controller: pincodeController,
                                  // errorAnimationController: errorController,
                                  validator: (String value) =>
                                      value.length != 6 &&
                                              value == viewModel.pincode
                                          ? I10n.of(context).invalid_pincode
                                          : null,
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(context).canvasColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  pinTheme: PinTheme(
                                    borderRadius: BorderRadius.circular(5),
                                    borderWidth: 4,
                                    fieldWidth: 35,
                                    shape: PinCodeFieldShape.underline,
                                    inactiveColor:
                                        Theme.of(context).canvasColor,
                                    inactiveFillColor:
                                        Theme.of(context).primaryColor,
                                    selectedFillColor:
                                        Theme.of(context).primaryColor,
                                    disabledColor:
                                        Theme.of(context).primaryColor,
                                    selectedColor:
                                        Theme.of(context).canvasColor,
                                    activeColor: Theme.of(context).canvasColor,
                                    activeFillColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  onCompleted: (value) {
                                    if (viewModel.pincode == value) {
                                      ExtendedNavigator.root
                                          .replace(Routes.homeScreen);
                                      pincodeController.clear();
                                    } else {
                                      flush = Flushbar<bool>(
                                        title: I10n.of(context).invalid_pincode,
                                        message: I10n.of(context)
                                            .auth_failed_message,
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        mainButton: FlatButton(
                                          onPressed: () async {
                                            flush.dismiss(true);
                                          },
                                          child: Text(
                                            I10n.of(context).try_again,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ),
                                      )..show(context).then(
                                          (result) async {
                                            if (result) {
                                              pincodeController.clear();
                                              WidgetsBinding.instance
                                                  .focusManager.primaryFocus
                                                  ?.previousFocus();
                                            }
                                          },
                                        );
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      currentText = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
