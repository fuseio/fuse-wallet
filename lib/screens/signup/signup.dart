import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:curadai/generated/i18n.dart';
import 'package:curadai/models/app_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:curadai/utils/phone.dart';
import 'package:curadai/widgets/main_scaffold.dart';
import 'package:curadai/widgets/primary_button.dart';
import 'package:curadai/widgets/signup_dialog.dart';
import 'package:curadai/models/views/onboard.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullNameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final phoneController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  bool isvalidPhone = true;
  CountryCode countryCode = CountryCode(dialCode: '‎+1', code: 'US');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_updateCountryCode);
    super.initState();
  }

  _updateCountryCode(_) {
    Locale myLocale = Localizations.localeOf(context);
    if (myLocale.countryCode != null) {
      Map localeData = codes.firstWhere(
          (Map code) => code['code'] == myLocale.countryCode,
          orElse: () => null);
      if (mounted && localeData != null) {
        setState(() {
          countryCode = CountryCode(
              dialCode: localeData['dial_code'], code: localeData['code']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        withPadding: true,
        title: I18n.of(context).sign_up,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                  child: Text(I18n.of(context).enter_phone_number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                Container(
                  width: 180.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFeaeaea),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SignupDialog();
                              });
                          Segment.track(
                              eventName:
                                  "Wallet: opened modal - why do we need this");
                        },
                        child: Center(
                          child: Text(
                            I18n.of(context).why_do_we_need_this,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
        footer: Padding(
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
                              color: isvalidPhone
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1)
                                  : Colors.red,
                              width: 2.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: CountryCodePicker(
                            onChanged: (_countryCode) {
                              setState(() {
                                countryCode = _countryCode;
                              });
                              Segment.track(
                                  eventName: 'Wallet: country code selected',
                                  properties: Map.from({
                                    'Dial code': _countryCode.dialCode,
                                    'County code': _countryCode.code,
                                  }));
                            },
                            searchStyle: TextStyle(fontSize: 18),
                            showFlag: true,
                            initialSelection: countryCode.code,
                            showCountryOnly: false,
                            textStyle: TextStyle(fontSize: 18),
                            alignLeft: false,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                        Container(
                          height: 35,
                          width: 1,
                          color: Color(0xFFc1c1c1),
                          margin: EdgeInsets.only(left: 5.0, right: 5.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            validator: (String value) => value.isEmpty
                                ? "Please enter mobile number"
                                : null,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                hintText: I18n.of(context).phoneNumber,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
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
                            label: I18n.of(context).next_button,
                            fontSize: 16,
                            labelFontWeight: FontWeight.normal,
                            onPressed: () async {
                              try {
                                bool isValid = await PhoneService.isValid(
                                    phoneController.text, countryCode.code);
                                if (isValid) {
                                  viewModel.signUp(
                                      countryCode, phoneController.text);
                                } else {
                                  setState(() {
                                    isvalidPhone = false;
                                  });
                                }
                              } on PlatformException catch (e) {
                                print(e);
                                setState(() {
                                  isvalidPhone = false;
                                });
                              }
                            },
                            preload: viewModel.isLoginRequest,
                          ),
                        ))
              ],
            ),
          ),
        ));
  }
}
