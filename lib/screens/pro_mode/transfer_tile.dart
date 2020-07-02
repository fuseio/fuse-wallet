import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/transaction_row.dart';

class TransferTIle extends StatelessWidget {
  TransferTIle({this.transaction, this.token});
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
                  flex: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                              width: 55,
                              height: 55,
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
                            ),
                            transfer.isPending()
                                ? Container(
                                    width: 55,
                                    height: 55,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color(0xFF49D88D).withOpacity(0),
                                      strokeWidth: 3,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color(0xFF49D88D).withOpacity(1)),
                                    ))
                                : SizedBox.shrink(),
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
                  flex: 4,
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
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: formatValue(
                                              transfer.value, token.decimals),
                                          style: TextStyle(
                                              color: Color(0xFF696969),
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: " ${token.symbol}",
                                          style: TextStyle(
                                              color: Color(0xFF696969),
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.normal)),
                                    ])),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    deduceTransferIcon(transfer),
                                  ],
                                ),
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
