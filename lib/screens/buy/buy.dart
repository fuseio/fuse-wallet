import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/business.dart';
import 'package:digitalrand/models/views/buy_page.dart';
import 'package:digitalrand/screens/buy/business.dart';
import 'package:digitalrand/screens/cash_home/webview_page.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';
import 'package:digitalrand/utils/transaction_row.dart';
import 'package:digitalrand/widgets/main_scaffold.dart';

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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => WebViewPage(
                              pageArgs: WebViewPageArguments(
                                  url: vm.walletBanner.link, title: ''),
                            )));
              },
              child: CachedNetworkImage(
                imageUrl: getIPFSImageUrl(vm.walletBanner.walletBannerHash),
                imageBuilder: (context, imageProvider) => new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider))),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
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
              child: CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: 50.0,
              height: 50.0,
            ),
          ))),
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
          FlatButton(
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
            color: Theme.of(context).buttonColor,
            child: Text(
              I18n.of(context).pay,
              style: TextStyle(
                  color: Theme.of(context).splashColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => SendAmountScreen(
                          pageArgs: SendAmountArguments(
                              sendType: SendType.BUSINESS,
                              avatar: NetworkImage(image),
                              name: business.name ?? '',
                              accountAddress: business.account))));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInitialBuild: (vm) {
          vm.loadBusinesses();
        },
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
