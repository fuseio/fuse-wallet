import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/transactions/transaction.dart';
import 'package:peepl/models/transactions/transfer.dart';
import 'package:peepl/models/views/cash_wallet.dart';
import 'package:peepl/screens/routes.gr.dart';
import 'package:peepl/utils/addresses.dart';
import 'package:peepl/utils/transaction_row.dart';
import 'package:peepl/screens/cash_home/transaction_details.dart';
import 'package:peepl/utils/format.dart';

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
    bool isSendingToForeign = (_vm.community.homeBridgeAddress != null &&
            transfer.to != null &&
            transfer.to?.toLowerCase() ==
                _vm.community.homeBridgeAddress?.toLowerCase()) ??
        false;
    bool isWalletCreated = 'created' == this._vm.walletStatus;
    bool isZeroAddress = transfer.from == zeroAddress;
    ImageProvider<dynamic> image = isZeroAddress ? AssetImage(
      'assets/images/ethereume_icon.png',
      ) : getTransferImage(transfer, _contact, _vm);
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
    String symbol = _vm.token != null && _vm.token.address != null &&  transfer.tokenAddress != null
      ? _vm.token.address == transfer.tokenAddress
        ? _vm.token.symbol
          : _vm.community.secondaryToken?.symbol
          : '';
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
                          text: " $symbol",
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
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage: image,
                              ),
                              tag: transfer.isGenerateWallet()
                                  ? 'GenerateWallet'
                                  : transfer.isPending()
                                      ? "contactSent"
                                      : "transaction" +
                                          (transfer?.jobId ?? transfer.txHash),
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
                                    symbol,
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
                      Flexible(
                        flex: 10,
                        child: Stack(
                          overflow: Overflow.visible,
                          alignment: AlignmentDirectional.bottomStart,
                          children: <Widget>[
                            transfer.isJoinCommunity()
                                ? RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: transfer.isJoinCommunity() &&
                                                    transfer.isPending()
                                                ? I18n.of(context).joining
                                                : I18n.of(context).joined,
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                            text: ' \‘${_vm.community.name}\’ ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: I18n.of(context).community,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  )
                                : Text(
                                    isZeroAddress
                                      ? I18n.of(context).received_from_ethereum
                                      : isSendingToForeign
                                        ? I18n.of(context).sent_to_ethereum
                                        : displayName,
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 15)),
                            isSendingToForeign
                                ? Positioned(
                                    bottom: -20,
                                    child: Padding(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Go to pro mode',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              'assets/images/go_to_pro.svg',
                                              width: 10,
                                              height: 8,
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.only(top: 10)))
                                : transfer.isGenerateWallet() &&
                                        !isWalletCreated
                                    ? Positioned(
                                        bottom: -20,
                                        child: Padding(
                                            child: Text('(up to 10 seconds)',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary)),
                                            padding: EdgeInsets.only(top: 10)))
                                    : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
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
            if (isSendingToForeign) {
              _vm.replaceNavigator(true);
            }
            if (transfer.isGenerateWallet() || transfer.isJoinCommunity()) {
              return;
            }
            if (!transfer.isGenerateWallet() || !transfer.isJoinCommunity()) {
              Router.navigator.pushNamed(Router.transactionDetailsScreen,
                  arguments: TransactionDetailArguments(
                    transfer: transfer,
                    contact: _contact,
                    from: displayName,
                    reverseContacts: _vm.reverseContacts,
                    symbol: symbol,
                    image: image,
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
                        " $symbol",
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
