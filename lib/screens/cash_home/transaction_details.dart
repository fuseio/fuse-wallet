import 'dart:core';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/transactions/transfer.dart';
import 'package:supervecina/utils/format.dart';
import 'package:supervecina/utils/transaction_row.dart';
import 'package:supervecina/widgets/main_scaffold.dart';

class TransactionDetailArguments {
  List<Widget> amount;
  String status;
  String from;
  String symbol;
  ImageProvider<dynamic> image;
  Contact contact;
  final Transfer transfer;
  final Map<String, String> reverseContacts;

  TransactionDetailArguments(
      {this.symbol,
      this.image,
      this.from,
      this.contact,
      this.amount,
      this.reverseContacts,
      this.transfer});
}

class TransactionDetailsScreen extends StatefulWidget {
  final TransactionDetailArguments pageArgs;
  TransactionDetailsScreen({this.pageArgs});
  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TransactionDetailArguments args = this.widget.pageArgs;
    return MainScaffold(
      withPadding: true,
      title: I18n.of(context).transaction_details,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          args.transfer.isFailed()
                              ? Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    'assets/images/failed.svg',
                                    width: 25,
                                    height: 25,
                                  ),
                                )
                              : args.transfer.isConfirmed()
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                          'assets/images/check.png',
                                          width: 25,
                                          height: 25),
                                    )
                                  : SizedBox.shrink(),
                          Text(
                              args.transfer.isConfirmed()
                                  ? I18n.of(context).approved
                                  : args?.transfer?.status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        top: 25.0, bottom: 25, left: 25, right: 25),
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(args.transfer.type == 'SEND'
                                  ? I18n.of(context).to
                                  : I18n.of(context).from),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFE0E0E0),
                                    radius: 22,
                                    backgroundImage: args.image,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      args.from,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            color: const Color(0xFFDCDCDC),
                            height: 1,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(I18n.of(context).amount),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Row(
                                children: args?.amount,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            color: const Color(0xFFDCDCDC),
                            height: 1,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(I18n.of(context).address),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(deducePhoneNumber(
                                  args.transfer, args.reverseContacts,
                                  getReverseContact: false)),
                            )
                          ],
                        ),
                        args.transfer.txHash == null ||
                                args.transfer.txHash.isEmpty
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 25),
                                child: Divider(
                                  color: const Color(0xFFDCDCDC),
                                  height: 1,
                                ),
                              ),
                        args.transfer.txHash == null ||
                                args.transfer.txHash.isEmpty
                            ? SizedBox.shrink()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text('Txn'),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text(
                                        formatAddress(args?.transfer?.txHash)),
                                  )
                                ],
                              ),
                        args.transfer.timestamp == null
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 25),
                                child: Divider(
                                  color: const Color(0xFFDCDCDC),
                                  height: 1,
                                ),
                              ),
                        args.transfer.timestamp == null
                            ? SizedBox.shrink()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text('Date'),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                                args.transfer.timestamp * 1000)
                                            .toString()),
                                  )
                                ],
                              )
                      ],
                    ),
                  )
                ]))
      ],
    );
  }
}
