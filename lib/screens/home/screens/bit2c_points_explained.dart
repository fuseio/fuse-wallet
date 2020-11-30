import 'package:bit2c/models/app_state.dart';
import 'package:bit2c/models/community/community.dart';
import 'package:bit2c/models/tokens/token.dart';
import 'package:bit2c/utils/send.dart';
import 'package:bit2c/widgets/main_scaffold.dart';
import 'package:bit2c/widgets/primary_button.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Bit2cExplainedScreen extends StatefulWidget {
  @override
  _Bit2cExplainedScreenState createState() => _Bit2cExplainedScreenState();
}

class _Bit2cExplainedScreenState extends State<Bit2cExplainedScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Bit2cExplainedViewModel>(
        distinct: true,
        converter: _Bit2cExplainedViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: 'נקודות Bit2c',
            automaticallyImplyLeading: false,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Center(
                      child: Container(
                          height: 76,
                          child: Image.asset(
                            'assets/images/buying-yellow.png',
                          )),
                    ),
                    Container(
                      width: 220,
                      child: Text("נקודות BIT2c הינם מטבעות המונפקות ע״י B2C",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    // SizedBox(height: 30.0),
                    Container(
                      child: Text("1 BIP = 1 ₪",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff00C671),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    // SizedBox(height: 30.0),
                    Container(
                      width: 220,
                      child: Text("נקודות BIT2c הינם מטבעות המונפקות ע״י B2C",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    // SizedBox(height: 30.0),
                    Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: Text(
                          ''' ל מנת לקבל בונוס של 50 נקודות תתחברו לחשבון
שלכם בביטוסי, לחצו על "חיבור ארנק" ותעקבו 
אחרי ההוראות ''',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: RaisedButton(
                            onPressed: () {
                              bracodeScannerValidateAPI(viewModel?.phoneNumber,
                                  viewModel?.walletAddress);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.0),
                                topLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Bit2c חיבור לחשבון',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10, right: 15),
                                  child: Image.asset(
                                      'assets/images/gift-buy.png',
                                      width: 25,
                                      height: 25),
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class _Bit2cExplainedViewModel extends Equatable {
  final String phoneNumber;
  final String walletAddress;
  final Token token;

  @override
  List<Object> get props => [phoneNumber, walletAddress, token];

  _Bit2cExplainedViewModel({this.walletAddress, this.phoneNumber, this.token});

  static _Bit2cExplainedViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            Community.initial();
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return _Bit2cExplainedViewModel(
      token: token,
      phoneNumber: store.state.userState.normalizedPhoneNumber,
      walletAddress: store.state.userState.walletAddress,
    );
  }
}
