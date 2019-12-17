import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:math';
import 'package:barcode_scan/barcode_scan.dart';


class CashHeader extends StatelessWidget {
  CashHeader();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        converter: (Store<AppState> store) {
      return CashWalletViewModel.fromStore(store);
    },
    builder: (_, viewModel) {
      return Container(
        height: 260.0,
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 30.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark,
              ],
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20),
            child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(
                  'assets/images/menu.png',
                  width: 18,
                ))
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: new RichText(
                  text: new TextSpan(
                    style: Theme.of(context).textTheme.title,
                    children: <TextSpan>[
                      new TextSpan(
                          text: I18n.of(context).hi,
                          style: TextStyle(
                              fontSize: 42,
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                      new TextSpan(
                          text: ' ' + viewModel.firstName(),
                          style: TextStyle(
                              fontSize: 42,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(bottom: 0.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.up,
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          child: Text(I18n.of(context).balance,
                              style: TextStyle(
                                  color: Colors.black.withAlpha(150),
                                  fontSize: 14.0)),
                          padding: EdgeInsets.only(bottom: 6.0),
                        ),
                        new RichText(
                          text: new TextSpan(
                            style: Theme.of(context).textTheme.title,
                            children: 
                            (viewModel.tokenBalance == null || viewModel.token == null) 
                            ? <TextSpan>[new TextSpan(
                                  text: 'Loading',
                                  style: new TextStyle(
                                      fontSize: 42,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))]
                            : <TextSpan>[
                                new TextSpan(
                                  text: (viewModel.tokenBalance / BigInt.from(pow(10, viewModel.token.decimals))).toString(),
                                  style: new TextStyle(
                                      fontSize: 42,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              new TextSpan(
                                  text:
                                      ' ' + viewModel.token?.symbol.toString(),
                                  style: new TextStyle(
                                      fontSize: 42,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      height: 0.0)),
                            ],
                          ),
                        )
                      ],
                    ),
                    new Container(
                      child: new FloatingActionButton(
                          backgroundColor: const Color(0xFF292929),
                          elevation: 0,
                          child: Image.asset(
                            'assets/images/scan.png',
                            width: 25.0,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            dynamic r = await BarcodeScanner.scan();
                            print(r);
          //                           Future openCameraScan() async {
          // viewModel.sendAddress(await BarcodeScanner.scan());
          // openPage(context, new SendAmountPage());
        // }
                            // Navigator.pushNamed(context, '/SendQR');
                          }),
                      width: 50.0,
                      height: 50.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
