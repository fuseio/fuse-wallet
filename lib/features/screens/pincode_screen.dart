import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({Key? key}) : super(key: key);

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final pincodeController = TextEditingController(text: "");
  String currentText = "";
  late Flushbar flush;
  final formKey = GlobalKey<FormState>();
  int failCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     elevation: 0,
      //     shadowColor: Theme.of(context).colorScheme.primary,
      //     backgroundColor: Theme.of(context).colorScheme.primary,
      //     centerTitle: true,
      //     title: Text(
      //       Strings.appTitle,
      //       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 25,
      //             color: Theme.of(context).canvasColor,
      //           ),
      //     )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          I10n.of(context).enter_pincode,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).canvasColor,
                              ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StoreConnector<AppState, LockScreenViewModel>(
                          distinct: true,
                          converter: LockScreenViewModel.fromStore,
                          builder: (_, viewModel) => Form(
                            key: formKey,
                            child: SizedBox(
                              width: 250,
                              child: PinCodeTextField(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                length: 6,
                                showCursor: false,
                                autoFocus: true,
                                appContext: context,
                                enableActiveFill: true,
                                obscureText: true,
                                enablePinAutofill: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                                animationType: AnimationType.fade,
                                controller: pincodeController,
                                validator: (String? value) =>
                                    value!.length != 6 &&
                                            value == viewModel.pincode
                                        ? I10n.of(context).invalid_pincode
                                        : null,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                pinTheme: PinTheme(
                                  borderRadius: BorderRadius.circular(5),
                                  borderWidth: 4,
                                  fieldWidth: 35,
                                  shape: PinCodeFieldShape.underline,
                                  inactiveColor: Theme.of(context).canvasColor,
                                  inactiveFillColor:
                                      Theme.of(context).colorScheme.primary,
                                  selectedFillColor:
                                      Theme.of(context).colorScheme.primary,
                                  disabledColor:
                                      Theme.of(context).colorScheme.primary,
                                  selectedColor: Theme.of(context).canvasColor,
                                  activeColor: Theme.of(context).canvasColor,
                                  activeFillColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onCompleted: (value) {
                                  if (viewModel.pincode == value) {
                                    pincodeController.clear();
                                    context.router
                                        .replaceAll([const MainRoute()]);
                                  } else {
                                    setState(() {
                                      failCount += 1;
                                    });
                                    if (failCount == 5) {
                                      flush = Flushbar<bool>(
                                        title: I10n.of(context).invalid_pincode,
                                        message: I10n.of(context)
                                            .please_restore_your_wallet,
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        mainButton: TextButton(
                                          onPressed: () async {
                                            flush.dismiss(true);
                                          },
                                          child: Text(
                                            I10n.of(context).restore,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                        ),
                                      )..show(context).then(
                                          (result) async {
                                            if (result != null) {
                                              if (result == true) {
                                                context.navigateTo(
                                                    const RestoreWalletRoute());
                                              }
                                            }
                                          },
                                        );
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
                                        mainButton: TextButton(
                                          onPressed: () async {
                                            flush.dismiss(true);
                                          },
                                          child: Text(
                                            I10n.of(context).try_again,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                        ),
                                      )..show(context).then(
                                          (result) async {
                                            if (result != null) {
                                              if (result == true) {
                                                pincodeController.clear();
                                                WidgetsBinding.instance
                                                    .focusManager.primaryFocus
                                                    ?.previousFocus();
                                              }
                                            }
                                          },
                                        );
                                    }
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
    );
  }
}
