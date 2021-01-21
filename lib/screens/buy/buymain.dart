import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/community/business_metadata.dart';
import 'package:supervecina/models/views/buy_page.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/screens/buy/buysub.dart';
import 'package:supervecina/screens/buy/router/buy_router.gr.dart';
import 'package:supervecina/screens/contacts/send_amount_arguments.dart';
import 'package:supervecina/screens/routes.gr.dart';
import 'package:supervecina/widgets/main_scaffold.dart';
import 'package:auto_route/auto_route.dart';

class BuyScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInit: (store) {
          store.dispatch(getBusinessListCall());
        },
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/main-buy-screen');
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
              children: <Widget>[BussinessListView()]);
        });
  }
}

class BussinessListView extends StatefulWidget {
  @override
  _BussinessListViewState createState() => _BussinessListViewState();
}

class _BussinessListViewState extends State<BussinessListView> {
  Widget banner(BuildContext context, BuyViewModel vm) {
    return vm.walletBanner != null &&
        vm.walletBanner.walletBannerHash != null &&
        vm.walletBanner.walletBannerHash.isNotEmpty
        ? Container(
        constraints: BoxConstraints(maxHeight: 140),
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {

            // Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreenSub()));
          },
          child: CachedNetworkImage(
            imageUrl: getImage(vm.walletBanner.walletBannerHash),
            imageBuilder: (context, imageProvider) => Container(
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
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Text(I18n.of(context).no_businesses),
      ),
    )
        : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 5.0),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          color: Color(0xFFE8E8E8),
                        ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: vm.businesses?.length ?? 0,
                    itemBuilder: (context, index) => businessTile(
                        context,
                        vm.businesses[index],
                        vm.communityAddress,
                        vm.token, vm),
                  )))
        ]);
  }

  ListTile businessTile(
      context, Business business, String communityAddres, token, BuyViewModel vm) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(),
          child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: business.metadata.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
      onTap: () async {
        var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreenSub()));
        vm.loadBusinesses();
        setState(() {

        });
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
              ExtendedNavigator.root.pushSendAmountScreen(
                  pageArgs: SendAmountArguments(
                      tokenToSend: token,
                      name: business.name ?? '',
                      accountAddress: business.account,
                      avatar: NetworkImage(business.metadata.getImageUri())));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInitialBuild: (vm) {
          vm.loadBusinesses();
        },
        builder: (_, vm) {
          return Container(
            child: Column(
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

