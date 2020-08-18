import 'package:auto_route/auto_route.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:seedbed/models/community/community.dart';
import 'package:seedbed/screens/home/router/home_router.gr.dart';
import 'package:seedbed/widgets/network_explained.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:seedbed/widgets/move_to_ethereum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seedbed/generated/i18n.dart';
import 'package:seedbed/models/tokens/token.dart';
import 'package:seedbed/utils/format.dart';

class TokenHeader extends StatelessWidget {
  TokenHeader({this.token, this.tokenPrice});
  final String tokenPrice;
  final Token token;

  @override
  Widget build(BuildContext context) {
    final String price = token.priceInfo != null
        ? reduce(double.parse(token?.priceInfo?.total))
        : '0';
    final bool isFuseToken = token.originNetwork != null;
    final String logo = isFuseToken ? 'fuse-network.svg' : 'ether-network.svg';
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
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark,
              ],
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))),
        child: Stack(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                      padding: EdgeInsets.only(top: 35, bottom: 35, right: 35),
                      child: Icon(PlatformIcons(context).back))),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('${token.symbol} ${I18n.of(context).balance}',
                        style: TextStyle(
                            color: Theme.of(context).splashColor,
                            fontSize: 12.0)),
                    padding: EdgeInsets.only(bottom: 6.0),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).splashColor),
                                    children: [
                                  TextSpan(text: token.getBalance()),
                                  TextSpan(text: " ${token.symbol}")
                                ])),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: ![null, '']
                                                .contains(token.priceInfo) &&
                                            token.priceInfo.total.isNotEmpty &&
                                            tokenPrice != null
                                        ? '\$$price'
                                        : "",
                                    style: TextStyle(
                                        color: Theme.of(context).splashColor,
                                        fontSize: 18))),
                          ],
                        ),
                        StoreConnector<AppState, _ProTokenHeaderViewModel>(
                            converter: _ProTokenHeaderViewModel.fromStore,
                            builder: (_, viewModel) {
                              final bool canMoveToOtherChain = token.symbol ==
                                  viewModel.community.token.symbol;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  !isFuseToken
                                      ? Container(
                                          width: 45,
                                          height: 45,
                                          child: FloatingActionButton(
                                              heroTag: 'goto_trade',
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color(0xFF002669),
                                              child: SvgPicture.asset(
                                                'assets/images/goto_trade.svg',
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () {
                                                ExtendedNavigator.named(
                                                        'homeRouter')
                                                    .push(
                                                        HomeRoutes.tradeScreen,
                                                        arguments:
                                                            TradeScreenArguments(
                                                                primaryToken:
                                                                    token));
                                              }),
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 45,
                                    height: 45,
                                    child: FloatingActionButton(
                                        heroTag: 'move_from_scanner',
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0xFF002669),
                                        child: SvgPicture.asset(
                                          'assets/images/move_from_fuse.svg',
                                          fit: BoxFit.cover,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return TokenActionsDialog(
                                                    token: token,
                                                    canMoveToOtherChain:
                                                        canMoveToOtherChain);
                                              });
                                        }),
                                  )
                                ],
                              );
                            })
                      ])
                ],
              )),
            ],
          ),
          Positioned(
            right: 0,
            top: 25,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: SvgPicture.asset(
                      'assets/images/$logo',
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NetworkExplainedScreen(
                                network: isFuseToken ? 'fuse' : 'ether');
                          });
                    },
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}

class _ProTokenHeaderViewModel extends Equatable {
  final Community community;
  _ProTokenHeaderViewModel({
    this.community,
  });

  static _ProTokenHeaderViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            Community.initial();
    return _ProTokenHeaderViewModel(community: community);
  }

  @override
  List<Object> get props => [community];
}
