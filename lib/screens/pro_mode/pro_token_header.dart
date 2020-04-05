import 'package:equatable/equatable.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/deposit_dai_popup.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProTokenHeader extends StatelessWidget {
  ProTokenHeader({this.token});
  final Token token;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ProTokenHeaderViewModel>(
        converter: _ProTokenHeaderViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            height: 260.0,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(30.0),
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
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 10, bottom: 35, right: 35),
                        child: SvgPicture.asset(
                          'assets/images/arrow_back_business.svg',
                          fit: BoxFit.fill,
                          width: 25,
                          height: 25,
                          alignment: Alignment.topLeft,
                        ))),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.0, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            RichText(
                                text: new TextSpan(
                                    text:
                                        "\$ ${formatValue(token.amount, token.decimals)}",
                                    style: new TextStyle(
                                        fontSize: 32,
                                        color: Theme.of(context).splashColor,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: new TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFFBEBEBE),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                  new TextSpan(
                                      text: formatValue(
                                          token.amount, token.decimals)),
                                  new TextSpan(text: " ${token.symbol}")
                                ])),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
                token.address.contains(daiTokenAddress)
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding:
                              EdgeInsets.only(bottom: 0.0, left: 10, right: 10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            verticalDirection: VerticalDirection.up,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width * .3,
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(5.0)),
                                    color: Color(0xFF1D1D1D),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      I18n.of(context).addDai,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).splashColor),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DepositDaiDialog();
                                      });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(5.0)),
                                    color: Color(0xFF1D1D1D),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      I18n.of(context).sendToCashMode,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).splashColor),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              SendAmountScreen(
                                                  pageArgs: SendAmountArguments(
                                                sendType:
                                                    SendType.ETHEREUM_ADDRESS,
                                                sendToCashMode: true,
                                                avatar: NetworkImage(
                                                  getTokenUrl(
                                                      checksumEthereumAddress(
                                                          token.address)),
                                                ),
                                                name: 'Cash mode',
                                                erc20Token: token,
                                              ))));
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          );
        });
  }
}

class _ProTokenHeaderViewModel extends Equatable {
  final Function() firstName;
  final Token daiToken;

  _ProTokenHeaderViewModel({this.firstName, this.daiToken});

  static _ProTokenHeaderViewModel fromStore(Store<AppState> store) {
    Token token = store.state.proWalletState.tokens.firstWhere(
        (token) => token.address.contains(daiTokenAddress),
        orElse: () => new Token.initial());
    return _ProTokenHeaderViewModel(
        daiToken: token,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props => [];
}
