import 'package:auto_route/auto_route.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:supervecina/models/community/community.dart';
import 'package:supervecina/screens/home/router/home_router.gr.dart';
import 'package:supervecina/screens/home/widgets/community_description.dart';
import 'package:supervecina/widgets/bridge_dialog.dart';
import 'package:supervecina/widgets/network_explained.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/utils/format.dart';

class TokenHeader extends StatelessWidget {
  TokenHeader({this.token});
  final Token token;

  @override
  Widget build(BuildContext context) {
    final String price = token.priceInfo != null
        ? reduce(double.parse(token?.priceInfo?.total))
        : '0';
    final bool isFuseToken = ![null, ''].contains(token.originNetwork);
    final String logo = isFuseToken ? 'fuse-network.svg' : 'ether-network.svg';
    final String moveToLogo =
        !isFuseToken ? 'move_from_fuse.svg' : 'move_to_ethereum.svg';
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
                                    text:
                                        ![null, ''].contains(token.priceInfo) &&
                                                token.priceInfo.total.isNotEmpty
                                            ? '\$$price'
                                            : "",
                                    style: TextStyle(
                                        color: Theme.of(context).splashColor,
                                        fontSize: 18))),
                          ],
                        ),
                        StoreConnector<AppState, _ProTokenHeaderViewModel>(
                            converter: _ProTokenHeaderViewModel.fromStore,
                            distinct: true,
                            builder: (_, viewModel) {
                              final Community community = viewModel.communities
                                  .firstWhere(
                                      (element) =>
                                          (element.token.address
                                                  .toLowerCase() ==
                                              token.address.toLowerCase()) ||
                                          (element?.foreignTokenAddress
                                                  ?.toLowerCase() ==
                                              token.address.toLowerCase()),
                                      orElse: () => null);
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
                                                  Color(0xFF002669),
                                              child: SvgPicture.asset(
                                                'assets/images/goto_trade.svg',
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () {
                                                ExtendedNavigator.named(
                                                        'homeRouter')
                                                    .pushTradeScreen(
                                                        primaryToken: token);
                                              }),
                                        )
                                      : Container(
                                          width: 45,
                                          height: 45,
                                          child: FloatingActionButton(
                                              heroTag: 'CommunityDescription',
                                              elevation: 0,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.info,
                                                color: Theme.of(context)
                                                    .splashColor,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CommunityDescription(
                                                            community:
                                                                community));
                                              }),
                                        ),
                                  community != null
                                      ? SizedBox(
                                          width: 10,
                                        )
                                      : SizedBox.shrink(),
                                  community != null
                                      ? Container(
                                          width: 45,
                                          height: 45,
                                          child: FloatingActionButton(
                                              heroTag: 'move_from_scanner',
                                              elevation: 0,
                                              backgroundColor:
                                                  Color(0xFF002669),
                                              child: SvgPicture.asset(
                                                'assets/images/$moveToLogo',
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        BridgeDialog(
                                                          token: token,
                                                          community: community,
                                                          logo: moveToLogo,
                                                          isFuseToken:
                                                              isFuseToken,
                                                        ));
                                              }),
                                        )
                                      : SizedBox.shrink()
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
                                logo: isFuseToken
                                    ? 'fuse_network_logo.svg'
                                    : 'ether-logo.svg',
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
  final List<Community> communities;
  _ProTokenHeaderViewModel({
    this.communities,
  });

  static _ProTokenHeaderViewModel fromStore(Store<AppState> store) {
    return _ProTokenHeaderViewModel(
        communities: store.state.cashWalletState.communities.values.toList());
  }

  @override
  List<Object> get props => [communities];
}
