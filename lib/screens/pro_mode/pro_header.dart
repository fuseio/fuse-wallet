import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins/fee_base.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/barcode.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/widgets/raised_gradient_button.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, EtherUnit;

class ProHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ProHeaderViewModel>(
        converter: _ProHeaderViewModel.fromStore,
        onWillChange: (prevVm, nextVm) {
          if (prevVm.etherBalance != nextVm.etherBalance) {
            EtherAmount amount = EtherAmount.inWei(nextVm.etherBalance);
            nextVm.idenyifyCall(Map<String, dynamic>.from({
              "Ether balance": Decimal.parse(
                      amount.getValueInUnit(EtherUnit.ether).toString())
                  .toStringAsPrecision(1),
            }));
          }
        },
        builder: (_, viewModel) {
          return Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withAlpha(20),
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
                    Colors.black,
                    Color(0xFF414141),
                    Colors.black,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 35, bottom: 35, right: 35),
                        child: Image.asset(
                          'assets/images/menu_white.png',
                          width: 20,
                        ))),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: new RichText(
                      text: new TextSpan(
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        children: <TextSpan>[
                          new TextSpan(
                              text: I18n.of(context).hi,
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.normal)),
                          new TextSpan(
                              text: ' ' + (viewModel?.firstName() ?? ''),
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.normal)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              child: Text(I18n.of(context).balance,
                                  style: TextStyle(
                                      color: Theme.of(context).splashColor,
                                      fontSize: 12.0)),
                              padding: EdgeInsets.only(bottom: 6.0),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RichText(
                                    text: new TextSpan(
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: '${viewModel.balance} ETH',
                                            style: new TextStyle(
                                                fontSize: 32,
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ])
                          ],
                        ),
                        new Container(
                          child: Row(children: [
                            RaisedGradientButton(
                              width: 50,
                              height: 50,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context).primaryColorDark,
                                  Theme.of(context).primaryColorLight,
                                ],
                              ),
                              onPressed: () {
                                bracodeScannerHandler(context,
                                    isProMode: true,
                                    daiToken: viewModel.daiToken,
                                    feePlugin: viewModel.feePlugin);
                              },
                              child: Image.asset(
                                'assets/images/scan.png',
                                width: 25.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ]),
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

class _ProHeaderViewModel extends Equatable {
  final Function() firstName;
  final Token daiToken;
  final String balance;
  final BigInt etherBalance;
  final Function(Map<String, dynamic> traits) idenyifyCall;
  final FeePlugin feePlugin;

  _ProHeaderViewModel(
      {this.firstName,
      this.daiToken,
      this.etherBalance,
      this.idenyifyCall,
      this.feePlugin,
      this.balance});

  static _ProHeaderViewModel fromStore(Store<AppState> store) {
    Token token =
        store.state.proWalletState.erc20Tokens.containsKey(daiTokenAddress.toLowerCase())
            ? store.state.proWalletState.erc20Tokens[daiTokenAddress.toLowerCase()]
            : new Token.initial();
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    BigInt etherBalance = store.state.proWalletState?.etherBalance ?? BigInt.zero;
    String format = EtherAmount.inWei(etherBalance)
        .getValueInUnit(EtherUnit.ether)
        .toString();
    String balance =
        EtherAmount.inWei(etherBalance).getValueInUnit(EtherUnit.ether) == 0
            ? '0'
            : Decimal.parse(format).toStringAsPrecision(2);
    return _ProHeaderViewModel(
        balance: balance,
        etherBalance: etherBalance,
        feePlugin: community.plugins.foreignTransfers,
        daiToken: token,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        },
        idenyifyCall: (Map<String, dynamic> traits) {
          store.dispatch(segmentIdentifyCall(traits));
        });
  }

  @override
  List<Object> get props => [daiToken, feePlugin, balance, etherBalance];
}
