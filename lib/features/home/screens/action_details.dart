import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/action_details.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/snackbars.dart';
import 'package:intl/intl.dart';

class ActionDetailsScreen extends StatelessWidget {
  final String? accountAddress;
  final String displayName;
  final ImageProvider<Object>? image;
  final Contact? contact;
  final WalletAction action;
  final String symbol;

  ActionDetailsScreen({
    required this.action,
    this.image,
    required this.displayName,
    this.accountAddress,
    required this.symbol,
    this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(action.timestamp);
    final String name = action.map(
      createWallet: (_) => '',
      joinCommunity: (_) => '',
      fiatDeposit: (_) => I10n.of(context).from,
      bonus: (_) => I10n.of(context).from,
      send: (_) => I10n.of(context).to,
      receive: (value) => I10n.of(context).from,
      swap: (_) => I10n.of(context).sell,
    );

    final String title = action.map(
      createWallet: (_) => '',
      joinCommunity: (_) => '',
      fiatDeposit: (_) => '',
      bonus: (_) => I10n.of(context).bonus,
      send: (_) => I10n.of(context).send,
      receive: (value) => I10n.of(context).receive,
      swap: (value) => I10n.of(context).swap,
    );

    return new StoreConnector<AppState, ActionDetailsViewModel>(
      distinct: true,
      converter: ActionDetailsViewModel.fromStore,
      builder: (_, viewModel) {
        final Token? token = action.map(
          createWallet: (value) => null,
          joinCommunity: (value) => null,
          fiatDeposit: (value) =>
              viewModel.tokens[fuseDollarToken.address.toLowerCase()],
          bonus: (value) => viewModel.tokens[value.tokenAddress.toLowerCase()],
          send: (value) => viewModel.tokens[value.tokenAddress.toLowerCase()],
          receive: (value) =>
              viewModel.tokens[value.tokenAddress.toLowerCase()],
          swap: (value) => viewModel.tokens.values.firstWhere(
            (element) => element.symbol == value.tradeInfo?.outputToken,
          ),
        );
        final bool hasPriceInfo =
            ![null, '', '0', 0, 'NaN'].contains(token!.priceInfo!.quote);
        final String amount = hasPriceInfo
            ? '\$' +
                action.getAmount(
                  priceInfo: token.priceInfo,
                ) +
                ' (' +
                action.getAmount() +
                ' ' +
                symbol +
                ')'
            : action.getAmount() + ' $symbol';
        return MyScaffold(
          title: title,
          body: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          action.getStatusIcon(),
                          Text(
                            (action.isConfirmed()
                                ? I10n.of(context).approved
                                : action.status),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    // action.isFailed()
                    //     ? Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           Text(I10n.of(context).transaction_failed,
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.normal)),
                    //           Text(
                    //               transfer?.failReason ??
                    //                   I10n.of(context).something_went_wrong,
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                   color: Theme.of(context).accentColor,
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.normal))
                    //         ],
                    //       )
                    //     : SizedBox.shrink(),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 25.0, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(name),
                            Row(
                              children: <Widget>[
                                action.isSwapAction()
                                    ? SizedBox.shrink()
                                    : CircleAvatar(
                                        backgroundColor: Color(0xFFE0E0E0),
                                        radius: 22,
                                        backgroundImage: image,
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    action.isSwapAction()
                                        ? action.map(
                                            createWallet: (value) => '',
                                            joinCommunity: (value) => '',
                                            fiatDeposit: (value) => '',
                                            bonus: (value) => '',
                                            send: (value) => '',
                                            receive: (value) => '',
                                            swap: (value) {
                                              final Token _token = viewModel
                                                  .tokens.values
                                                  .firstWhere(
                                                (element) =>
                                                    element.symbol ==
                                                    value.tradeInfo!.inputToken,
                                              );
                                              final String amount =
                                                  smallNumberTest(num.parse(
                                                          value.tradeInfo!
                                                              .inputAmount))
                                                      ? value.tradeInfo!
                                                          .inputAmount
                                                      : smallValuesConvertor(
                                                          num.parse(value
                                                              .tradeInfo!
                                                              .inputAmount));

                                              double a = double.parse(value
                                                          .tradeInfo
                                                          ?.inputAmount ??
                                                      '0') *
                                                  double.parse(
                                                      _token.priceInfo!.quote);
                                              return '${amount + ' ' + value.tradeInfo!.inputToken} (\$${display(num.tryParse(a.toString()))})';
                                            },
                                          )
                                        : displayName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryVariant,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      !action.isSwapAction()
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Divider(
                                height: 1,
                              ),
                            ),

                      !action.isSwapAction()
                          ? SizedBox.shrink()
                          : rowItem(
                              context,
                              I10n.of(context).receive,
                              action.map(
                                createWallet: (value) => '',
                                joinCommunity: (value) => '',
                                fiatDeposit: (value) => '',
                                bonus: (value) => '',
                                send: (value) => '',
                                receive: (value) => '',
                                swap: (value) {
                                  final String amount = smallNumberTest(
                                          num.parse(
                                              value.tradeInfo!.outputAmount))
                                      ? value.tradeInfo!.outputAmount
                                      : smallValuesConvertor(num.parse(
                                          value.tradeInfo!.outputAmount));

                                  double val = double.parse(
                                          value.tradeInfo!.outputAmount) *
                                      double.parse(token.priceInfo!.quote);
                                  return '${amount + ' ' + value.tradeInfo!.outputToken} (\$${display(num.tryParse(val.toString()))})';
                                },
                              ),
                            ),
                      [null, ''].contains(accountAddress)
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Divider(
                                height: 1,
                              ),
                            ),

                      [null, ''].contains(accountAddress)
                          ? SizedBox.shrink()
                          : rowItem(
                              context,
                              I10n.of(context).address,
                              formatAddress(accountAddress),
                              withCopy: true,
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: accountAddress,
                                  ),
                                );
                                showCopiedFlushbar(context);
                              },
                            ),
                      action.isSwapAction()
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Divider(
                                height: 1,
                              ),
                            ),
                      action.isSwapAction()
                          ? SizedBox.shrink()
                          : rowItem(
                              context,
                              I10n.of(context).amount,
                              amount,
                            ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 25, bottom: 25),
                      //   child: Divider(
                      //     color: Theme.of(context).dividerColor,
                      //     height: 1,
                      //   ),
                      // ),
                      // rowItem(context, I10n.of(context).network,
                      //     action.originNetwork != null ? 'Fuse' : 'Ethereum'),
                      [null, ''].contains(action.txHash)
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Divider(
                                color: Theme.of(context).dividerColor,
                                height: 1,
                              ),
                            ),
                      [null, ''].contains(action.txHash)
                          ? SizedBox.shrink()
                          : rowItem(
                              context,
                              I10n.of(context).txn,
                              formatAddress(action.txHash),
                              withCopy: true,
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: action.txHash));
                                showCopiedFlushbar(context);
                              },
                            ),
                      [null, '', 0].contains(action.timestamp)
                          ? SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Divider(
                                color: Theme.of(context).dividerColor,
                                height: 1,
                              ),
                            ),
                      [null, '', 0].contains(action.timestamp)
                          ? SizedBox.shrink()
                          : rowItem(
                              context,
                              I10n.of(context).date_and_time,
                              DateFormat('dd.MM.yy - hh:mm aaa')
                                  .format(dateTime),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget rowItem(
    BuildContext context,
    String title,
    String value, {
    void Function()? onTap,
    bool withCopy = false,
  }) {
    if (withCopy) {
      return Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
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
                    FaIcon(FontAwesomeIcons.copy).icon,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(title),
            Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            )
          ],
        ),
      );
    }
  }
}
