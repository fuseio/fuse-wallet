import 'package:flutter/material.dart';
import 'package:fusecash/models/views/send_amount.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/utils/phone.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendReviewScreen extends StatefulWidget {
  @override
  _SendReviewScreenState createState() => _SendReviewScreenState();
}

class _SendReviewScreenState extends State<SendReviewScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> offset;
  bool isPreloading = false;
  var squareScaleA = 1.0;
  //AnimationController _controllerA;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    offset = Tween<double>(begin: 1, end: 3).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad))
      ..addListener(() {
        setState(() {});
      });
  }

  void send(SendAmountViewModel viewModel, SendAmountArguments args,
      VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
    if (args.phoneNumber != null) {
      viewModel.sendToContact(
          formatPhoneNumber(args.phoneNumber, viewModel.myCountryCode),
          args.amount,
          sendSuccessCallback,
          sendFailureCallback);
    } else {
      viewModel.sendToAccountAddress(args.accountAddress, args.amount,
          sendSuccessCallback, sendFailureCallback);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = ModalRoute.of(context).settings.arguments;

    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        return MainScaffold(
            withPadding: true,
            title: "Review transfer",
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text("Amount",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      Container(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 30),
                              child: Text(
                                  "${args.amount} ${viewModel.token.symbol}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text("To:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      )
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: ScaleTransition(
                                scale: offset,
                                child: Transform.translate(
                                    offset: Offset(offset.value * 10, 0),
                                    child: Hero(
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xFFE0E0E0),
                                        radius: 25,
                                        backgroundImage: args.avatar,
                                      ),
                                      tag: "contactSent",
                                    ))),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: args.name != null
                                ? <Widget>[
                                    Text(
                                      args.name,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    args.accountAddress == null ||
                                            args.accountAddress.isEmpty
                                        ? Text('')
                                        : Text(
                                            "Address: ${formatAddress(args.accountAddress)}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF777777)),
                                          )
                                  ]
                                : <Widget>[
                                    Text(
                                      "Address: ${formatAddress(args.accountAddress)}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF777777)),
                                    )
                                  ],
                          )
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
              labelFontWeight: FontWeight.normal,
              onPressed: () {
                send(viewModel, args, () {
                  Navigator.pushNamed(context, '/SendSuccess', arguments: args);
                  setState(() {
                    isPreloading = false;
                  });
                }, () {
                  print('error');
                });
                setState(() {
                  isPreloading = true;
                });
              },
              preload: isPreloading,
              width: 300,
            )));
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
