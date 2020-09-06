import 'package:flutter/material.dart';
import 'package:roost/models/transactions/transaction.dart';
import 'package:roost/screens/home/widgets/assets_list.dart';
import 'package:roost/screens/home/widgets/token_header.dart';
import 'package:roost/screens/home/widgets/transaction_tile.dart';
import 'package:roost/widgets/my_app_bar.dart';
import 'package:roost/generated/i18n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/models/app_state.dart';

class TokenScreen extends StatelessWidget {
  TokenScreen({Key key, this.tokenAddress}) : super(key: key);
  final String tokenAddress;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
        distinct: true,
        converter: TokensListViewModel.fromStore,
        builder: (_, viewModel) {
          final token = viewModel.tokens
              .firstWhere((element) => element.address == tokenAddress);
          return Scaffold(
              key: key,
              appBar: MyAppBar(height: 170.0, child: TokenHeader(token: token)),
              drawerEdgeDragWidth: 0,
              body: Column(children: <Widget>[
                Expanded(
                    child: ListView(children: [
                  TransfersList(
                      list:
                          (token?.transactions?.list?.reversed?.toList() ?? []))
                ])),
              ]));
        });
  }
}

class TransfersList extends StatelessWidget {
  TransfersList({this.list});
  final List<Transaction> list;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, top: 20, bottom: 8),
              child: Text(I18n.of(context).transactions,
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal))),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: list?.length,
              itemBuilder: (BuildContext ctxt, int index) =>
                  TransactionTile(transfer: list[index]))
        ]);
  }
}
