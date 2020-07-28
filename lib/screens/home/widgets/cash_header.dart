import 'package:flutter/material.dart';
import 'package:seedbed/constans/keys.dart';
import 'package:seedbed/generated/i18n.dart';
import 'package:seedbed/models/views/cash_header.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:seedbed/utils/format.dart';
import 'package:seedbed/utils/send.dart';

class CashHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CashHeaderViewModel>(
        distinct: true,
        converter: CashHeaderViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 15.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withAlpha(20),
                    blurRadius: 30.0,
                    spreadRadius: 10.0,
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
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      AppKeys.homePageKey.currentState.openDrawer();
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 35, bottom: 35, right: 35),
                        child: Image.asset(
                          'assets/images/menu.png',
                          width: 20,
                        ))),
                Text('${I18n.of(context).hi} ${viewModel?.firstName() ?? ''}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
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
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(150),
                                  fontSize: 12.0)),
                          padding: EdgeInsets.only(bottom: 6.0),
                        ),
                        viewModel.hasErc20Tokens
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '\$${viewModel?.usdValue ?? '0'}',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ])
                            : RichText(
                                text: new TextSpan(
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  children: viewModel.community.token == null
                                      ? <TextSpan>[
                                          new TextSpan(
                                              text: '0',
                                              style: new TextStyle(
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold))
                                        ]
                                      : <TextSpan>[
                                          new TextSpan(
                                              text: formatValue(
                                                  viewModel
                                                      .community.token.amount,
                                                  viewModel.community.token
                                                      .decimals),
                                              style: new TextStyle(
                                                  fontSize: 32,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold)),
                                          new TextSpan(
                                              text: ' ' +
                                                  viewModel
                                                      .community.token?.symbol
                                                      .toString(),
                                              style: new TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0.0))
                                        ],
                                ),
                              ),
                      ],
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      child: FloatingActionButton(
                          heroTag: 'cash_header',
                          backgroundColor: Color(0xFF292929),
                          elevation: 0,
                          child: Image.asset(
                            'assets/images/scan.png',
                            width: 25.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onPressed: bracodeScannerHandler),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
