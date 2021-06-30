import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';
import 'package:fusecash/features/onboard/dialogs/signup.dart';
import 'package:fusecash/redux/viewsmodels/onboard.dart';
import 'package:fusecash/features/shared/widgets/snackbars.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController(text: "");
  final phoneController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  CountryCode countryCode = CountryCode(dialCode: '‎+1', code: 'US');

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(_updateCountryCode);
    super.initState();
  }

  _updateCountryCode(_) {
    Locale myLocale = Localizations.localeOf(context);
    if (myLocale.countryCode != null) {
      Map localeData = codes.firstWhere(
        (Map code) => code['code'] == myLocale.countryCode,
      );
      if (mounted &&
          localeData.containsKey('dial_code') &&
          localeData.containsKey('code')) {
        setState(() {
          countryCode = CountryCode(
            dialCode: localeData['dial_code'],
            code: localeData['code'],
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).sign_up,
      body: InkWell(
        onTap: () {
          WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        },
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      I10n.of(context).enter_phone_number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Theme.of(context).canvasColor,
                        highlightColor: Theme.of(context).canvasColor,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => SignUpDialog(),
                          );
                        },
                        child: Center(
                          child: Text(
                            I10n.of(context).why_do_we_need_this,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 280,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: CountryCodePicker(
                                      onChanged: (_countryCode) {
                                        setState(() {
                                          countryCode = _countryCode;
                                        });
                                      },
                                      searchDecoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        fillColor:
                                            Theme.of(context).canvasColor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ),
                                      searchStyle: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      showFlag: true,
                                      initialSelection: countryCode.code,
                                      showCountryOnly: false,
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      alignLeft: false,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                  Container(
                                    height: 35,
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    margin:
                                        EdgeInsets.only(left: 5.0, right: 5.0),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,
                                      autofocus: true,
                                      validator: (String? value) =>
                                          value!.isEmpty
                                              ? "Please enter mobile number"
                                              : null,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 10,
                                        ),
                                        hintText: I10n.of(context).phoneNumber,
                                        border: InputBorder.none,
                                        fillColor:
                                            Theme.of(context).backgroundColor,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          StoreConnector<AppState, OnboardViewModel>(
                            distinct: true,
                            converter: OnboardViewModel.fromStore,
                            builder: (_, viewModel) => Center(
                              child: PrimaryButton(
                                label: I10n.of(context).next_button,
                                preload: viewModel.isLoginRequest,
                                onPressed: () {
                                  final String phoneNumber =
                                      '${countryCode.dialCode}${phoneController.text}';
                                  phoneNumberUtil.parse(phoneNumber).then(
                                      (value) {
                                    viewModel.signUp(
                                      countryCode,
                                      value,
                                      () {
                                        showErrorSnack(
                                          message:
                                              I10n.of(context).invalid_number,
                                          title: I10n.of(context)
                                              .something_went_wrong,
                                          context: context,
                                          margin: EdgeInsets.only(
                                            top: 8,
                                            right: 8,
                                            left: 8,
                                            bottom: 120,
                                          ),
                                        );
                                      },
                                    );
                                  }, onError: (e) {
                                    showErrorSnack(
                                      message: I10n.of(context).invalid_number,
                                      title:
                                          I10n.of(context).something_went_wrong,
                                      context: context,
                                      margin: EdgeInsets.only(
                                        top: 8,
                                        right: 8,
                                        left: 8,
                                        bottom: 120,
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
