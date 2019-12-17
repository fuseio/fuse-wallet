import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
// import 'package:fusewallet/services/wallet_service.dart';
// import 'package:fusewallet/widgets/widgets.dart';
// import 'package:fusewallet/logic/common.dart';
// import 'package:fusewallet/logic/globals.dart' as globals;
// import 'package:fusewallet/generated/i18n.dart';
// import 'package:fusewallet/modals/views/wallet_viewmodel.dart';
// import 'package:fusewallet/redux/state/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/models/app_state.dart';


Future scan() async {
  try {
    // openPage(globals.scaffoldKey.currentContext, new SendAddressScreen());
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
    } else {}
  } on FormatException {} catch (e) {}
}

class SendAddressScreen extends StatefulWidget {

  @override
  _SendAddressScreenState createState() => _SendAddressScreenState();
}

class _SendAddressScreenState extends State<SendAddressScreen> {
  GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Theme.of(context).canvasColor,
          ),
          backgroundColor: const Color(0xFFF8F8F8),
          body: SendAddressForm());
  }
}

class SendAddressForm extends StatefulWidget {
  SendAddressForm({this.address});

  final String address;

  @override
  _SendAddressFormState createState() => _SendAddressFormState();
}

class _SendAddressFormState extends State<SendAddressForm> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(converter: (store) {
      return CashWalletViewModel.fromStore(store);
    }, builder: (_, viewModel) {

      final addressController = TextEditingController(text: '');

      Future openCameraScan(openPage) async {
        // viewModel.sendAddress(await BarcodeScanner.scan());
        // if (openPage) {
        //   openPage(globals.scaffoldKey.currentContext, new SendAddressScreen());
        // }
      }

      return Container(
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
                child: Text('Send to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      TextFormField(
                        controller: addressController,
                        autofocus: false,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              right: 60, left: 30, top: 18, bottom: 18),
                          labelText: 'Address',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Address is required';
                          }
                        },
                      ),
                      Padding(
                        child: InkWell(
                          child: Image.asset('images/scan.png', width: 28.0),
                          onTap: () {
                            openCameraScan(false);
                          },
                        ),
                        padding: EdgeInsets.only(bottom: 14, right: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Amount",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text('10',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 60,
                                  fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 11.0, left: 5),
                          child: Text(viewModel.token.symbol,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
        const SizedBox(height: 30.0),
        Center(
            child: PrimaryButton(
          label: "SEND",
          onPressed: () async {
            // viewModel.sendAddress(addressController.text);
            // viewModel.sendTransaction(context);
          },
          // preload: viewModel.isLoading,
          width: 300,
        )),
        const SizedBox(height: 40.0),
      ]));
    });
  }
}
