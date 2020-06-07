import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins/fee_base.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/screens/pro_mode/pro_token_header.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/transaction_row.dart';
import 'package:fusecash/widgets/deposit_dai_popup.dart';
import 'package:fusecash/widgets/my_app_bar.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';

class TokenTransfersScreen extends StatelessWidget {
  TokenTransfersScreen({Key key, this.token}) : super(key: key);
  final Token token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: MyAppBar(
            height: MediaQuery.of(context).size.height * .21,
            child: ProTokenHeader(token: token),
            backgroundColor: Colors.red),
        drawerEdgeDragWidth: 0,
        body: Column(children: <Widget>[
          Expanded(child: ListView(children: [TransfersList(token: token)])),
        ]));
  }
}

class TransfersList extends StatelessWidget {
  TransfersList({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          token.address.contains(daiTokenAddress)
              ? Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  color: Theme.of(context).splashColor,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(5.0)),
                            color: Theme.of(context).backgroundColor,
                            shape: BoxShape.rectangle,
                          ),
                          child: Center(
                            child: Text(
                              I18n.of(context).addDai,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor),
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
                      SizedBox(
                        width: 20,
                      ),
                      new StoreConnector<AppState, _SendToCashModeViewModel>(
                          distinct: true,
                          converter: _SendToCashModeViewModel.fromStore,
                          builder: (_, vm) {
                            return InkWell(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * .4,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                  color: Theme.of(context).backgroundColor,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Center(
                                  child: Text(
                                    I18n.of(context).sendToCashMode,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => SendAmountScreen(
                                                pageArgs: SendAmountArguments(
                                              sendType:
                                                  SendType.ETHEREUM_ADDRESS,
                                              sendToCashMode: true,
                                              feePlugin: vm.feePlugin,
                                              avatar: NetworkImage(
                                                getTokenUrl(
                                                    checksumEthereumAddress(
                                                        token.address)),
                                              ),
                                              name: 'Cash mode',
                                              erc20Token: token,
                                            ))));
                              },
                            );
                          }),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          Container(
              padding: EdgeInsets.only(left: 15, top: 20, bottom: 8),
              child: Text(I18n.of(context).transactions,
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal))),
          ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(left: 15, right: 15),
              children: [
                ...token.transactions.list.reversed
                    .map((Transaction transaction) =>
                        _TransferRow(transaction: transaction, token: token))
                    .toList()
              ])
        ]);
  }
}

class _TransferRow extends StatelessWidget {
  _TransferRow({this.transaction, this.token});
  final Token token;
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    Transfer transfer = transaction as Transfer;

    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                              width: 54,
                              height: 54,
                              imageUrl: token.imageUrl != null &&
                                      token.imageUrl.isNotEmpty
                                  ? token.imageUrl
                                  : getTokenUrl(
                                      checksumEthereumAddress(token.address)),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 54,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Text(token.name,
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.bottomEnd,
                              children: <Widget>[
                                new RichText(
                                    text: new TextSpan(children: <TextSpan>[
                                  new TextSpan(
                                      text: deduceSign(transfer) +
                                          formatValue(
                                              transfer.value, token.decimals),
                                      style: new TextStyle(
                                          color: deduceColor(transfer),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text: " ${token.symbol}",
                                      style: new TextStyle(
                                          color: deduceColor(transfer),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ])),
                                transfer.isFailed()
                                    ? Positioned(
                                        left: -25,
                                        child: SvgPicture.asset(
                                            'assets/images/failed.svg'),
                                      )
                                    : SizedBox.shrink(),
                                Positioned(
                                    bottom: -20,
                                    child: (transfer.isPending() &&
                                            !transfer.isGenerateWallet() &&
                                            !transfer.isJoinCommunity())
                                        ? Padding(
                                            child: Text(
                                                I18n.of(context).pending,
                                                style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 10)),
                                            padding: EdgeInsets.only(top: 10))
                                        : SizedBox.shrink())
                              ],
                            )
                          ],
                        )
                      ]))
            ],
          )),
    );
  }
}

class _SendToCashModeViewModel extends Equatable {
  final FeePlugin feePlugin;
  _SendToCashModeViewModel({
    this.feePlugin,
  });

  @override
  List get props => [feePlugin];

  static _SendToCashModeViewModel fromStore(Store<AppState> store) {
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return _SendToCashModeViewModel(
      feePlugin: community.plugins.foreignTransfers,
    );
  }
}
