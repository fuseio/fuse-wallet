import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:fusecash/models/views/send_amount.dart';
import 'package:fusecash/screens/cash_home/transaction_row.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TransactionDetailArguments args =
        ModalRoute.of(context).settings.arguments;

    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        return MainScaffold(
          withPadding: true,
          titleFontSize: 15,
          title: I18n.of(context).transaction_details,
          children: <Widget>[
            Container(
                child: Column(children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          args.transfer.isConfirmed()
                              ? Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Image.asset('assets/images/check.png',
                                      width: 25, height: 25),
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
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 40.0, bottom: 40, left: 50, right: 50),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: Text(I18n.of(context).to),
                        ),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Color(0xFFE0E0E0),
                              radius: 25,
                              backgroundImage: args.image,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(args.from))
                          ],
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
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: Text(I18n.of(context).amount),
                        ),
                        Row(
                          children: args?.amount,
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
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: Text(I18n.of(context).address),
                        ),
                        Text(deducePhoneNumber(
                            args.transfer, args.reverseContacts))
                      ],
                    ),
                    args.transfer.txHash == null || args.transfer.txHash.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 25),
                            child: Divider(
                              color: const Color(0xFFDCDCDC),
                              height: 1,
                            ),
                          ),
                    args.transfer.txHash == null || args.transfer.txHash.isEmpty
                        ? SizedBox.shrink()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text('Txn'),
                              ),
                              Text(
                                  '${args?.transfer?.txHash?.substring(0, 7)}...${args?.transfer?.txHash?.substring(args.transfer.txHash.length - 7)}')
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
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text('Date'),
                              ),
                              Text(new DateTime.fromMillisecondsSinceEpoch(
                                      args.transfer.timestamp * 1000)
                                  .toString())
                            ],
                          )
                  ],
                ),
              )
            ]))
          ],
        );
      },
    );
  }
}
