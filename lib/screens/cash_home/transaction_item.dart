import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/business.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/models/transfer.dart';
import 'package:paywise/models/views/cash_wallet.dart';
import 'package:paywise/screens/buy/business.dart';
import 'package:paywise/screens/cash_home/cash_transactions.dart';
import 'package:paywise/screens/cash_home/transaction_details.dart';
import 'package:paywise/utils/format.dart';

String deducePhoneNumber(Transfer transfer, Map<String, String> reverseContacts,
    {bool format = true, List<Business> businesses}) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (businesses != null && businesses.isNotEmpty) {
    Business business = businesses.firstWhere(
        (business) => business.account.toLowerCase() == accountAddress.toLowerCase(),
        orElse: () => null);
    if (business != null) {
      return business.name;
    }
  }
  if (reverseContacts.containsKey(accountAddress)) {
    return reverseContacts[accountAddress];
  }
  if (format) {
    return formatAddress(accountAddress);
  } else {
    return accountAddress;
  }
}

dynamic getImage(Transfer transfer, Contact contact, CashWalletViewModel vm) {
  if (transfer.isJoinCommunity() &&
      vm.community.metadata.image != null &&
      vm.community.metadata.image != '') {
    return new NetworkImage(DotEnv().env['IPFS_BASE_URL'] + '/image/' + vm.community.metadata.image);
  } else if (transfer.isGenerateWallet()) {
    return new AssetImage(
      'assets/images/generate_wallet.png',
    );
  } else if (transfer.isJoinBonus()) {
    return new AssetImage(
      'assets/images/join.png',
    );
  } else if (contact?.avatar != null) {
    return new MemoryImage(contact.avatar);
  }

  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  Business business = vm.businesses.firstWhere(
      (business) => business.account.toLowerCase() == accountAddress.toLowerCase(),
      orElse: () => null);
  if (business != null) {
    return NetworkImage(getImageUrl(business, vm.communityAddress));
  }
  return new AssetImage('assets/images/anom.png');
}

Color deduceColor(Transfer transfer) {
  if (transfer.isFailed()) {
    return Color(0xFFE0E0E0);
  } else {
    if (transfer.type == 'SEND') {
      return Color(0xFFFF0000);
    } else {
      return Color(0xFF00BE66);
    }
  }
}

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
        ? I18n.of(context).join_bonus
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
                                  formatValue(
                                      transfer.value, _vm.token.decimals),
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
                                      : "transaction" + transfer.txHash,
                            ),
                            transfer.isPending()
                                ? Container(
                                    width: 55,
                                    height: 55,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color(0xFF49D88D).withOpacity(0),
                                      strokeWidth:
                                          3, //backgroundColor: Color(0xFFb8e3a6),
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color(0xFF49D88D).withOpacity(1)),
                                    ))
                                : SizedBox.shrink(),
                            _vm.community.metadata.isDefaultImage != null &&
                                    _vm.community.metadata.isDefaultImage &&
                                    transfer.isJoinCommunity()
                                ? Positioned(
                                    top: 16,
                                    left: 12.0,
                                    right: 0.0,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Center(
                                                child: Text(
                                              _vm.community.token.symbol,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.left,
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
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
                    child: Column(
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
            // if (transfer.isJoinCommunity() &&
            //     isDefaultCommunity(_vm.communityAddress)) {
            //   Future.delayed(
            //       Duration.zero,
            //       () => showDialog(
            //           child: new DaiExplainedScreen(), context: context));
            // }
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
