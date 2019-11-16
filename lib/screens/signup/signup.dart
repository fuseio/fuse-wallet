import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/redux/state/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/transparent_button.dart';

import '../../common.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final firstNameController = TextEditingController(text: "");
  final lastNameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(title: "Sign up", children: <Widget>[
      Container(
        //color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
              child: Text(
                  "This wallet can store private information you can choose to share with service providers.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,)),
            ),
            
          ],
        ),
      ),
      new StoreConnector<AppState, SignInViewModel>(converter: (store) {
              return null; //SignInViewModel.fromStore(store);
            }, 
            builder: (_, viewModel) {
              return Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: firstNameController,
                        autofocus: false,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Full name is required';
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!isValidEmail(value.trim())) {
                            return 'Please enter valid email';
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: new BoxDecoration(
                            border: Border.all(
                                color: false//!viewModel.loginError
                                    ? Colors.black.withOpacity(0.1)
                                    : Colors.red,
                                width: 1.0),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(30.0))),
                        child: Row(
                          children: <Widget>[
                            CountryCodePicker(
                              padding: EdgeInsets.only(top: 0, left: 30, right: 0),
                              onChanged: (_countryCode) {
                                //countryCode = _countryCode;
                              },
                              initialSelection: 'IL',
                              favorite: [],
                              showCountryOnly: false,
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            Icon(Icons.arrow_drop_down),
                            new Container(
                              height: 35,
                              width: 1,
                              color: const Color(0xFFc1c1c1),
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            ),
                            Expanded(
                              child: TextFormField(
                                //controller: phoneController,
                                keyboardType: TextInputType.number,
                                autofocus: false,
                                style: const TextStyle(fontSize: 18),
                                decoration: const InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
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
                      const SizedBox(height: 16.0),
                      Center(
                        child: PrimaryButton(
                          label: "NEXT",
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: TransparentButton(
                            label: "Skip",
                            onPressed: () {
                              //Navigator.pushNamed(context, '/LevelSelector');
                              Navigator.pushNamed(context, '/Cash');
                            }),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: Padding(
                          child: Text(
                            "This data will be enrypted and stored only on this device secured storage.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),),
                          padding: const EdgeInsets.only(bottom: 30.0),
                        ) ,
                      )
                    ],
                  ),
                ),
              );
            })
          ]);
        }
      }
      
      class SignInViewModel {
}

