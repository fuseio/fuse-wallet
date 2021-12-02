import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/redux/viewsmodels/send_amount.dart';
import 'package:supervecina/common/router/routes.dart';
import 'package:supervecina/features/contacts/send_amount_arguments.dart';
import 'package:supervecina/utils/format.dart';
import 'package:supervecina/features/shared/widgets/my_scaffold.dart';
import 'package:supervecina/features/shared/widgets/primary_button.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SendReviewScreen extends StatefulWidget {
  final SendFlowArguments pageArgs;
  SendReviewScreen({required this.pageArgs});
  @override
  _SendReviewScreenState createState() => _SendReviewScreenState();
}

class _SendReviewScreenState extends State<SendReviewScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final transferNoteController = TextEditingController(text: "");
  late Animation<double> offset;
  bool isPreloading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    offset = Tween<double>(begin: 1, end: 3).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad))
      ..addListener(() {
        setState(() {});
      });
  }

  void send(
    SendAmountViewModel viewModel,
    SendFlowArguments args,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) {
    if (args.accountAddress == null ||
        args.accountAddress == '' && args.phoneNumber != null) {
      viewModel.sendToContact(
        args.tokenToSend!,
        args.phoneNumber!,
        args.amount!,
        sendSuccessCallback,
        sendFailureCallback,
      );
    } else {
      viewModel.sendToAccountAddress(
        args.tokenToSend!,
        args.accountAddress!,
        args.amount!,
        sendSuccessCallback,
        sendFailureCallback,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final SendFlowArguments args = widget.pageArgs;
    return MyScaffold(
      title: I10n.of(context).review_transfer,
      body: StoreConnector<AppState, SendAmountViewModel>(
        converter: SendAmountViewModel.fromStore,
        builder: (_, viewModel) {
          final String symbol = args.tokenToSend!.symbol;
          return Container(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Text(
                          I10n.of(context).amount,
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
                                              args.name!,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            args.phoneNumber == null ||
                                                    args.phoneNumber!.isEmpty
                                                ? SizedBox.shrink()
                                                : Text(
                                                    args.phoneNumber!,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                            args.accountAddress == null ||
                                                    args.accountAddress!.isEmpty
                                                ? SizedBox.shrink()
                                                : Text(
                                                    I10n.of(context).address +
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
                                              I10n.of(context).address +
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
                        args.tokenToSend?.originNetwork == null
                            ? SizedBox.shrink()
                            : (args.accountAddress == null ||
                                    args.accountAddress!.isEmpty)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, left: 30, right: 30),
                                    child: Text(
                                      I10n.of(context).invite_text(
                                        args.name != null
                                            ? args.name!
                                            : I10n.of(context).friend,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
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
                        label: I10n.of(context).send_button,
                        disabled: isPreloading,
                        preload: isPreloading,
                        onPressed: () {
                          if (!isPreloading) {
                            setState(() {
                              isPreloading = true;
                            });
                            send(viewModel, args, () {
                              context.router.push(
                                SendSuccessScreen(
                                  pageArgs: args,
                                ),
                              );
                            }, () {
                              setState(() {
                                isPreloading = false;
                              });
                            });
                          }
                        },
                      ),
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
