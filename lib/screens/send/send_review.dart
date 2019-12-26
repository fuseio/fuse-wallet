import 'package:flutter/material.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/utils/phone.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendReviewScreen extends StatefulWidget {
  @override
  _SendReviewScreenState createState() => _SendReviewScreenState();
}

class _SendReviewScreenState extends State<SendReviewScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "0";
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
  }

  void send(SendAmountViewModel viewModel, SendAmountArguments args,
      String amountText) {
    if (args.phoneNumber != null) {
      viewModel.sendToContact(
          formatPhoneNumber(args.phoneNumber, viewModel.myCountryCode),
          num.parse(amountText));
    } else {
      viewModel.sendToAccountAddress(
          args.accountAddress, num.parse(amountText));
    }
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

          if (double.parse(amountText) > 0) {
            controller.forward();
          } else {
            controller.reverse();
          }

          //if (double.parse(viewModel.balance) < double.parse(amountText)) {
          //amountText = viewModel.balance;
          //}
          //viewModel.sendAmount(double.parse(amountText));
        }

        return MainScaffold(
            withPadding: true,
            title: "Review transfer",
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text("Amount",
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
                              padding: EdgeInsets.only(top: 20.0, bottom: 30),
                              child: Text("\$" + amountText,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding:  EdgeInsets.only(bottom: 30),
                      child: Text("To:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),)
                      
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 50.0, bottom: 50, left: 40, right: 40),
                  color: Color(0xFFF5F5F5),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(
                      right: 20),
                      child: CircleAvatar(
                            backgroundColor: Color(0xFFE0E0E0),
                            radius: 25,
                            backgroundImage:
                                new AssetImage('assets/images/anom.png'),
                          ),)
                          ,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
Text(
                                  "Maria Kosmin",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Address: 0x7c06…bF56f2",
                                  style: TextStyle(fontSize: 16, color: Color(0xFF777777)),
                                )
                          ],)
                          
                        ],
                      )
                      
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(
                      top: 20),
                      child:
                Text("Fee: covered by fuse",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)))
                
              ]))
            ],
            footer: Center(
                child: PrimaryButton(
              label: "Send",
              onPressed: () {
                send(viewModel, args, amountText);
                Navigator.popAndPushNamed(context, '/Cash');
              },
              preload: false,
              width: 300,
            )));
      },
    );
  }
}

class SendAmountArguments {
  final String name;
  final String phoneNumber;
  final String accountAddress;

  SendAmountArguments({this.name, this.phoneNumber, this.accountAddress});
}

class SendAmountViewModel {
  final String myCountryCode;
  final Function(String, num) sendToContact;
  final Function(String, num) sendToAccountAddress;

  SendAmountViewModel(
      {this.myCountryCode, this.sendToContact, this.sendToAccountAddress});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    return SendAmountViewModel(
        myCountryCode: store.state.userState.countryCode,
        sendToContact: (String phoneNumber, num amount) {
          //store.dispatch(sendTokenToContactCall(phoneNumber, amount));
        },
        sendToAccountAddress: (String recieverAddress, num amount) {
          //store.dispatch(sendTokenCall(recieverAddress, amount));
        });
  }
}
