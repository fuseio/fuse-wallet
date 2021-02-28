import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class ActionDetailsScreen extends StatelessWidget {
  final String accountAddress;
  final String displayName;
  final ImageProvider<dynamic> image;
  final Contact contact;
  final WalletAction action;
  final String symbol;

  ActionDetailsScreen({
    this.action,
    this.image,
    this.displayName,
    this.accountAddress,
    this.symbol,
    this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final String name = action.map(
      createWallet: (_) => '',
      fiatProcess: (_) => '',
      joinCommunity: (_) => '',
      fiatDeposit: (_) => I18n.of(context).from,
      bonus: (_) => I18n.of(context).from,
      send: (_) => I18n.of(context).to,
      receive: (value) => I18n.of(context).from,
    );

    final String title = action.map(
      createWallet: (_) => '',
      fiatProcess: (_) => '',
      joinCommunity: (_) => '',
      fiatDeposit: (_) => '',
      bonus: (_) => I18n.of(context).bonus,
      send: (_) => I18n.of(context).send,
      receive: (value) => I18n.of(context).receive,
    );
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
                        action.isConfirmed()
                            ? I18n.of(context).approved
                            : action?.status,
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
                //           Text(I18n.of(context).transaction_failed,
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.normal)),
                //           Text(
                //               transfer?.failReason ??
                //                   I18n.of(context).something_went_wrong,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Text(name),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Row(
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 22,
                                backgroundImage: image,
                              ),
                              tag: action.hashCode,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  displayName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  rowItem(
                    context,
                    I18n.of(context).address,
                    formatAddress(accountAddress),
                    withCopy: true,
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: accountAddress,
                        ),
                      );
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            I18n.of(context).copied_to_clipboard,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  rowItem(
                    context,
                    I18n.of(context).amount,
                    '${action.getAmount()} ${symbol}',
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 25, bottom: 25),
                  //   child: Divider(
                  //     color: Theme.of(context).dividerColor,
                  //     height: 1,
                  //   ),
                  // ),
                  // rowItem(context, I18n.of(context).network,
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
                          'Txn',
                          formatAddress(action?.txHash),
                          withCopy: true,
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: action?.txHash));
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  I18n.of(context).copied_to_clipboard,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowItem(
    BuildContext context,
    String title,
    String value, {
    void Function() onTap,
    bool withCopy = false,
  }) {
    if (withCopy) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: Text(title),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    FaIcon(FontAwesomeIcons.copy).icon,
                    size: 14,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: Text(title),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            ),
          )
        ],
      );
    }
  }
}
