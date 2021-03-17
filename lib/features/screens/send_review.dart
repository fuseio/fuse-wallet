import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
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
    VoidCallback sendFailureCallback,
  ) {
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
          viewModel.sendToErc20Token(
            args.tokenToSend,
            args.accountAddress,
            args.amount,
            sendSuccessCallback,
            sendFailureCallback,
          );
        }
      } else {
        if (args.accountAddress == null ||
            args.accountAddress == '' && args.phoneNumber != null) {
          viewModel.sendToContact(
            args.tokenToSend,
            args.phoneNumber,
            args.amount,
            sendSuccessCallback,
            sendFailureCallback,
            receiverName: args.name,
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
    return MyScaffold(
      title: I18n.of(context).review_transfer,
      body: StoreConnector<AppState, SendAmountViewModel>(
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
                  (args?.accountAddress != null &&
                      args?.accountAddress?.toLowerCase() ==
                          element?.homeBridgeAddress?.toLowerCase()) ||
                  (args?.accountAddress != null &&
                      args?.accountAddress?.toLowerCase() ==
                          element?.foreignBridgeAddress?.toLowerCase()) ||
                  args?.tokenToSend?.address != null &&
                      args?.tokenToSend?.address?.toLowerCase() ==
                          element?.foreignTokenAddress?.toLowerCase()));
          final num feeAmount =
              withFee ? (fees.containsKey(symbol) ? fees[symbol] : 20) : 0;
          final num currentTokenBalance =
              num.parse(formatValue(balance, decimals, withPrecision: true));
          final bool hasFund =
              (args.amount + feeAmount).compareTo(currentTokenBalance) <= 0;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          I18n.of(context).amount,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 30.0,
                            bottom: 30,
                            left: 30,
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Expanded(
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${args.amount} ',
                                      ),
                                      TextSpan(text: symbol),
                                    ],
                                  ),
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  minFontSize: 20,
                                  maxFontSize: 50,
                                  presetFontSizes: [
                                    50,
                                    30,
                                    20,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 50.0,
                            bottom: 50,
                            left: 40,
                            right: 40,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFFDDDDDD),
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFDDDDDD),
                              ),
                            ),
                            color: Theme.of(context).backgroundColor,
                          ),
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
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                            args.accountAddress == null ||
                                                    args.accountAddress.isEmpty
                                                ? SizedBox.shrink()
                                                : Text(
                                                    I18n.of(context).address +
                                                        ": ${formatAddress(args.accountAddress)}",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryVariant,
                                                    ),
                                                  )
                                          ]
                                        : <Widget>[
                                            Text(
                                              I18n.of(context).address +
                                                  ": ${formatAddress(args.accountAddress)}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryVariant,
                                              ),
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
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryVariant,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      I18n.of(context).total_amount +
                                          ' ${(args.amount + feeAmount).toStringAsFixed(1)} $symbol',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  !hasFund
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.error,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 7),
                                              child: Text(
                                                I18n.of(context)
                                                    .not_enough_balance,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red,
                                                ),
                                              ),
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
                                    padding: EdgeInsets.only(
                                        top: 20.0, left: 30, right: 30),
                                    child: Text(
                                      '''Sending money to ${args.name != null ? args.name : 'friend'} will automatically invite them to Fuse and let them redeem the funds you sent''',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: PrimaryButton(
                        label: I18n.of(context).send_button,
                        disabled: isPreloading || !hasFund,
                        preload: isPreloading,
                        onPressed: () {
                          if (withFee && !hasFund) return;
                          send(viewModel, args, transferNoteController.text,
                              () {
                            ExtendedNavigator.root.replace(
                                Routes.sendSuccessScreen,
                                arguments:
                                    SendSuccessScreenArguments(pageArgs: args));
                          }, () {
                            setState(() {
                              isPreloading = false;
                            });
                          });
                          setState(() {
                            isPreloading = true;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
