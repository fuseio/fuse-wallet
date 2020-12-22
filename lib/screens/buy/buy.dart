import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esol/screens/buy/business_rating.dart';
import 'package:esol/widgets/custom_rectangle.dart';
import 'package:esol/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/community/business.dart';
import 'package:esol/models/community/business_metadata.dart';
import 'package:esol/models/views/buy_page.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/screens/buy/router/buy_router.gr.dart';
import 'package:esol/screens/contacts/send_amount_arguments.dart';
import 'package:esol/screens/routes.gr.dart';
import 'package:esol/widgets/main_scaffold.dart';
import 'package:auto_route/auto_route.dart';

class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInit: (store) {
          store.dispatch(getBusinessListCall());
        },
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/buy-screen');
        },
        builder: (_, viewModel) {
          return MainScaffold(
              drawerIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15, bottom: 8),
                child: Image.asset(
                  'assets/images/menu_white.png',
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.29,
              newHeaderAppBar: Header(
                image: null,
                imageshow: false,
                contactEmpty: true,
                textshow: true,
              ),
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
              title: Text('Comprar'),
              // Text(I18n.of(context).buy

              children: <Widget>[BusinessesListView()]);
        });
  }
}

class BusinessesListView extends StatelessWidget {
  Widget banner(BuildContext context, BuyViewModel vm) {
    return vm.walletBanner != null &&
            vm.walletBanner.walletBannerHash != null &&
            vm.walletBanner.walletBannerHash.isNotEmpty
        ? Container(
            constraints: BoxConstraints(maxHeight: 140),
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                ExtendedNavigator.root.push(Routes.webview,
                    arguments: WebViewPageArguments(
                        withBack: true, url: vm.walletBanner.link, title: ''));
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

  Widget businesSearch(context, BuyViewModel vm) {
    return vm.businesses.isEmpty
        ? CustomRectangle(
            borderSize: 20,
            borderColor: Colors.white,
            height: 50.0,
            borderRadius: 40.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 18, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: Icon(Icons.search, color: Colors.black),
                          labelText: I18n.of(context).search,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                              vm.token),
                        )))
              ]);
  }

  Widget businessList(context, BuyViewModel vm) {
    return vm.businesses.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 25),
                child: Text('Pagar fuera de tus contactos'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  height: 80,
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            // controller: searchController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 55,
                                    width: 100,
                                    // child: Image.asset('assets\images\gift.png'),
                                    decoration: BoxDecoration(
                                      // image: DecorationImage(
                                      //   image: NetworkImage(
                                      //       'https://www.w3schools.com/howto/img_avatar.png'),
                                      //   fit: BoxFit.contain,
                                      // ),
                                      // border: Border.all(
                                      //     // color: Colors.black,
                                      //     // width: 8,
                                      //     ),
                                      color: Theme.of(context).buttonColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .buttonColor
                                              .withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                        child: Text(
                                      I18n.of(context).send_button,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              icon: Container(
                                  height: 20,
                                  padding: EdgeInsets.only(left: 5),
                                  child:
                                      Image.asset('assets/images/phone.png')),
                              // labelText: 'teléfono',
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 45,
                        //   height: 45,
                        //   child: new FloatingActionButton(
                        //       heroTag: 'contacts_list',
                        //       backgroundColor: const Color(0xFF292929),
                        //       elevation: 0,
                        //       child: Image.asset(
                        //         'assets/images/scan.png',
                        //         width: 25.0,
                        //         color: Theme.of(context).scaffoldBackgroundColor,
                        //       ),
                        //       onPressed: bracodeScannerHandler),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
              BusinessEmptyTile(),
            ],
          )
        // ? Container(
        //     padding: EdgeInsets.all(40.0),
        //     child: Center(
        //       child: Text(I18n.of(context).no_businesses),
        //     ),
        //   )
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
                              vm.token),
                        )))
              ]);
  }

  ListTile businessTile(
      context, Business business, String communityAddres, token) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(),
          child: ClipOval(
              child: CachedNetworkImage(
            imageUrl: business.metadata.getImageUri(),
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
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 12,
            fontWeight: FontWeight.normal),
      ),
      onTap: () {
        ExtendedNavigator.of(context).push(BusinessesRoutes.businessPage,
            arguments: BusinessPageArguments(
              business: business,
              token: token,
            ));
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
              ExtendedNavigator.root.push(Routes.sendAmountScreen,
                  arguments: SendAmountScreenArguments(
                      pageArgs: SendAmountArguments(
                          tokenToSend: token,
                          name: business.name ?? '',
                          accountAddress: business.account,
                          avatar:
                              NetworkImage(business.metadata.getImageUri()))));
            },
          )
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
                businesSearch(context, vm),
                businessList(context, vm)
              ],
            ),
          );
        });
  }
}

class BusinessEmptyTile extends StatelessWidget {
  const BusinessEmptyTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              // border: Border(
              //   bottom: BorderSide(
              //     color: Color(0xFFE8E8E8),
              //   ),
              // ),
              ),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
            leading: Container(
              height: 50,
              width: 50,
              // child: Image.asset('assets\images\gift.png'),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage('assets/images/anom.png') ??
                      AssetImage('assets/images/anom.png'),
                  fit: BoxFit.contain,
                ),
                // border: Border.all(
                //     // color: Colors.black,
                //     // width: 8,
                //     ),
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            // CircleAvatar(
            //   backgroundColor: Color(0xFFE0E0E0),
            //   radius: 25,
            //   backgroundImage: image ?? AssetImage('assets/images/anom.png'),
            // ),
            title: Text(
              'Business Name',
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).primaryColor),
            ),
            // trailing: trailing,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusinessRating()),
              );
            },
          ),
        ),
      ),
    );
  }
}
