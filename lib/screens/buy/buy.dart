import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/views/buy_page.dart';
import 'package:paywise/screens/buy/business.dart';
import 'package:paywise/screens/cash_home/webview_page.dart';
import 'package:paywise/screens/routes.gr.dart';
import 'package:paywise/screens/send/send_amount_arguments.dart';
import 'package:paywise/utils/transaction_row.dart';
import 'package:paywise/widgets/bottombar.dart';
import 'package:paywise/widgets/main_scaffold.dart';
// import 'package:paywise/screens/routes.gr.dart';

class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInitialBuild: (viewModel) {
          viewModel.loadBusinesses();
        },
        builder: (_, viewModel) {
          return MainScaffold(
              // TODO - added map with all business
              // actions: <Widget>[
              //   IconButton(
              //     icon: InkWell(
              //         onTap: () {
              //           Router.navigator.pushNamed('/Map');
              //         },
              //         child: Padding(
              //             padding: EdgeInsets.all(0),
              //             child: Image.asset(
              //               'assets/images/pin_drop.png',
              //               width: 30,
              //               height: 30,
              //             ))),
              //     onPressed: () {
              //       Router.navigator.pushNamed('/Map');
              //     },
              //   ),
              // ],
              withPadding: false,
              titleFontSize: 15,
              footer: bottomBar(context),
              title: I18n.of(context).buy,
              children: <Widget>[BusinessesListView(vm: viewModel)]);
        });
  }
}

class BusinessesListView extends StatelessWidget {
  final BuyViewModel vm;
  BusinessesListView({this.vm});

  @override
  Widget build(BuildContext context) {
    Widget businesses = vm.businesses.isEmpty
        ? Container(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Text(I18n.of(context).no_businesses),
            ),
          )
        : new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                vm.walletBanner != null &&
                        vm.walletBanner.walletBannerHash != null &&
                        vm.walletBanner.walletBannerHash.isNotEmpty
                    ? new Container(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Router.navigator.pushNamed(Router.webViewPage,
                                arguments: WebViewPageArguments(
                                    url: vm.walletBanner.link, title: ''));
                          },
                          child: new Container(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        DotEnv().env['IPFS_BASE_URL'] +
                                            '/image/' +
                                            vm.walletBanner.walletBannerHash,
                                      )))),
                        ))
                    : Container(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                          padding: new EdgeInsets.only(left: 10, bottom: 5.0),
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    new Divider(),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: vm.businesses?.length ?? 0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(),
                                  child: ClipOval(
                                      child:
                                          vm.businesses[index].metadata.image ==
                                                      null ||
                                                  vm.businesses[index].metadata
                                                          .image ==
                                                      ''
                                              ? Image.network(getImageUrl(
                                                  vm.businesses[index],
                                                  vm.communityAddres))
                                              : Image.network(
                                                  getImageUrl(
                                                      vm.businesses[index],
                                                      vm.communityAddres),
                                                  fit: BoxFit.cover,
                                                  width: 50.0,
                                                  height: 50.0,
                                                )),
                                ),
                                title: Text(
                                  vm.businesses[index].name ?? '',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  vm.businesses[index].metadata.description ??
                                      '',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  Router.navigator.pushNamed(
                                      Router.businessPage,
                                      arguments: BusinessArguments(
                                          communityAddress: vm.communityAddres,
                                          token: vm.token,
                                          business: vm.businesses[index]));
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                      padding: EdgeInsets.all(10),
                                      shape: CircleBorder(),
                                      color: Theme.of(context).buttonColor,
                                      child: Text(
                                        I18n.of(context).pay,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .button
                                                .color,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onPressed: () {
                                        Router.navigator.pushNamed(
                                            Router.sendAmountScreen,
                                            arguments: SendAmountArguments(
                                                isBusiness: true,
                                                avatar: NetworkImage(
                                                    getImageUrl(
                                                        vm.businesses[index],
                                                        vm.communityAddres)),
                                                name:
                                                    vm.businesses[index].name ??
                                                        '',
                                                accountAddress: vm
                                                    .businesses[index]
                                                    .account));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    )
                  ],
                )
              ],
            ),
          );
    return businesses;
  }
}
