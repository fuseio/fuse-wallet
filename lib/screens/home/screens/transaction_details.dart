import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ceu_do_mapia/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:ceu_do_mapia/models/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ceu_do_mapia/generated/i18n.dart';
import 'package:ceu_do_mapia/models/tokens/token.dart';
import 'package:ceu_do_mapia/models/transactions/transfer.dart';
import 'package:ceu_do_mapia/utils/format.dart';
import 'package:ceu_do_mapia/utils/transaction_util.dart';
import 'package:ceu_do_mapia/widgets/main_scaffold.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final List<Widget> amount;
  final String status;
  final String from;
  final ImageProvider<dynamic> image;
  final Contact contact;
  final Transfer transfer;
  final Token token;
  TransactionDetailsScreen(
      {this.image,
      this.from,
      this.status,
      this.token,
      this.contact,
      this.amount,
      this.transfer});
  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      withPadding: true,
      title: widget.transfer.type.toUpperCase(),
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          widget.transfer.isFailed()
                              ? Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    'assets/images/failed_icon.svg',
                                    width: 25,
                                    height: 25,
                                  ),
                                )
                              : widget.transfer.isConfirmed()
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: SvgPicture.asset(
                                          'assets/images/approve_icon.svg',
                                          width: 25,
                                          height: 25),
                                    )
                                  : widget.transfer.isPending()
                                      ? Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                              'assets/images/pending.svg',
                                              width: 25,
                                              height: 25),
                                        )
                                      : SizedBox.shrink(),
                          Text(
                              widget.transfer.isConfirmed()
                                  ? I18n.of(context).approved
                                  : widget?.transfer?.status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
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
                              child: Text(widget.transfer.type == 'SEND'
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
                                    backgroundImage: widget.image,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.from,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
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
                        StoreConnector<AppState, _TransactionDetailViewModel>(
                            distinct: true,
                            converter: _TransactionDetailViewModel.fromStore,
                            builder: (_, viewModel) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text(I18n.of(context).address),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text(deducePhoneNumber(
                                        widget.transfer,
                                        viewModel.reverseContacts,
                                        getReverseContact: false)),
                                  )
                                ],
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            height: 1,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(I18n.of(context).amount),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Row(
                                children: widget?.amount,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(I18n.of(context).network),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Text(widget.token.originNetwork != null
                                  ? 'Fuse'
                                  : 'Ethereum $foreignNetwork'),
                            )
                          ],
                        ),
                        [null, ''].contains(widget.transfer.txHash)
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 25),
                                child: Divider(
                                  color: Color(0xFFE8E8E8),
                                  height: 1,
                                ),
                              ),
                        [null, ''].contains(widget.transfer.txHash)
                            ? SizedBox.shrink()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text('Txn'),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Text(formatAddress(
                                        widget?.transfer?.txHash)),
                                  )
                                ],
                              )
                        // widget.transfer.timestamp == null
                        //     ? SizedBox.shrink()
                        //     : Padding(
                        //         padding: EdgeInsets.only(top: 25, bottom: 25),
                        //         child: Divider(
                        //           color: const Color(0xFFE8E8E8),
                        //           height: 1,
                        //         ),
                        //       ),
                        // widget.transfer.timestamp == null
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
                        //                 new DateTime.fromMillisecondsSinceEpoch(
                        //                         widget.transfer.timestamp * 1000)
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
}

class _TransactionDetailViewModel extends Equatable {
  final Map<String, String> reverseContacts;

  _TransactionDetailViewModel({this.reverseContacts});

  static _TransactionDetailViewModel fromStore(Store<AppState> store) {
    return _TransactionDetailViewModel(
      reverseContacts: store.state.userState.reverseContacts,
    );
  }

  @override
  List<Object> get props => [reverseContacts];
}
