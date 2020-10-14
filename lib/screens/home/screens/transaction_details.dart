import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curadai/screens/home/widgets/drawer.dart';
import 'package:curadai/utils/addresses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:curadai/generated/i18n.dart';
import 'package:curadai/models/tokens/token.dart';
import 'package:curadai/models/transactions/transfer.dart';
import 'package:curadai/utils/format.dart';
import 'package:curadai/widgets/main_scaffold.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String status;
  final String displayName;
  final ImageProvider<dynamic> image;
  final Contact contact;
  final Transfer transfer;
  final Token token;

  TransactionDetailsScreen(
      {this.image,
      this.displayName,
      this.status,
      this.token,
      this.contact,
      this.transfer});

  @override
  Widget build(BuildContext context) {
    String amount = formatValue(transfer?.value, token?.decimals);
    return MainScaffold(
      withPadding: true,
      title: transfer.type.toUpperCase(),
      children: <Widget>[
        Container(
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
                            transfer.isFailed()
                                ? Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      'assets/images/failed_icon.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                  )
                                : transfer.isConfirmed()
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                            'assets/images/approve_icon.svg',
                                            width: 25,
                                            height: 25),
                                      )
                                    : transfer.isPending()
                                        ? Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: SvgPicture.asset(
                                                'assets/images/pending.svg',
                                                width: 25,
                                                height: 25),
                                          )
                                        : SizedBox.shrink(),
                            Text(
                                transfer.isConfirmed()
                                    ? I18n.of(context).approved
                                    : transfer?.status,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                      ),
                      transfer.isFailed()
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(I18n.of(context).transaction_failed,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                Text(
                                    transfer?.failReason ??
                                        I18n.of(context).something_went_wrong,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal))
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        top: 25.0, bottom: 25, left: 25, right: 25),
                    color: Theme.of(context).backgroundColor,
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
                              child: Text(transfer.type == 'SEND'
                                  ? I18n.of(context).to
                                  : I18n.of(context).from),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFE0E0E0),
                                    radius: 22,
                                    backgroundImage: image,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      displayName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            height: 1,
                          ),
                        ),
                        rowItem(
                            context,
                            I18n.of(context).address,
                            formatAddress(transfer.type == 'SEND'
                                ? transfer.to
                                : transfer.from),
                            withCopy: true, onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: transfer.type == 'SEND'
                                  ? transfer.to
                                  : transfer.from));
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              I18n.of(context).copied_to_clipboard,
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            height: 1,
                          ),
                        ),
                        rowItem(context, I18n.of(context).amount,
                            '$amount ${token.symbol}'),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            height: 1,
                          ),
                        ),
                        rowItem(
                            context,
                            I18n.of(context).network,
                            token.originNetwork != null
                                ? 'Fuse'
                                : 'Ethereum ${capitalize(foreignNetwork)}'),
                        [null, ''].contains(transfer.txHash)
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 25),
                                child: Divider(
                                  color: Color(0xFFE8E8E8),
                                  height: 1,
                                ),
                              ),
                        [null, ''].contains(transfer.txHash)
                            ? SizedBox.shrink()
                            : rowItem(
                                context, 'Txn', formatAddress(transfer?.txHash),
                                withCopy: true, onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: transfer?.txHash));
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    I18n.of(context).copied_to_clipboard,
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                              })
                        // transfer.timestamp == null
                        //     ? SizedBox.shrink()
                        //     : Padding(
                        //         padding: EdgeInsets.only(top: 25, bottom: 25),
                        //         child: Divider(
                        //           color: const Color(0xFFE8E8E8),
                        //           height: 1,
                        //         ),
                        //       ),
                        // transfer.timestamp == null
                        //     ? SizedBox.shrink()
                        //     : Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceEvenly,
                        //         mainAxisSize: MainAxisSize.max,
                        //         children: <Widget>[
                        //           SizedBox(
                        //             width:
                        //                 MediaQuery.of(context).size.width * .3,
                        //             child: Text('Date'),
                        //           ),
                        //           SizedBox(
                        //             width:
                        //                 MediaQuery.of(context).size.width * .3,
                        //             child: Text(
                        //                 DateTime.fromMillisecondsSinceEpoch(
                        //                         transfer.timestamp)
                        //                     .toString()),
                        //           )
                        //         ],
                        //       )
                      ],
                    ),
                  )
                ]))
      ],
    );
  }

  Widget rowItem(BuildContext context, String title, String value,
      {void Function() onTap, bool withCopy = false}) {
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
                      Text(value)
                    ]),
              ))
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
            child: Text(value),
          )
        ],
      );
    }
  }
}
