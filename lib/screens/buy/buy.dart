import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class BuyScreen extends StatefulWidget {
  BuyScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: (store) {
          return CashWalletViewModel.fromStore(store);
        },
        onInitialBuild: (viewModel) {
          viewModel.loadBusinesses();
        },
        builder: (_, viewModel) {
          return MainScaffold(
              key: scaffoldState,
              withPadding: false,
              footer: bottomBar(context),
              title: "Buy",
              children: <Widget>[BusinessesListView()]);
        });
  }
}

class BusinessesListView extends StatefulWidget {
  @override
  createState() => new BusinessesListViewState();
}

class BusinessesListViewState extends State<BusinessesListView> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
      converter: (store) {
        return CashWalletViewModel.fromStore(store);
      },
      builder: (_, viewModel) {
        return Builder(
            builder: (context) => viewModel.businesses?.length == 0
                ? Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: Text("No businesses found"),
                    ),
                  )
                : new Container(
                    padding: const EdgeInsets.all(16.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                  padding: new EdgeInsets.only(bottom: 5.0),
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            new Divider(),
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount:
                                        viewModel.businesses?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(),
                                          child: ClipOval(
                                              child: Image.network(
                                            viewModel.businesses[index].metadata.image,
                                            fit: BoxFit.cover,
                                            width: 50.0,
                                            height: 50.0,
                                          )),
                                        ),
                                        title: Text(
                                          viewModel.businesses[index].name ??
                                              '',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/Business',
                                              arguments: BusinessRouteArguments(
                                                  business: viewModel
                                                      .businesses[index]));
                                        },
                                        trailing: FlatButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          color: Theme.of(context).accentColor,
                                          padding: EdgeInsets.all(0),
                                          child: Text(
                                            "PAY",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/SendAmount',
                                                arguments: SendAmountArguments(
                                                    accountAddress: viewModel
                                                        .businesses[index]
                                                        .account));
                                          },
                                        ),
                                      );
                                    },
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
      },
    );
  }
}
