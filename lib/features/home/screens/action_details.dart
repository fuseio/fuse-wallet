import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:decimal/decimal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/action_details.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';
import 'package:intl/intl.dart';

class ActionDetailsPage extends StatefulWidget {
  final String? accountAddress;
  final String displayName;
  final ImageProvider<Object>? image;
  final Contact? contact;
  final WalletAction action;
  final String symbol;

  const ActionDetailsPage({
    Key? key,
    required this.action,
    this.image,
    required this.displayName,
    this.accountAddress,
    required this.symbol,
    this.contact,
  }) : super(key: key);

  @override
  State<ActionDetailsPage> createState() => _ActionDetailsPageState();
}

class _ActionDetailsPageState extends SfWidget<ActionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.action.timestamp);
    final String name = widget.action.maybeMap(
      fiatDeposit: (_) => I10n.of(context).from,
      bonus: (_) => I10n.of(context).from,
      send: (_) => I10n.of(context).to,
      receive: (value) => I10n.of(context).from,
      swap: (_) => I10n.of(context).sell,
      receiveNFT: (value) => 'NFT ${I10n.of(context).received}',
      orElse: () => '',
    );

    final String title = widget.action.maybeMap(
      receiveNFT: (value) => 'NFT ${I10n.of(context).received}',
      bonus: (_) => I10n.of(context).bonus,
      send: (_) => I10n.of(context).send,
      receive: (value) => I10n.of(context).receive,
      swap: (value) => I10n.of(context).swap,
      orElse: () => '',
    );

    final TextStyle? runText = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF777777),
        );
    return StoreConnector<AppState, ActionDetailsViewModel>(
      distinct: true,
      converter: ActionDetailsViewModel.fromStore,
      builder: (_, viewModel) {
        final Token? token = widget.action.maybeMap(
          fiatDeposit: (value) =>
              viewModel.tokens[fuseDollarToken.address.toLowerCase()],
          bonus: (value) => viewModel.tokens[value.tokenAddress.toLowerCase()],
          send: (value) => viewModel.tokens[value.tokenAddress.toLowerCase()],
          receive: (value) =>
              viewModel.tokens[value.tokenAddress.toLowerCase()],
          swap: (value) => value.tradeInfo == null
              ? Token(
                  address: '',
                  name: '',
                  symbol: '',
                  amount: BigInt.zero,
                  decimals: 0,
                )
              : viewModel.tokens.values.firstWhere(
                  (element) => element.symbol == value.tradeInfo?.outputToken,
                ),
          orElse: () => null,
        );
        final String amount = (token?.hasPriceInfo ?? false)
            ? '${widget.action.getAmount(
                token?.priceInfo,
              )} (${widget.action.getAmount()} ${widget.symbol})'
            : '${widget.action.getAmount()} ${widget.symbol}';
        return InnerScaffold(
          title: title,
          hasScrollBody: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.action.getStatusIcon(),
                        Text(
                          (widget.action.isConfirmed()
                              ? I10n.of(context).approved
                              : widget.action.status),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          widget.action.maybeMap(
                            orElse: () => Text(name),
                            swap: (value) {
                              if (value.tradeInfo == null) {
                                return const SizedBox.shrink();
                              }
                              return Text(name);
                            },
                          ),
                          widget.action.maybeMap(
                            orElse: () => Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.displayName,
                                    overflow: TextOverflow.ellipsis,
                                    style: runText,
                                  ),
                                )
                              ],
                            ),
                            swap: (value) {
                              if (value.tradeInfo == null) {
                                return const SizedBox.shrink();
                              }
                              final Token token =
                                  viewModel.tokens.values.firstWhere(
                                (element) =>
                                    element.symbol ==
                                    value.tradeInfo!.inputToken,
                              );
                              final String amount = Formatter.isSmallThan(
                                      Decimal.parse(
                                          value.tradeInfo!.inputAmount))
                                  ? value.tradeInfo!.inputAmount
                                  : Formatter.smallNumbersConvertor(
                                      Decimal.parse(
                                          value.tradeInfo!.inputAmount));

                              double a = double.parse(
                                      value.tradeInfo?.inputAmount ?? '0') *
                                  double.parse(token.priceInfo!.quote);
                              final text =
                                  '${'$amount ${value.tradeInfo!.inputToken}'} (\$${Formatter.smallNumbersConvertor(Decimal.parse(a.toString()))})';
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      text,
                                      overflow: TextOverflow.ellipsis,
                                      style: runText,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    widget.action.maybeMap(
                      orElse: () => const SizedBox.shrink(),
                      swap: (value) {
                        if (value.tradeInfo == null) {
                          return const SizedBox.shrink();
                        }
                        return const Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            height: 1,
                          ),
                        );
                      },
                    ),
                    widget.action.maybeMap(
                      orElse: () => const SizedBox.shrink(),
                      swap: (value) {
                        if (value.tradeInfo == null) {
                          return const SizedBox.shrink();
                        }
                        return _RowItem(
                          title: I10n.of(context).receive,
                          value: widget.action.maybeMap(
                            orElse: () => '',
                            swap: (value) {
                              final String amount = Formatter.isSmallThan(
                                      Decimal.parse(
                                          value.tradeInfo?.outputAmount ?? '0'))
                                  ? value.tradeInfo?.outputAmount ?? '0'
                                  : Formatter.smallNumbersConvertor(
                                      Decimal.parse(
                                        value.tradeInfo?.outputAmount ?? '0',
                                      ),
                                    );

                              double val = double.parse(
                                      value.tradeInfo?.outputAmount ?? '0') *
                                  double.parse(token?.priceInfo?.quote ?? '0');
                              return '${'$amount ${value.tradeInfo?.outputToken ?? '0'}'} (\$${Formatter.smallNumbersConvertor(Decimal.parse(val.toString()))})';
                            },
                          ),
                        );
                      },
                    ),
                    [null, ''].contains(widget.accountAddress)
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 25),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                    [null, ''].contains(widget.accountAddress)
                        ? const SizedBox.shrink()
                        : _RowItem(
                            title: I10n.of(context).address,
                            value: Formatter.formatEthAddress(
                                widget.accountAddress),
                            withCopy: true,
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: widget.accountAddress,
                                ),
                              );
                              super.throwAlert(
                                context,
                                I10n.of(context).copied_to_clipboard,
                                type: AlertsTypeEnum.INFO,
                              );
                            },
                          ),
                    widget.action.isSwapAction() || widget.action.isNFTAction()
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 25),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                    widget.action.isSwapAction() || widget.action.isNFTAction()
                        ? const SizedBox.shrink()
                        : _RowItem(
                            title: I10n.of(context).amount,
                            value: amount,
                          ),
                    [null, ''].contains(widget.action.txHash)
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 25),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                    [null, ''].contains(widget.action.txHash)
                        ? const SizedBox.shrink()
                        : _RowItem(
                            title: I10n.of(context).txn,
                            value: Formatter.formatEthAddress(
                                widget.action.txHash),
                            withCopy: true,
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.action.txHash));
                              super.throwAlert(
                                context,
                                I10n.of(context).copied_to_clipboard,
                                type: AlertsTypeEnum.INFO,
                              );
                            },
                          ),
                    [null, '', 0].contains(widget.action.timestamp)
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 25),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                    [null, '', 0].contains(widget.action.timestamp)
                        ? const SizedBox.shrink()
                        : _RowItem(
                            title: I10n.of(context).date_and_time,
                            value: DateFormat('dd.MM.yy - hh:mm aaa')
                                .format(dateTime),
                          )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _RowItem extends StatelessWidget {
  final String title;
  final String value;
  final void Function()? onTap;
  final bool withCopy;
  const _RowItem({
    Key? key,
    required this.title,
    required this.value,
    this.onTap,
    this.withCopy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? runTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF777777),
            );
    if (withCopy) {
      return Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title),
            InkWell(
              focusColor: Theme.of(context).canvasColor,
              highlightColor: Theme.of(context).canvasColor,
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    const FaIcon(FontAwesomeIcons.copy).icon,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    value,
                    style: runTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title),
            Text(
              value,
              style: runTextStyle,
            )
          ],
        ),
      );
    }
  }
}
