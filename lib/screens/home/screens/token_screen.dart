import 'package:flutter/material.dart';
import 'package:esol/models/transactions/transaction.dart';
import 'package:esol/screens/home/widgets/assets_list.dart';
import 'package:esol/screens/home/widgets/token_header.dart';
import 'package:esol/screens/home/widgets/transaction_tile.dart';
import 'package:esol/widgets/my_app_bar.dart';
import 'package:esol/generated/i18n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/models/app_state.dart';

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
          final List<Transaction> list =
              token?.transactions?.list?.reversed?.toList() ?? [];
          return Scaffold(
              key: key,
              appBar: MyAppBar(
                  height: 170.0,
                  child: TokenHeader(token: token),
                  backgroundColor: Colors.white),
              drawerEdgeDragWidth: 0,
              body: Column(children: <Widget>[
                list.isEmpty
                    ? Flexible(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/no-activity.png',
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(I18n.of(context).no_activity,
                                  style: TextStyle(
                                      color: Color(0xFF979797),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView(children: [TransfersList(list: list)])),
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
