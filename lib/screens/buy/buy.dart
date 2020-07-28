import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:seedbed/generated/i18n.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:seedbed/models/community/business.dart';
import 'package:seedbed/models/views/buy_page.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';
import 'package:seedbed/screens/buy/router/buy_router.gr.dart';
import 'package:seedbed/screens/routes.gr.dart';
import 'package:seedbed/utils/send.dart';
import 'package:seedbed/utils/transaction_util.dart';
import 'package:seedbed/widgets/main_scaffold.dart';
import 'package:auto_route/auto_route.dart';

class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInit: (store) {
          store.dispatch(getBusinessListCall());
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
            constraints: BoxConstraints(maxHeight: 140),
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                ExtendedNavigator.root.push(Routes.webview,
                    arguments: WebViewPageArguments(
                        url: vm.walletBanner.link, title: ''));
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
        : SizedBox.shrink();
  }

  Widget businessList(context, BuyViewModel vm) {
    return vm.businesses.isEmpty
        ? Container(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Text(I18n.of(context).no_businesses),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: new EdgeInsets.only(left: 10, bottom: 5.0),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              new Divider(
                            color: Color(0xFFE8E8E8),
                          ),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: vm.businesses?.length ?? 0,
                          itemBuilder: (context, index) => businessTile(
                              context,
                              vm.businesses[index],
                              vm.communityAddres,
                              vm.token),
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
        ExtendedNavigator.of(context).push(BusinessesRoutes.businessPage,
            arguments: BusinessPageArguments(
                business: business,
                token: token,
                communityAddress: communityAddres));
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
              navigateToSendAmountScreen(
                  business.account, business.name ?? '', null,
                  avatar: NetworkImage(image));
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
          return new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                banner(context, vm),
                businessList(context, vm)
              ],
            ),
          );
        });
  }
}
