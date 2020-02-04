import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/cash_home/dai_explained.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';

String deduceSign(Transfer transfer) {
  if (transfer.type == 'SEND') {
    return '-';
  } else {
    return '+';
  }
}

String deducePhoneNumber(Transfer transfer, Map<String, String> reverseContacts,
    {bool format = true}) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (reverseContacts.containsKey(accountAddress)) {
    return reverseContacts[accountAddress];
  }
  if (format) {
    return formatAddress(accountAddress);
  } else {
    return accountAddress;
  }
}

Contact getContact(Transfer transfer, Map<String, String> reverseContacts,
    List<Contact> contacts, String countryCode) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (accountAddress == null) {
    return null;
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    String phoneNumber = reverseContacts[accountAddress.toLowerCase()];
    if (contacts == null) return null;
    for (Contact contact in contacts) {
      for (Item contactPhoneNumber in contact.phones.toList()) {
        if (formatPhoneNumber(contactPhoneNumber.value, countryCode) ==
            phoneNumber) {
          return contact;
        }
      }
    }
  }
  return null;
}

dynamic getImage(Transfer transfer, Contact contact, CashWalletViewModel vm) {
  if (transfer.isJoinCommunity() &&
      vm.community.metadata.image != null &&
      vm.community.metadata.image != '') {
    return new NetworkImage(
        DotEnv().env['IPFS_BASE_URL'] + '/image/' + vm.community.metadata.image
        // 'assets/images/join_community.png',
        );
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
      (business) => business.account == accountAddress,
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
    List<Widget> rightColumn = <Widget>[
      transfer.isJoinCommunity() && isDefaultCommunity(_vm.communityAddress)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  InkWell(
                    onTap: () async {
                      Future.delayed(
                          Duration.zero,
                          () => showDialog(
                              child: new DaiExplainedScreen(),
                              context: context));
                      await FlutterSegment.track(
                          eventName: "Wallet: User open DAI points explanation",
                          properties: new Map<String, dynamic>());
                    },
                    child: SvgPicture.asset('assets/images/info_svg.svg'),
                  )
                ])
          : transfer.isGenerateWallet() || transfer.isJoinCommunity()
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
                                  ? ''
                                  : transfer.isPending()
                                      ? "contactSent"
                                      : "transaction" + transfer.txHash,
                            ),
                            transfer.isPending()
                                ? Container(
                                    width: 54,
                                    height: 54,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color(0xFF49D88D).withOpacity(0),
                                      strokeWidth:
                                          3, //backgroundColor: Color(0xFFb8e3a6),
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color(0xFF49D88D).withOpacity(1)),
                                    ))
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Text(
                            transfer.isJoinBonus()
                                ? I18n.of(context).join_bonus
                                : (transfer.receiverName != null &&
                                        transfer.receiverName != '')
                                    ? transfer.receiverName
                                    : transfer.text != null
                                        ? transfer.text
                                        : _contact != null
                                            ? _contact.displayName
                                            : deducePhoneNumber(
                                                transfer, _vm.reverseContacts),
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 2,
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
            if (transfer.isJoinCommunity() &&
                isDefaultCommunity(_vm.communityAddress)) {
              Future.delayed(
                  Duration.zero,
                  () => showDialog(
                      child: new DaiExplainedScreen(), context: context));
            }
            if (!transfer.isGenerateWallet() || !transfer.isJoinCommunity()) {
              Navigator.pushNamed(context, '/TransactionDetails',
                  arguments: TransactionDetailArguments(
                    transfer: transfer,
                    contact: _contact,
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
