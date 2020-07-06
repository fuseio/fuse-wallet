import 'package:decimal/decimal.dart';
import 'package:digitalrand/constans/exchangable_tokens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/plugins/fee_base.dart';
import 'package:digitalrand/models/pro/pro_wallet_state.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:digitalrand/utils/barcode.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, EtherUnit;

class ProHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ProHeaderViewModel>(
        converter: _ProHeaderViewModel.fromStore,
        onWillChange: (prevVm, nextVm) {
          if (prevVm.etherBalance != nextVm.etherBalance) {
            EtherAmount amount = EtherAmount.inWei(nextVm.etherBalance);
            nextVm.idenyifyCall(Map<String, dynamic>.from({
              "Ether balance": Decimal.parse(
                      amount.getValueInUnit(EtherUnit.ether).toString())
                  .toStringAsPrecision(2),
            }));
          }
          if (prevVm.balance != nextVm.balance) {
            nextVm.idenyifyCall(Map<String, dynamic>.from({
              "Usd dollar balance": nextVm.balance,
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
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColorLight,
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
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Theme.of(context).splashColor),
                        children: <TextSpan>[
                          TextSpan(
                              text: I18n.of(context).hi,
                              style: TextStyle(
                                  fontSize: 33,
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.normal)),
                          TextSpan(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(I18n.of(context).balance,
                                  style: TextStyle(
                                      color: Theme.of(context).splashColor,
                                      fontSize: 12.0)),
                              padding: EdgeInsets.only(bottom: 6.0),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '\$' + viewModel.balance,
                                            style: TextStyle(
                                                fontSize: 32,
                                                color: Theme.of(context)
                                                    .splashColor,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 10.0),
                                  //   child: Text(
                                  //     '${viewModel.ethBalance} ETH',
                                  //     style: TextStyle(
                                  //       fontSize: 18,
                                  //       color: Theme.of(context).splashColor,
                                  //     ),
                                  //   ),
                                  // )
                                ])
                          ],
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                              heroTag: 'cash_scanner',
                              backgroundColor: Color(0xFF00339F),
                              elevation: 0,
                              child: Image.asset(
                                'assets/images/scan.png',
                                width: 25.0,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              onPressed: () {
                                bracodeScannerHandler(context,
                                    isProMode: true,
                                    daiToken: viewModel.tokenDAI,
                                    feePlugin: viewModel.feePlugin);
                              }),
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
  final Token tokenDAI;
  final String balance;
  final String ethBalance;
  final BigInt etherBalance;
  final Function(Map<String, dynamic> traits) idenyifyCall;
  final FeePlugin feePlugin;

  _ProHeaderViewModel(
      {this.firstName,
      this.tokenDAI,
      this.etherBalance,
      this.idenyifyCall,
      this.feePlugin,
      this.ethBalance,
      this.balance});

  static _ProHeaderViewModel fromStore(Store<AppState> store) {
    ProWalletState proState = store.state.proWalletState;
    Token token = store.state.proWalletState.erc20Tokens
            .containsKey(daiTokenAddress.toLowerCase())
        ? store.state.proWalletState.erc20Tokens[daiTokenAddress.toLowerCase()]
        : daiToken;
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    BigInt etherBalance =
        store.state.proWalletState?.etherBalance ?? BigInt.zero;

    String format = EtherAmount.inWei(etherBalance)
        .getValueInUnit(EtherUnit.ether)
        .toString();
    num ethBalance = num.parse(Decimal.parse(format).toStringAsPrecision(2));

    num combiner(
            num previousValue, Token token) =>
        prices.containsKey(token.symbol)
            ? token?.priceInfo != null
                ? previousValue +
                    num.parse(Decimal.parse(token?.priceInfo?.total).toString())
                : previousValue +
                    num.parse(getDollarValue(
                        token.amount, token.decimals, prices[token.symbol]))
            : previousValue + 0;

    num usdValue = proState.erc20Tokens.values.fold<num>(0, combiner);
    Decimal decimalValue = Decimal.parse(usdValue.toString());
    return _ProHeaderViewModel(
        ethBalance: ethBalance == 0
            ? '0'
            : ethBalance.compareTo(0.01) != 1 ? 'Less then 0.01' : ethBalance,
        balance: decimalValue.compareTo(Decimal.parse('0.01')) != 1
            ? decimalValue.toStringAsFixed(1)
            : decimalValue.isInteger
                ? decimalValue.toString()
                : decimalValue.toStringAsPrecision(2),
        etherBalance: etherBalance,
        feePlugin: community.plugins.foreignTransfers,
        tokenDAI: token,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        },
        idenyifyCall: (Map<String, dynamic> traits) {
          store.dispatch(segmentIdentifyCall(traits));
        });
  }

  @override
  List<Object> get props =>
      [daiToken, feePlugin, ethBalance, balance, etherBalance];
}
