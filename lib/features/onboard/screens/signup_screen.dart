import 'package:flutter/material.dart';

import 'package:carrier_info/carrier_info.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:phone_number/phone_number.dart';

import 'package:fusecash/features/onboard/dialogs/signup.dart';
import 'package:fusecash/features/shared/bottom_sheets/wrong_phone_number.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

typedef SignUp = void Function(
  CountryCode,
  PhoneNumber,
  Function onSuccess,
  Function(dynamic error) onError,
);

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends SfWidget<SignUpPage> {
  final fullNameController = TextEditingController(text: "");
  final phoneController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  CountryCode selectedCountryCode = CountryCode(dialCode: '+1', code: 'US');
  bool isPreloading = false;

  @override
  onInitApp() async {
    _updateCountryCode();
  }

  void _updateCountryCode() async {
    try {
      String? currentCountryCode = await CarrierInfo.isoCountryCode;
      if (currentCountryCode != null) {
        Map localeData = codes.firstWhere(
          (Map code) =>
              code['code'].toString().toLowerCase() ==
              currentCountryCode.toLowerCase(),
        );
        if (mounted &&
            localeData.containsKey('dial_code') &&
            localeData.containsKey('code')) {
          setState(() {
            selectedCountryCode = CountryCode(
              dialCode: localeData['dial_code'],
              code: localeData['code'],
            );
          });
        }
      }
    } catch (e) {
      log.error('Failed to deduce sim country code: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).sign_up,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  I10n.of(context).enter_phone_number,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  hoverColor: Theme.of(context).canvasColor,
                  splashColor: Theme.of(context).canvasColor,
                  focusColor: Theme.of(context).canvasColor,
                  highlightColor: Theme.of(context).canvasColor,
                  onTap: () {
                    const SignUpDialog().showSheet(context);
                  },
                  child: Text(
                    I10n.of(context).why_do_we_need_this,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 30,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 280,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            CountryCodePicker(
                              onChanged: (countryCode) {
                                setState(() {
                                  selectedCountryCode = countryCode;
                                });
                              },
                              searchDecoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                fillColor: Theme.of(context).canvasColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              dialogSize: Size(
                                MediaQuery.of(context).size.width * .9,
                                MediaQuery.of(context).size.height * 0.85,
                              ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                              showFlag: true,
                              initialSelection: selectedCountryCode.code,
                              showCountryOnly: false,
                              dialogTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 18,
                                  ),
                              alignLeft: false,
                              padding: EdgeInsets.zero,
                            ),
                            const Icon(Icons.arrow_drop_down),
                            Container(
                              height: 35,
                              width: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                              margin: const EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                validator: (String? value) => value!.isEmpty
                                    ? "Please enter mobile number"
                                    : null,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 18,
                                    ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10,
                                  ),
                                  hintText: I10n.of(context).phoneNumber,
                                  border: InputBorder.none,
                                  fillColor: Theme.of(context).backgroundColor,
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      StoreConnector<AppState, SignUp>(
                        distinct: true,
                        converter: (store) => (
                          CountryCode countryCode,
                          PhoneNumber phoneNumber,
                          Function onSuccess,
                          dynamic Function(dynamic) onError,
                        ) =>
                            store.dispatch(
                              loginHandler(
                                countryCode,
                                phoneNumber,
                                onSuccess,
                                onError,
                              ),
                            ),
                        builder: (_, signUp) => GradientButton(
                          text: I10n.of(context).next_button,
                          width: MediaQuery.of(context).size.width * .9,
                          textColor: Theme.of(context).canvasColor,
                          preload: isPreloading,
                          disabled: isPreloading,
                          onPressed: () async {
                            final String phoneNumber =
                                '${selectedCountryCode.dialCode}${phoneController.text}';
                            setState(() {
                              isPreloading = true;
                            });
                            try {
                              PhoneNumber value = await phoneNumberUtil.parse(
                                phoneNumber,
                              );
                              signUp(
                                selectedCountryCode,
                                value,
                                () {
                                  log.info('sign up success');
                                },
                                (error) {
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
                                      error ?? I10n.of(context).invalid_number,
                                      duration: const Duration(
                                        seconds: 5,
                                      ),
                                      type: AlertsTypeEnum.ERROR,
                                    );
                                  }
                                },
                              );
                            } catch (e, s) {
                              log.info(
                                'error',
                                error: e,
                                stackTrace: s,
                              );
                              setState(() {
                                isPreloading = false;
                              });
                              super.throwAlert(
                                context,
                                I10n.of(context).invalid_number,
                                type: AlertsTypeEnum.ERROR,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
