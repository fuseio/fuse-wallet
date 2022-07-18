import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:fusecash/features/shared/bottom_sheets/wrong_phone_number.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/verify.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class VerifyPhoneNumberPage extends StatefulWidget {
  final String? verificationId;
  const VerifyPhoneNumberPage({this.verificationId, Key? key})
      : super(key: key);
  @override
  State<VerifyPhoneNumberPage> createState() => _VerifyPhoneNumberPageState();
}

class _VerifyPhoneNumberPageState extends SfWidget<VerifyPhoneNumberPage> {
  String autoCode = "";
  TextEditingController codeController = TextEditingController(text: '');
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).sign_up,
      body: StoreConnector<AppState, VerifyOnboardViewModel>(
        distinct: true,
        converter: VerifyOnboardViewModel.fromStore,
        onInitialBuild: (viewModel) {
          if (viewModel.credentials != null &&
              viewModel.verificationId != null) {
            autoCode = viewModel.credentials?.smsCode ?? "";
            setState(() {
              isPreloading = true;
            });
            viewModel.verify(
              autoCode,
              () {
                setState(() {
                  isPreloading = false;
                });
              },
              (error) {
                setState(() {
                  isPreloading = false;
                });
                if (error
                    .contains('This account is registered to another phone')) {
                  const WrongPhoneNumberBottomSheet().showSheet(context);
                } else {
                  super.throwAlert(
                    context,
                    error ?? I10n.of(context).something_went_wrong,
                    type: AlertsTypeEnum.ERROR,
                  );
                }
              },
            );
          }
        },
        builder: (_, viewModel) {
          return ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${I10n.of(context).we_just_sent}${viewModel.phoneNumber} \n",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                          ),
                    ),
                    Text(
                      I10n.of(context).enter_verification_code,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  top: 10.0,
                  right: 0.0,
                ),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: 280,
                        child: PinCodeTextField(
                          length: 6,
                          backgroundColor: Theme.of(context).canvasColor,
                          showCursor: false,
                          appContext: context,
                          enableActiveFill: true,
                          enablePinAutofill: false,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          animationType: AnimationType.fade,
                          controller: codeController,
                          autoFocus: true,
                          pinTheme: PinTheme(
                            borderWidth: 4,
                            borderRadius: BorderRadius.circular(20),
                            shape: PinCodeFieldShape.underline,
                            inactiveColor: const Color(0xFFDDDDDD),
                            inactiveFillColor: Theme.of(context).canvasColor,
                            selectedFillColor: Theme.of(context).canvasColor,
                            disabledColor: Theme.of(context).canvasColor,
                            selectedColor:
                                Theme.of(context).colorScheme.onSurface,
                            activeColor:
                                Theme.of(context).colorScheme.onSurface,
                            activeFillColor: Theme.of(context).canvasColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Center(
                      child: GradientButton(
                        text: I10n.of(context).next_button,
                        width: MediaQuery.of(context).size.width * .9,
                        textColor: Theme.of(context).canvasColor,
                        preload: isPreloading,
                        disabled: isPreloading,
                        onPressed: () {
                          formKey.currentState!.validate();
                          if (currentText.length != 6) {
                          } else {
                            setState(() {
                              isPreloading = true;
                            });
                            viewModel.verify(
                              codeController.text,
                              () {
                                setState(() {
                                  isPreloading = false;
                                });
                              },
                              (dynamic error) {
                                setState(() {
                                  isPreloading = false;
                                });
                                if (error.contains(
                                    'This account is registered to another phone')) {
                                  const WrongPhoneNumberBottomSheet()
                                      .showSheet(context);
                                } else {
                                  super.throwAlert(
                                    context,
                                    error ??
                                        I10n.of(context).something_went_wrong,
                                    type: AlertsTypeEnum.ERROR,
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          I10n.of(context).didnt_get_message,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(right: 10),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            I10n.of(context).resend_code,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
