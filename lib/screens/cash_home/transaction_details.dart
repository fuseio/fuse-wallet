import 'package:flutter/material.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

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
    final SendAmountArguments args = ModalRoute.of(context).settings.arguments;

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
                        padding: EdgeInsets.only(top: 30, bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset('assets/images/check.png'),
                            ),
                            Text("Approved",
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
                      top: 50.0, bottom: 50, left: 40, right: 40),
                  color: Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only( right: 40),
                          child:  Text("To"),)
                         ,
                          CircleAvatar(
                            backgroundColor: Color(0xFFE0E0E0),
                            radius: 25,
                            backgroundImage:
                                new AssetImage('assets/images/anom.png'),
                          )
                        ],
                      ),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only( right: 40),
                          child:  Text("Address"),)
                         ,
                          Text("0x7c06…bF56f2")
                        ],
                      ),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only( right: 40),
                          child:  Text("Amount"),)
                         ,
                          Text("50 FFU")
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
              label: "Send",
              onPressed: () {
                Navigator.pushNamed(context, '/SendSuccess');

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
