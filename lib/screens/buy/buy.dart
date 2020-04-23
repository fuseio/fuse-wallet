import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_champions/generated/i18n.dart';
import 'package:local_champions/models/app_state.dart';
import 'package:local_champions/models/business.dart';
import 'package:local_champions/models/views/buy_page.dart';
import 'package:local_champions/screens/buy/business.dart';
import 'package:local_champions/screens/cash_home/webview_page.dart';
import 'package:local_champions/screens/routes.gr.dart';
import 'package:local_champions/screens/send/send_amount_arguments.dart';
import 'package:local_champions/utils/transaction_row.dart';
import 'package:local_champions/widgets/main_scaffold.dart';

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
              //           Navigator.pushNamed(context, '/Map');
              //         },
              //         child: Padding(
              //             padding: EdgeInsets.all(0),
              //             child: Image.asset(
              //               'assets/images/pin_drop.png',
              //               width: 30,
              //               height: 30,
              //             ))),
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/Map');
              //     },
              //   ),
              // ],
              automaticallyImplyLeading: false,
              title: I18n.of(context).buy,
              children: <Widget>[BusinessesListView()]);
        });
  }
}

class BusinessesListView extends StatelessWidget {
  Widget banner(BuildContext context, BuyViewModel vm) {
    return vm.walletBanner != null &&
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
        : Container();
  }

  Widget businessList(BuyViewModel vm) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Expanded(
              child: new Padding(
                  padding: new EdgeInsets.only(left: 10, bottom: 5.0),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        new Divider(),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: vm.businesses?.length ?? 0,
                    itemBuilder: (context, index) => businessTile(context,
                        vm.businesses[index], vm.communityAddres, vm.token),
                  )))
        ]);
  }

  ListTile businessTile(
      context, Business business, String communityAddres, token) {
    var image = getImageUrl(business, communityAddres);
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(),
        child: ClipOval(
            child:
                business.metadata.image == null || business.metadata.image == ''
                    ? Image.network(image)
                    : Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      )),
      ),
      title: Text(
        business.name ?? '',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.normal),
      ),
      subtitle: Text(
        business.metadata.description ?? '',
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 12,
            fontWeight: FontWeight.normal),
      ),
      onTap: () {
        Router.navigator.pushNamed(Router.businessPage,
            arguments: BusinessPageArguments(
                communityAddress: communityAddres,
                token: token,
                business: business));
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/go.png',
                  fit: BoxFit.fill,
                  width: 25,
                  height: 25,
                )),
            onTap: () {
              Router.navigator.pushNamed(Router.sendAmountScreen,
                  arguments: SendAmountArguments(
                      sendType: SendType.BUSINESS,
                      avatar: NetworkImage(image),
                      name: business.name ?? '',
                      accountAddress: business.account));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        builder: (_, vm) {
          return vm.businesses.isEmpty
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
                    children: <Widget>[banner(context, vm), businessList(vm)],
                  ),
                );
        });
  }
}
