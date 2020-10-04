import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/views/send_amount.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/screens/contacts/send_amount_arguments.dart';
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
    final bool isFuseToken =
        ![null, ''].contains(args?.tokenToSend?.originNetwork) ?? false;
    if (args.useBridge && args.isMultiBridge) {
      if (isFuseToken) {
        viewModel.sendToForeignMultiBridge(
          args.tokenToSend,
          args.accountAddress,
          args.amount,
          sendSuccessCallback,
          sendFailureCallback,
        );
      } else {
        viewModel.sendToHomeMultiBridge(
          args.tokenToSend,
          args.accountAddress,
          args.amount,
          sendSuccessCallback,
          sendFailureCallback,
        );
      }
    } else {
      if (!isFuseToken) {
        if (args.accountAddress == null ||
            args.accountAddress == '' && args.phoneNumber != null) {
          viewModel.sendERC20ToContact(
            args.tokenToSend,
            args.name,
            args.phoneNumber,
            args.amount,
            sendSuccessCallback,
            sendFailureCallback,
            receiverName: args.name,
            transferNote: transferNote,
          );
        } else {
          viewModel.sendToErc20Token(args.tokenToSend, args.accountAddress,
              args.amount, sendSuccessCallback, sendFailureCallback);
        }
      } else {
        if (args.accountAddress == null ||
            args.accountAddress == '' && args.phoneNumber != null) {
          viewModel.sendToContact(
            args.tokenToSend,
            args.accountAddress,
            args.amount,
            sendSuccessCallback,
            sendFailureCallback,
            transferNote: transferNote,
          );
        } else {
          viewModel.sendToAccountAddress(
            args.tokenToSend,
            args.accountAddress,
            args.amount,
            sendSuccessCallback,
            sendFailureCallback,
            receiverName: args.name,
            transferNote: transferNote,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = this.widget.pageArgs;
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        final String symbol = args.tokenToSend.symbol;
        final BigInt balance = args.tokenToSend.amount;
        final int decimals = args.tokenToSend.decimals;
        final bool withFee = args.isMultiBridge ||
            args.useBridge ||
            (fees.containsKey(symbol) &&
                args.tokenToSend.originNetwork == null) ||
            (viewModel.communities.any((element) =>
                (args?.accountAddress?.toLowerCase() ==
                    element?.homeBridgeAddress?.toLowerCase()) ||
                (args?.accountAddress?.toLowerCase() ==
                    element?.foreignBridgeAddress?.toLowerCase()) ||
                args?.tokenToSend?.address?.toLowerCase() ==
                    element?.foreignTokenAddress?.toLowerCase()));
        final num feeAmount =
            withFee ? (fees.containsKey(symbol) ? fees[symbol] : 20) : 0;
        final num currentTokenBalance =
            num.parse(formatValue(balance, decimals));
        final bool hasFund =
            (args.amount + feeAmount).compareTo(currentTokenBalance) <= 0;
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
                        AutoSizeText.rich(TextSpan(children: [
                          TextSpan(
                            text: '${args.amount} ',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w900),
                          ),
                          TextSpan(
                            text: symbol,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ])),
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
                withFee
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              I18n.of(context).fee_amount +
                                  ' ${feeAmount.toStringAsFixed(1)} $symbol',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF777777))),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              I18n.of(context).total_amount +
                                  ' ${(args.amount + feeAmount).toStringAsFixed(1)} $symbol',
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
                                      child: Text(
                                          I18n.of(context).not_enough_balance,
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
                args.tokenToSend.originNetwork == null
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
                      if (withFee && !hasFund) return;
                      send(viewModel, args, transferNoteController.text, () {
                        ExtendedNavigator.root.replace(Routes.sendSuccessScreen,
                            arguments:
                                SendSuccessScreenArguments(pageArgs: args));
                      }, () {
                        setState(() {
                          isPreloading = false;
                        });
                        // print('error');
                      });
                      setState(() {
                        isPreloading = true;
                      });
                    },
                    disabled: isPreloading || !hasFund,
                    preload: isPreloading,
                    width: 180)));
      },
    );
  }
}
