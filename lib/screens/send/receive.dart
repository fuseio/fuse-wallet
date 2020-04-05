import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/utils/format.dart';
import 'package:supervecina/widgets/copy.dart';
import 'package:supervecina/widgets/main_scaffold.dart';
import 'package:supervecina/widgets/primary_button.dart';
import 'dart:core';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

class ReceiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ReceiveModel>(
        distinct: true,
        onInit: (store) {
          Segment.screen(screenName: '/receive-screen');
        },
        converter: _ReceiveModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).receive,
            automaticallyImplyLeading: false,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0, top: 20),
                      child: Text(I18n.of(context).scan_to_receive,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                              width: 200,
                              child: new QrImage(
                                data: 'fuse:${viewModel.walletAddress}',
                              )),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          width: 220,
                          child: new Text(
                              formatAddress(viewModel.walletAddress),
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
                        ),
                        const SizedBox(height: 30.0),
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
                      ],
                    ),
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

class _ReceiveModel extends Equatable {
  final String walletAddress;
  _ReceiveModel({this.walletAddress});

  static _ReceiveModel fromStore(Store<AppState> store) {
    return _ReceiveModel(
      walletAddress: store.state.cashWalletState.walletAddress,
    );
  }

  @override
  List<Object> get props => [walletAddress];
}
