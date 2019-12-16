import 'package:flutter/material.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendAmountScreen extends StatefulWidget {
  @override
  _SendAmountScreenState createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen> {
  String amountText = "0";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = ModalRoute.of(context).settings.arguments;

    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: (store) {
        return SendAmountViewModel.fromStore(store);
      },
      builder: (_, viewModel) {
        _onKeyPress(VirtualKeyboardKey key) {
          if (key.keyType == VirtualKeyboardKeyType.String) {
            if (amountText == "0") {
              amountText = "";
            }
            amountText = amountText + key.text;
          } else if (key.keyType == VirtualKeyboardKeyType.Action) {
            switch (key.action) {
              case VirtualKeyboardKeyAction.Backspace:
                if (amountText.length == 0) return;
                amountText = amountText.substring(0, amountText.length - 1);
                break;
              case VirtualKeyboardKeyAction.Return:
                amountText = amountText + '\n';
                break;
              case VirtualKeyboardKeyAction.Space:
                amountText = amountText + key.text;
                break;
              default:
            }
          }
          setState(() {});
          if (amountText == "") {
            amountText = "0";
          }
          //if (double.parse(viewModel.balance) < double.parse(amountText)) {
          //amountText = viewModel.balance;
          //}
          //viewModel.sendAmount(double.parse(amountText));
        }

        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              backgroundColor: Theme.of(context).canvasColor,
            ),
            backgroundColor: const Color(0xFFF8F8F8),
            body: Container(
                child: Column(children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      //color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Send",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text("Enter amount to send",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),
                    ),
                    Container(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(amountText,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w900)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 30.0),
                            child: Text("\$",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              VirtualKeyboard(
                  height: 300,
                  fontSize: 28,
                  textColor: Theme.of(context).primaryColor,
                  type: VirtualKeyboardType.Numeric,
                  onKeyPress: _onKeyPress),
              const SizedBox(height: 30.0),
              Center(
                  child: PrimaryButton(
                label: "NEXT",
                onPressed: () {
                  String formattedPhoneNumber = args.phoneNumber.replaceAll(new RegExp('(-| )'), '').replaceFirst(new RegExp('^0+'), '');
                  if (formattedPhoneNumber[0] == '+') {
                    formattedPhoneNumber = viewModel.myCountryCode + formattedPhoneNumber;
                  }
                  viewModel.sendTokens(formattedPhoneNumber, num.parse(amountText));
                  Navigator.popAndPushNamed(context, '/Cash');
                  //if (viewModel.walletState.sendAmount <= 0) {
                  //  Scaffold.of(context).showSnackBar(new SnackBar(
                  //    content: new Text("Please enter amount"),
                  //  ));
                  //} else {
                  //viewModel.sendAmount(double.parse(amountText));
                  //openPage(context, new SendAddressPage());
                  //}
                },
                preload: false,
                width: 300,
              )),
              const SizedBox(height: 40.0),
            ])));
      },
    );
  }
}

class SendAmountArguments {
  final String name;
  final String phoneNumber;

  SendAmountArguments(this.name, this.phoneNumber);
}

class SendAmountViewModel {
  final String myCountryCode;
  final Function(String, num) sendTokens;
  
  SendAmountViewModel({this.myCountryCode, this.sendTokens});
  
  static SendAmountViewModel fromStore(Store<AppState> store) {
    return SendAmountViewModel(
      myCountryCode: store.state.userState.countryCode,
      sendTokens: (String phoneNumber, num amount) {
        store.dispatch(sendTokenToContactCall(phoneNumber, amount));
    });
  }
}
