import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/widgets/community_card.dart';
import 'package:digitalrand/widgets/community_card_small.dart';
import 'package:digitalrand/widgets/main_scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SwitchCommunityScreen extends StatefulWidget {
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

  Widget scanQRButton(BuildContext context, Function switchCommunity) {
    return Container(
        width: 260.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        ),
        child: InkWell(
          onTap: () async {
            try {
              ScanResult scanResult = await BarcodeScanner.scan();
              Map jsonMap = jsonDecode(scanResult.rawContent);
              switchCommunity(jsonMap['communityAddress']);
              ExtendedNavigator.named('homeRouter').popUntilRoot();
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
                      heroTag: 'switch_scanner',
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _SwitchCommunityViewModel>(
        converter: _SwitchCommunityViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).switch_community,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 15, top: 20),
                        child: Text(I18n.of(context).current_community,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal))),
                    viewModel.tokens.containsKey(
                            viewModel.currentCommunity.homeTokenAddress)
                        ? CommunitySelectedCardScreen(
                            community: viewModel.currentCommunity,
                            token: viewModel.tokens[
                                viewModel.currentCommunity.homeTokenAddress],
                            switchCommunity: viewModel.switchCommunity,
                          )
                        : SizedBox.shrink(),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, right: 40, left: 40),
                          child:
                              scanQRButton(context, viewModel.switchCommunity)),
                    ),
                    viewModel.communities.length > 1
                        ? Container(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: Text(I18n.of(context).my_communities,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal)))
                        : SizedBox.shrink(),
                    ...viewModel.communities.values
                        .where((Community community) =>
                            community.address !=
                            viewModel.currentCommunity.address)
                        .map((Community community) {
                      return CommunityCardScreen(
                          token: viewModel.tokens[community.homeTokenAddress],
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

class _SwitchCommunityViewModel extends Equatable {
  final Map<String, Community> communities;
  final Map<String, Token> tokens;
  final Community currentCommunity;
  final Function(String) switchCommunity;

  _SwitchCommunityViewModel(
      {this.communities,
      this.switchCommunity,
      this.currentCommunity,
      this.tokens});

  static _SwitchCommunityViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    return _SwitchCommunityViewModel(
      tokens: store.state.cashWalletState.tokens,
      currentCommunity:
          store.state.cashWalletState.communities.containsKey(communityAddres)
              ? store.state.cashWalletState.communities[communityAddres]
              : Community.initial(),
      communities: store.state.cashWalletState.communities
        ..removeWhere((key, community) =>
            [null, ''].contains(community.address) ||
            [null, ''].contains(community.name)),
      switchCommunity: (String communityAddress) {
        store.dispatch(switchCommunityCall(communityAddress));
      },
    );
  }

  @override
  List<Object> get props => [communities, currentCommunity, tokens];
}
