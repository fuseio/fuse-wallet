import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/models/views/send_amount.dart';
import 'package:paywise/screens/cash_home/cash_transactions.dart';
import 'package:paywise/widgets/main_scaffold.dart';
import 'package:paywise/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class TransactionDetailArguments {
  List<Widget> amount;
  String status;
  String symbol;
  Contact contact;
  final Transfer transfer;
  final Map<String, String> reverseContacts;

  TransactionDetailArguments(
      {this.symbol,
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
  Widget build(BuildContext context) {
    final TransactionDetailArguments args =
        ModalRoute.of(context).settings.arguments;

    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        dynamic displayName =
            deducePhoneNumber(args.transfer, args.reverseContacts);
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
                          width: 135,
                          child: Text(I18n.of(context).to),
                        ),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Color(0xFFE0E0E0),
                              radius: 25,
                              backgroundImage: args.transfer.isJoinBonus()
                                  ? new AssetImage(
                                      'assets/images/join.png',
                                    )
                                  : args.contact?.avatar != null
                                      ? MemoryImage(args.contact.avatar)
                                      : new AssetImage(
                                          'assets/images/anom.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: args.transfer.isJoinBonus()
                                  ? Text('Join bonus')
                                  : SizedBox(
                                      width: 110,
                                      child: Text(
                                        (args.transfer.receiverName != null &&
                                                args.transfer.receiverName !=
                                                    '')
                                            ? args.transfer.receiverName
                                            : args.transfer.text != null
                                                ? args.transfer.text
                                                : args.contact != null
                                                    ? args.contact.displayName
                                                    : displayName,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                            )
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
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 135,
                          child: Text(I18n.of(context).address),
                        ),
                        displayName == null
                            ? SizedBox.shrink()
                            : Text(displayName)
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
                          width: 135,
                          child: Text(I18n.of(context).amount),
                        ),
                        Row(
                          children: args?.amount,
                        )
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
                                width: 135,
                                child: Text('Txn'),
                              ),
                              Text(
                                  '${args?.transfer?.txHash?.substring(0, 7)}...${args?.transfer?.txHash?.substring(args.transfer.txHash.length - 7)}')
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

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            /* transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),*/
            transitionDuration: Duration(seconds: 1));
}
