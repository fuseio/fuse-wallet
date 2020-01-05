import 'package:flutter/material.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:share/share.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class TransactionDetailArguments {
  String to;
  String accountAddress;
  List<Widget> amount;
  String status;
  String symbol;
  ImageProvider avatar;
  final Transaction transaction;

  TransactionDetailArguments(
      {this.status,
      this.to,
      this.symbol,
      this.accountAddress,
      this.amount,
      this.transaction,
      this.avatar});
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
      converter: (store) {
        return SendAmountViewModel.fromStore(store);
      },
      builder: (_, viewModel) {
        return MainScaffold(
            withPadding: true,
            title: "Transaction details",
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset('assets/images/check.png'),
                            ),
                            Text(args?.status,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 40.0, bottom: 40, left: 55, right: 55),
                  color: Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('To'),
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 25,
                                backgroundImage:
                                    new AssetImage('assets/images/anom.png'),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10),
                              child: Text(args.to),)
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Divider(
                          color: const Color(0xFFDCDCDC),
                          height: 1,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("Address"),
                          Text(formatAddress(args?.accountAddress))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Divider(
                          color: const Color(0xFFDCDCDC),
                          height: 1,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("Amount"),
                          Row(
                            children: args?.amount,
                          )
                        ],
                      ),
                      args.transaction.txHash == null || args.transaction.txHash.isEmpty ? Text('') : Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Divider(
                          color: const Color(0xFFDCDCDC),
                          height: 1,
                        ),
                      ),
                      args.transaction.txHash == null || args.transaction.txHash.isEmpty ? Text('') : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("Txn"),
                          Text('${args?.transaction?.txHash?.substring(0, 7)}...${args?.transaction?.txHash?.substring(args?.transaction?.txHash?.length - 7)}')
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Fee: covered by fuse",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)))
              ]))
            ],
            footer: Center(
                child: PrimaryButton(
              label: "Share",
              onPressed: () {
                Share.share(args.accountAddress);
                // Navigator.pushNamed(context, '/SendSuccess');

                //controller.forward();

                //Future.delayed(const Duration(milliseconds: 1000), () {
//Navigator.pushNamed(context, '/Cash');
//});

                //var timer = Timer(Duration(seconds: 1), () => Navigator.pushNamed(context, '/Cash'));
                //timer.cancel();

/*

                Navigator.push(
    context,
    SlideRightRoute(page: CashHomeScreen()),
  );*/

/*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      transitionDuration: Duration(seconds: 1),
                      pageBuilder: (_, __, ___) => CashHomeScreen()));
*/

                /*send(viewModel, args, amountText, () {
                    Navigator.popAndPushNamed(context, '/Cash');
                    setState(() {
                      isPreloading = false;
                    });
                  }, () {
                    print('error');
                  });
                  setState(() {
                    isPreloading = true;
                  });*/
              },
              preload: false,
              width: 300,
            )));
      },
    );
  }
}

class SendAmountViewModel {
  final String myCountryCode;
  final Function(String, num, VoidCallback, VoidCallback) sendToContact;
  final Function(String, num, VoidCallback, VoidCallback) sendToAccountAddress;

  SendAmountViewModel(
      {this.myCountryCode, this.sendToContact, this.sendToAccountAddress});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    return SendAmountViewModel(
        myCountryCode: store.state.userState.countryCode,
        sendToContact: (String phoneNumber,
            num amount,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback) {
          store.dispatch(sendTokenToContactCall(
              phoneNumber, amount, sendSuccessCallback, sendFailureCallback));
        },
        sendToAccountAddress: (String recieverAddress,
            num amount,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback) {
          store.dispatch(sendTokenCall(recieverAddress, amount,
              sendSuccessCallback, sendFailureCallback));
        });
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
