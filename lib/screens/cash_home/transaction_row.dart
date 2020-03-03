import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/transaction.dart';
import 'package:roost/models/transfer.dart';
import 'package:roost/models/views/cash_wallet.dart';
import 'package:roost/utils/transaction_row.dart';
import 'package:roost/screens/cash_home/transaction_details.dart';
import 'package:roost/utils/format.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final Contact _contact;
  final CashWalletViewModel _vm;

  TransactionListItem(
    this._transaction,
    this._contact,
    this._vm,
  );

  @override
  Widget build(BuildContext context) {
    Transfer transfer = _transaction as Transfer;
    String displayName = transfer.isJoinBonus()
        ? (transfer.text ?? I18n.of(context).join_bonus)
        : (transfer.receiverName != null && transfer.receiverName != '')
            ? transfer.receiverName
            : transfer.text != null
                ? transfer.text
                : _contact != null
                    ? _contact.displayName
                    : deducePhoneNumber(transfer, _vm.reverseContacts,
                        businesses: _vm.businesses);
    List<Widget> rightColumn = <Widget>[
      transfer.isGenerateWallet() || transfer.isJoinCommunity()
          ? SizedBox.shrink()
          : Row(
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
                              formatValue(transfer.value, _vm.token.decimals),
                          style: new TextStyle(
                              color: deduceColor(transfer),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      new TextSpan(
                          text: " ${_vm.token.symbol}",
                          style: new TextStyle(
                              color: deduceColor(transfer),
                              fontSize: 10.0,
                              fontWeight: FontWeight.normal)),
                    ])),
                    transfer.isFailed()
                        ? Positioned(
                            left: -25,
                            child: SvgPicture.asset('assets/images/failed.svg'),
                          )
                        : SizedBox.shrink(),
                    Positioned(
                        bottom: -20,
                        child: (transfer.isPending() &&
                                !transfer.isGenerateWallet() &&
                                !transfer.isJoinCommunity())
                            ? Padding(
                                child: Text(I18n.of(context).pending,
                                    style: TextStyle(
                                        color: Color(0xFF8D8D8D),
                                        fontSize: 10)),
                                padding: EdgeInsets.only(top: 10))
                            : SizedBox.shrink())
                  ],
                )
              ],
            )
    ];
    bool isWalletCreated = 'created' == this._vm.walletStatus;
    return Container(
        decoration: new BoxDecoration(
            border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
        child: ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage:
                                    getImage(transfer, _contact, _vm),
                              ),
                              tag: transfer.isGenerateWallet()
                                  ? 'GenerateWallet'
                                  : transfer.isPending()
                                      ? "contactSent"
                                      : "transaction" + (transfer?.jobId ?? transfer.txHash),
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
                            _vm.community.metadata.isDefaultImage != null &&
                                    _vm.community.metadata.isDefaultImage &&
                                    transfer.isJoinCommunity()
                                ? Text(
                                    _vm.community.token.symbol,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      transfer.isGenerateWallet() && !isWalletCreated
                          ? Flexible(
                              flex: 10,
                              child: Stack(
                                overflow: Overflow.visible,
                                alignment: AlignmentDirectional.bottomStart,
                                children: <Widget>[
                                  Text(displayName,
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 15)),
                                  Positioned(
                                      bottom: -20,
                                      child: Padding(
                                          child: Text('(up to 10 seconds)',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary)),
                                          padding: EdgeInsets.only(top: 10)))
                                ],
                              ))
                          : Flexible(
                              flex: 10,
                              child: Text(displayName,
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 15)),
                            ),
                    ],
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
                    width: 100,
                    child: transfer.isFailed()
                        ? InkWell(
                            onTap: () {
                              // TODO - Resend fail job
                            },
                            child: Column(
                                mainAxisAlignment: transfer.isPending()
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                crossAxisAlignment: transfer.isPending()
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.center,
                                children: rightColumn),
                          )
                        : Column(
                            mainAxisAlignment: transfer.isPending()
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            crossAxisAlignment: transfer.isPending()
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.center,
                            children: rightColumn),
                  ))
            ],
          ),
          onTap: () {
            if (transfer.isGenerateWallet() || transfer.isJoinCommunity()) {
              return;
            }
            if (!transfer.isGenerateWallet() || !transfer.isJoinCommunity()) {
              Navigator.pushNamed(context, '/TransactionDetails',
                  arguments: TransactionDetailArguments(
                    transfer: transfer,
                    contact: _contact,
                    from: displayName,
                    reverseContacts: _vm.reverseContacts,
                    symbol: _vm.token.symbol,
                    image: getImage(transfer, _contact, _vm),
                    amount: [
                      Text(
                        deduceSign(transfer) +
                            formatValue(transfer.value, _vm.token.decimals),
                        style: TextStyle(
                            color: deduceColor(transfer),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${_vm.token.symbol}",
                        style: TextStyle(
                            color: deduceColor(transfer),
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ));
            } else {
              return;
            }
          },
        ));
  }
}
