import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
// import 'package:fusewallet/redux/state/app_state.dart';
import 'package:fusecash/widgets/copy.dart';
import 'dart:core';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReceiveScreenState createState() => _ReceiveScreenState();
}

String sendAddress = "";

class _ReceiveScreenState extends State<ReceiveScreen> {

  @override
  void initState() {
    super.initState();

    //startNFC();
  }

  @override
  Widget build(BuildContext _context) {

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Receive',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
            ),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Theme.of(context).canvasColor,
          ),
          SliverFillRemaining(
              child: new StoreConnector<AppState, CashWalletViewModel>(
            converter: (store) {
              return CashWalletViewModel.fromStore(store);
            },
            builder: (_, viewModel) {
              return Builder(
                  builder: (context) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                                top: 0.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Text(
                                      'Scan the QR code to receive money',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 0),
                                  width: 220,
                                  child: new QrImage(
                                          data: 'fuse:${viewModel.walletAddress}',
                                          //onError: (ex) {
                                          //  print("[QR] ERROR - $ex");
                                          //},
                                        )
                                ),
                              ),
                              Container(
                                width: 220,
                                padding: EdgeInsets.only(top: 20),
                                child: new Text(viewModel.walletAddress,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                width: 250,
                                padding: EdgeInsets.only(top: 20),
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Center(
                                    child: CopyToClipboard(
                                      content: viewModel.walletAddress,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ));
            },
          )),
        ],
      ),
    );
  }
}
