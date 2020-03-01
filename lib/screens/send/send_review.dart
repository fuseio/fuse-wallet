import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
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
  final transferNoteController = TextEditingController(text: "");
  Animation<double> offset;
  bool isPreloading = false;
  var squareScaleA = 1.0;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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

  void send(SendAmountViewModel viewModel, SendAmountArguments args, String transferNote, VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
    if (args.accountAddress == null || args.accountAddress == '' && args.phoneNumber != null) {
      viewModel.sendToContact(
          args.name,
          formatPhoneNumber(args.phoneNumber, viewModel.myCountryCode),
          args.amount,
          args.name,
          transferNote,
          sendSuccessCallback,
          sendFailureCallback,
      );
    } else {
      viewModel.sendToAccountAddress(
        args.accountAddress,
        args.amount,
        args.name,
        transferNote,
        sendSuccessCallback,
        sendFailureCallback
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = ModalRoute.of(context).settings.arguments;

    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        return MainScaffold(
            titleFontSize: 15,
            withPadding: true,
            title: I18n.of(context).review_transfer,
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(I18n.of(context).amount,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                    Container(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Text(
                                "${args.amount} ${viewModel.token.symbol}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 45,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ],
                      ),
                    ),
                    // Text('What for?',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         color: Theme.of(context).primaryColor,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.normal)),
                    // Container(
                    //   width: 200,
                    //   padding: EdgeInsets.only(bottom: 30),
                    //   child: TextFormField(
                    //     controller: transferNoteController,
                    //     keyboardType: TextInputType.text,
                    //     // maxLength: 10,
                    //     autofocus: false,
                    //     decoration: const InputDecoration(
                    //         border: null, fillColor: Colors.transparent),
                    //     validator: (String value) {
                    //       if (value.split(" ").length > 10) {
                    //         return '10 characters max';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(I18n.of(context).to + ':',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 50.0, bottom: 50, left: 40, right: 40),
                  color: Theme.of(context).backgroundColor,
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
                                        radius: 30,
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    args.accountAddress == null ||
                                            args.accountAddress.isEmpty
                                        ? Text('')
                                        : Text(
                                            I18n.of(context).address +
                                                ": ${formatAddress(args.accountAddress)}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF777777)),
                                          )
                                  ]
                                : <Widget>[
                                    Text(
                                      I18n.of(context).address +
                                          ": ${formatAddress(args.accountAddress)}",
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
                args.accountAddress == null || args.accountAddress.isEmpty
                    ? Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 30, right: 30),
                        child: Text(
                            '''Sending money to ${args.name != null ? args.name : 'friend'} will automatically invite them to Fuse and let them redeem the funds you sent''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14)),
                      )
                    : SizedBox.shrink()
              ]))
            ],
            footer: Center(
                child: PrimaryButton(
                    label: I18n.of(context).send_button,
                    labelFontWeight: FontWeight.normal,
                    onPressed: () {
                      send(viewModel, args, transferNoteController.text, () {
                        Navigator.pushNamed(context, '/SendSuccess',
                            arguments: args);
                        setState(() {
                          isPreloading = false;
                        });
                        if (args.isBusiness != null && args.isBusiness) {
                          viewModel.idenyifyCall(Map.from({ "Transferred ${viewModel.community.name} - business": true }));
                          viewModel.trackTransferCall("Wallet: User Transfer - business");
                        } else if (args.accountAddress == null || args.accountAddress == '' && args.phoneNumber != null) {
                          viewModel.idenyifyCall(Map.from({ "Transferred ${viewModel.community.name} - contact": true }));
                          viewModel.trackTransferCall("Wallet: User Transfer - contact");
                        } else {
                          viewModel.idenyifyCall(Map.from({ "Transferred ${viewModel.community.name} - address": true }));
                          viewModel.trackTransferCall("Wallet: User Transfer - address");
                        }
                      }, () {
                        print('error');
                      });
                      setState(() {
                        isPreloading = true;
                      });
                    },
                    preload: isPreloading,
                    width: 180)));
      },
    );
  }
}
