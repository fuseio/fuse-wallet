import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class SendReviewPage extends StatefulWidget {
  final SendFlowArguments pageArgs;
  const SendReviewPage({required this.pageArgs, Key? key}) : super(key: key);
  @override
  State<SendReviewPage> createState() => _SendReviewPageState();
}

class _SendReviewPageState extends SfWidget<SendReviewPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
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
        vsync: this, duration: const Duration(milliseconds: 2000));

    offset = Tween<double>(begin: 1, end: 3).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutQuad,
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  void send(
    SendAmountViewModel viewModel,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) {
    if (widget.pageArgs.collectible != null) {
      viewModel.sendERC721(
        widget.pageArgs.collectible!,
        sendSuccessCallback,
        sendFailureCallback,
        phoneNumber: widget.pageArgs.phoneNumber,
        receiverAddress: widget.pageArgs.accountAddress,
      );
    } else {
      if (widget.pageArgs.accountAddress == null ||
          widget.pageArgs.accountAddress == '' &&
              widget.pageArgs.phoneNumber != null) {
        viewModel.sendToContact(
          widget.pageArgs.tokenToSend!,
          widget.pageArgs.phoneNumber!,
          widget.pageArgs.amount!,
          sendSuccessCallback,
          sendFailureCallback,
        );
      } else {
        viewModel.sendToAccountAddress(
          widget.pageArgs.tokenToSend!,
          widget.pageArgs.accountAddress!,
          widget.pageArgs.amount!,
          sendSuccessCallback,
          sendFailureCallback,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SendAmountViewModel>(
      distinct: true,
      converter: SendAmountViewModel.fromStore,
      builder: (_, viewModel) {
        return InnerScaffold(
          title: I10n.of(context).review_transfer,
          bottomContent: GradientButton(
            textColor: Theme.of(context).canvasColor,
            width: MediaQuery.of(context).size.width * .9,
            text: I10n.of(context).send_button,
            preload: isPreloading,
            onPressed: () {
              if (!isPreloading) {
                setState(() {
                  isPreloading = true;
                });
                send(
                  viewModel,
                  () {
                    context.router.push(
                      SendSuccessRoute(
                        pageArgs: widget.pageArgs,
                      ),
                    );
                  },
                  () {
                    setState(() {
                      isPreloading = false;
                    });
                    super.throwAlert(
                      context,
                      I10n.of(context).something_went_wrong,
                      type: AlertsTypeEnum.ERROR,
                    );
                  },
                );
              }
            },
          ),
          body: SizedBox(
            height: 1,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    if (widget.pageArgs.collectible != null)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 30,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: boxShadow,
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    width: 280,
                                    height: 280,
                                    imageUrl:
                                        widget.pageArgs.collectible!.imageURL,
                                    errorWidget: (context, url, error) =>
                                        const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/anom.png'),
                                      radius: 30,
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Image(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    widget.pageArgs.collectible!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              I10n.of(context).amount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 30.0,
                              bottom: 30,
                              left: 30,
                              right: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Expanded(
                                  child: AutoSizeText.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${widget.pageArgs.amount} ',
                                        ),
                                        TextSpan(
                                          text: widget
                                              .pageArgs.tokenToSend!.symbol,
                                        ),
                                      ],
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w900,
                                        ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    presetFontSizes: const [
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
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 50.0,
                            bottom: 50,
                            left: 40,
                            right: 40,
                          ),
                          decoration: BoxDecoration(
                            border: const Border(
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
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: ScaleTransition(
                                      scale: offset,
                                      child: Transform.translate(
                                        offset: Offset(offset.value * 10, 0),
                                        child: Hero(
                                          tag: "contactSent",
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            radius: 30,
                                            backgroundImage:
                                                widget.pageArgs.avatar,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: widget.pageArgs.name != null
                                        ? [
                                            Text(
                                              widget.pageArgs.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontSize: 18,
                                                  ),
                                            ),
                                            widget.pageArgs.phoneNumber ==
                                                        null ||
                                                    widget.pageArgs.phoneNumber!
                                                        .isEmpty
                                                ? const SizedBox.shrink()
                                                : Text(
                                                    widget
                                                        .pageArgs.phoneNumber!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontSize: 13,
                                                        ),
                                                  ),
                                            widget.pageArgs.accountAddress ==
                                                        null ||
                                                    widget.pageArgs
                                                        .accountAddress!.isEmpty
                                                ? const SizedBox.shrink()
                                                : Text(
                                                    "${I10n.of(context).address}: ${Formatter.formatEthAddress(widget.pageArgs.accountAddress)}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: const Color(
                                                            0xFF777777,
                                                          ),
                                                        ),
                                                  ),
                                          ]
                                        : [
                                            Text(
                                              "${I10n.of(context).address}: ${Formatter.formatEthAddress(widget.pageArgs.accountAddress)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: const Color(
                                                      0xFF777777,
                                                    ),
                                                  ),
                                            ),
                                          ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        (widget.pageArgs.accountAddress == null ||
                                widget.pageArgs.accountAddress!.isEmpty)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 30, right: 30),
                                child: Text(
                                  I10n.of(context).invite_text(
                                    widget.pageArgs.name ??
                                        I10n.of(context).friend,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
