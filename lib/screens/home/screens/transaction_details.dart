import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:esol/models/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/widgets/main_scaffold.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
      drawerIcon: Text(''),
      expandedHeight: 50,
      newHeaderAppBar: SizedBox.shrink(),
      withPadding: true,
      title: Text(
        '',
      ),
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            'Detalles de la transacción',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
            // color: Colors.white,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          color: Colors.white),
                      child: Column(
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
                                      child: Image.asset(
                                          'assets/images/approve_icon.png'),
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
                                  // color: Theme.of(context).accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                  widget.transfer.isFailed()
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
                                widget?.transfer?.failReason ??
                                    I18n.of(context).something_went_wrong,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal))
                          ],
                        )
                      : SizedBox.shrink(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    padding: EdgeInsets.only(
                        top: 25.0, bottom: 25, left: 25, right: 25),
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // CircleAvatar(
                                //   backgroundColor: Color(0xFFE0E0E0),
                                //   radius: 22,
                                //   backgroundImage: widget.image,
                                // ),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, image: widget.image),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.grey[300],
                                  ),
                                ),
                                // Expanded(
                                //   child: Padding(
                                //     padding: EdgeInsets.only(left: 10),
                                //     child: Text(
                                //       widget.from,
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  width: 50,
                                ),
                                SizedBox(
                                  // width:
                                  //     MediaQuery.of(context).size.width * .3,
                                  child: Text(
                                      widget.transfer.type == 'SEND'
                                          ? 'Gustavo Marques'
                                          : 'Gustavo Marques',
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Divider(
                            color: Colors.white,
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
                                    child: Text(I18n.of(context).address,
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      child: Text('+51 16366354')
                                      // Text(deducePhoneNumber(
                                      //     widget.transfer,
                                      //     viewModel.reverseContacts,
                                      //     getReverseContact: false)),
                                      )
                                ],
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Divider(
                            color: Colors.white,
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
                              child: Text(I18n.of(context).amount,
                                  style: TextStyle(color: Colors.black)),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * .3,
                            //   child: Row(
                            //     children: widget?.amount.,
                            //   ),
                            // )
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .3,
                                child: Text(
                                  '1 E-SOL',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Divider(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: <Widget>[
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * .3,
                        //       child: Text(I18n.of(context).network),
                        //     ),
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * .3,
                        //       child: Text(widget.token.originNetwork != null
                        //           ? 'Fuse'
                        //           : 'Ethereum $foreignNetwork'),
                        //     )
                        //   ],
                        // ),
                        [null, ''].contains(widget.transfer.txHash)
                            ? SizedBox.shrink()
                            : SizedBox.shrink(),
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
                                    child: Text('Txn:',
                                        style: TextStyle(color: Colors.black)),
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
                        ,
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton.icon(
                elevation: 0.0,
                icon: Icon(Icons.share),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {},
                color: Colors.blue,
                textColor: Colors.white,
                label: Text('Compartir'),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Finalizar'),
              ),
            ),
          ],
        ),
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
