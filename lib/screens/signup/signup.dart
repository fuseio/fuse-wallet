import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/widgets/country_code_picker/country_code_picker.dart';
import 'package:paywise/widgets/country_code_picker/country_code.dart';
import 'package:paywise/widgets/country_code_picker/country_codes.dart';
import 'package:paywise/widgets/main_scaffold.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:paywise/widgets/signup_dialog.dart';
import 'package:paywise/models/views/onboard.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullNameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final phoneController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  bool isPreloading = false;
  bool isvalidPhone = true;
  CountryCode countryCode = new CountryCode(dialCode: '‎‎+868', code: 'TT');

  @override
  void initState() {
    super.initState();
  }

  _updateCountryCode(Locale myLocale) {
    if (myLocale.countryCode != null) {
      Map localeData = codes.firstWhere((Map code) => code['code'] == myLocale.countryCode, orElse: () => null);
      if (mounted && localeData != null) {
        setState(() {
          countryCode = CountryCode(dialCode: localeData['dial_code']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    _updateCountryCode(myLocale);
    return MainScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        withPadding: true,
        title: I18n.of(context).sign_up,
        titleFontSize: 15,
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
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SignupDialog();
                              });
                          await FlutterSegment.track(eventName: "Wallet: opened modal - why do we need this");
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
        footer: new StoreConnector<AppState, OnboardViewModel>(
            converter: OnboardViewModel.fromStore,
            builder: (_, viewModel) {
              return Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 280,
                          decoration: new BoxDecoration(
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
                                    countryCode = _countryCode;
                                  },
                                  initialSelection: countryCode.code,
                                  favorite: [],
                                  showCountryOnly: false,
                                  showFlag: false,
                                  searchStyle: TextStyle(color: Colors.black),
                                  textStyle: const TextStyle(fontSize: 16),
                                  alignLeft: false,
                                ),
                                width: 50,
                              ),
                              Icon(Icons.arrow_drop_down),
                              new Container(
                                height: 35,
                                width: 1,
                                color: const Color(0xFFc1c1c1),
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Phone number',
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
                      const SizedBox(height: 40.0),
                      Center(
                        child: PrimaryButton(
                          label: I18n.of(context).next_button,
                          fontSize: 16,
                          labelFontWeight: FontWeight.normal,
                          onPressed: () {
                            if (phoneController.text.trim().isEmpty) {
                              setState(() {
                                isvalidPhone = false;
                              });
                            } else {
                              setState(() {
                                isPreloading = true;
                              });
                              viewModel.signUp(countryCode.dialCode.toString(),
                                  phoneController.text, () {
                                Navigator.pushNamed(context, '/Verify');
                                setState(() {
                                  isPreloading = false;
                                });
                              }, () {
                                setState(() {
                                  isPreloading = false;
                                  isvalidPhone = false;
                                });
                              });
                            }
                          },
                          preload: isPreloading,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
