import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:farmly_ledger/models/pro/token.dart';
import 'package:farmly_ledger/redux/actions/cash_wallet_actions.dart';
import 'package:farmly_ledger/utils/addresses.dart';
import 'package:farmly_ledger/widgets/coming_soon.dart';
import 'package:redux/redux.dart';
import 'package:farmly_ledger/generated/i18n.dart';
import 'package:farmly_ledger/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmly_ledger/widgets/raised_gradient_button.dart';

class ProHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ProHeaderViewModel>(
        converter: _ProHeaderViewModel.fromStore,
        onWillChange: (prevVm, nextVm) {
          if (nextVm.daiToken.address != null && nextVm.daiToken.address != '') {
            String name = nextVm.daiToken.name;
            nextVm.idenyifyCall(Map<String, dynamic>.from({
              "$name balance": nextVm.daiToken.amount,
            }));
          }
        },
        builder: (_, viewModel) {
          return Container(
            height: 260.0,
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
                                            text: '\$' +
                                                viewModel.daiToken?.amount
                                                    .toString(),
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
                                comingSoon(context);
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
  final Function(Map<String, dynamic> traits) idenyifyCall;

  _ProHeaderViewModel({this.firstName, this.daiToken, this.idenyifyCall});

  static _ProHeaderViewModel fromStore(Store<AppState> store) {
    Token token = store.state.proWalletState.tokens.firstWhere(
        (token) => token.address.contains(daiTokenAddress),
        orElse: () => new Token.initial());
    return _ProHeaderViewModel(
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
  List<Object> get props => [];
}
