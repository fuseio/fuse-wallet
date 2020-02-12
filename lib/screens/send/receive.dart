import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/copy.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'dart:core';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReceiveScreenState createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        converter: CashWalletViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).receive,
            titleFontSize: 15,
            footer: bottomBar(context),
            withPadding: false,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                      child: Text(I18n.of(context).scan_to_receive,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(height: 60.0),
                    Center(
                      child: Container(
                          width: 200,
                          child: new QrImage(
                            data: 'fuse:${viewModel.walletAddress}',
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: 220,
                      child: new Text(formatAddress(viewModel.walletAddress),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: 250,
                      child: Opacity(
                        opacity: 0.5,
                        child: Center(
                          child: CopyToClipboard(
                            textColor: Color(0xFF0091ff),
                            content: viewModel.walletAddress,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    Center(
                        child: PrimaryButton(
                      fontSize: 15,
                      labelFontWeight: FontWeight.normal,
                      width: 160,
                      label: I18n.of(context).share_button,
                      onPressed: () async {
                        Share.share(viewModel.walletAddress);
                      },
                    ))
                  ],
                ),
              ),
            ],
          );
        });
  }
}
