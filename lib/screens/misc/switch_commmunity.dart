import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/community.dart';
import 'package:paywise/models/views/switch_community.dart';
import 'package:paywise/widgets/bottombar.dart';
import 'package:paywise/widgets/community_card.dart';
import 'dart:core';
import 'package:paywise/widgets/main_scaffold.dart';

Widget scanQRButton(BuildContext context, Function switchCommunity) {
  return Container(
      width: 260.0,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          border:
              Border.all(color: Theme.of(context).primaryColor.withAlpha(14))),
      child: InkWell(
        onTap: () async {
          try {
            var json = await BarcodeScanner.scan();
            Map jsonMap = jsonDecode(json);
            switchCommunity(jsonMap['communityAddress']);
            Navigator.popUntil(context, ModalRoute.withName('/Cash'));
          } catch (e) {
            print('BarcodeScanner scan error');
          }
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(I18n.of(context).sqan_qr_code,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                    mini: true,
                    backgroundColor: const Color(0xFF292929),
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/scan.png',
                      width: 20.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: null),
              )
            ]),
      ));
}

class SwitchCommunityScreen extends StatefulWidget {
  SwitchCommunityScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SwitchCommunityScreenState createState() => _SwitchCommunityScreenState();
}

class _SwitchCommunityScreenState extends State<SwitchCommunityScreen> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final assetIdController = TextEditingController(text: "");
  bool isValid = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SwitchCommunityViewModel>(
        converter: SwitchCommunityViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).switch_community,
            titleFontSize: 15,
            footer: bottomBar(context),
            withPadding: false,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    viewModel.currentCommunity.token != null
                        ? CommunityCardScreen(
                            community: viewModel.currentCommunity,
                            switchCommunity: viewModel.switchCommunity,
                          )
                        : SizedBox.shrink(),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, right: 40, left: 40),
                        child:
                            scanQRButton(context, viewModel.switchCommunity)),
                    ...viewModel.communities.values
                        .where((Community community) =>
                            community.address !=
                                viewModel.currentCommunity.address &&
                            community.token != null)
                        .map((Community community) {
                      return CommunityCardScreen(
                          community: community,
                          switchCommunity: viewModel.switchCommunity);
                    }).toList()
                  ],
                ),
              ),
            ],
          );
        });
  }
}
