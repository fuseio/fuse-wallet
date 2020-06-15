import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/views/send_amount.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/screens/send/send_success.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SendReviewScreen extends StatefulWidget {
  final SendAmountArguments pageArgs;
  SendReviewScreen({this.pageArgs});
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
    Segment.screen(screenName: '/send-review-screen');

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    offset = Tween<double>(begin: 1, end: 3).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad))
      ..addListener(() {
        setState(() {});
      });
  }

  void send(
      SendAmountViewModel viewModel,
      SendAmountArguments args,
      String transferNote,
      VoidCallback sendSuccessCallback,
      VoidCallback sendFailureCallback) {
    if (viewModel.isProMode) {
      if (args.sendToCashMode) {
        viewModel.sendToCashMode(
            args.amount, sendSuccessCallback, sendFailureCallback);
      } else {
        viewModel.sendToErc20Token(args.erc20Token, args.accountAddress,
            args.amount, sendSuccessCallback, sendFailureCallback);
      }
    } else {
      if (args.accountAddress == null ||
          args.accountAddress == '' && args.phoneNumber != null) {
        viewModel.sendToContact(
          args.name,
          args.phoneNumber,
          args.amount,
          args.name,
          transferNote,
          sendSuccessCallback,
          sendFailureCallback,
        );
      } else {
        viewModel.sendToAccountAddress(args.accountAddress, args.amount,
            args.name, transferNote, sendSuccessCallback, sendFailureCallback);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = this.widget.pageArgs;
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        String symbol = args.erc20Token != null
            ? args.erc20Token.symbol
            : viewModel.token.symbol;
        BigInt balance = args.erc20Token == null
            ? viewModel.balance
            : args.erc20Token.amount;
        num feeAmount = 0;
        bool hasFund = true;
        if (args.feePlugin != null) {
          int decimals = args.erc20Token != null
              ? args.erc20Token.decimals
              : viewModel.token.decimals;
          feeAmount = args.feePlugin.calcFee(args.amount);
          num tokenBalance = num.parse(formatValue(balance, decimals));
          hasFund = (args.amount + feeAmount).compareTo(tokenBalance) <= 0;
        }
        return MainScaffold(
            withPadding: true,
            title: I18n.of(context).review_transfer,
            children: <Widget>[
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
                    padding: EdgeInsets.only(top: 40.0, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text('${args.amount} ',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w900)),
                        Text(symbol,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w900)),
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
              Column(children: <Widget>[
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
                                    args.phoneNumber == null ||
                                            args.phoneNumber.isEmpty
                                        ? SizedBox.shrink()
                                        : Text(
                                            args.phoneNumber,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                    args.accountAddress == null ||
                                            args.accountAddress.isEmpty
                                        ? SizedBox.shrink()
                                        : Text(
                                            I18n.of(context).address +
                                                ": ${formatAddress(args.accountAddress)}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xFF777777)),
                                          )
                                  ]
                                : <Widget>[
                                    Text(
                                      I18n.of(context).address +
                                          ": ${formatAddress(args.accountAddress)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF777777)),
                                    )
                                  ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                args.feePlugin != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Fee amount: ${feeAmount.toStringAsFixed(1)} $symbol',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF777777))),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Total amount: ${(args.amount + feeAmount).toStringAsFixed(1)} $symbol',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(
                            height: 10,
                          ),
                          !hasFund
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Text('Not enough balance in your account',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red)),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      )
                    : SizedBox.shrink(),
                viewModel.isProMode
                    ? SizedBox.shrink()
                    : (args.accountAddress == null ||
                            args.accountAddress.isEmpty)
                        ? Padding(
                            padding:
                                EdgeInsets.only(top: 20.0, left: 30, right: 30),
                            child: Text(
                                '''Sending money to ${args.name != null ? args.name : 'friend'} will automatically invite them to Fuse and let them redeem the funds you sent''',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 14)),
                          )
                        : SizedBox.shrink()
              ])
            ],
            footer: Center(
                child: PrimaryButton(
                    label: I18n.of(context).send_button,
                    labelFontWeight: FontWeight.normal,
                    onPressed: () {
                      if (args.feePlugin != null && !hasFund) {
                        return;
                      }
                      args.isProMode = viewModel.isProMode;
                      send(viewModel, args, transferNoteController.text, () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => SendSuccessScreen(
                                      pageArgs: args,
                                    )));
                        setState(() {
                          isPreloading = false;
                        });
                        String transferType = args.sendType
                                .toString()
                                .split('.')[1]
                                .toLowerCase() ??
                            '';
                        viewModel.idenyifyCall(Map.from(
                            {"Transferred ${viewModel.community.name}": true}));
                        viewModel.trackTransferCall("Wallet: User Transfer",
                            properties: Map.from({
                              'transfer type': transferType,
                              'network':
                                  viewModel.isProMode ? 'Ethereum' : 'Fuse'
                            }));
                      }, () {
                        // print('error');
                      });
                      setState(() {
                        isPreloading = true;
                      });
                    },
                    disabled: isPreloading,
                    preload: isPreloading,
                    width: 180)));
      },
    );
  }
}
