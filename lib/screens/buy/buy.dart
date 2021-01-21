import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/views/buy_page.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/screens/buy/banner.dart';
import 'package:supervecina/widgets/main_scaffold.dart';
import 'package:supervecina/screens/buy/router/buy_router.gr.dart';

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

class BusinessesListView extends StatefulWidget {
  @override
  _BusinessesListViewState createState() => _BusinessesListViewState();
}

class _BusinessesListViewState extends State<BusinessesListView> {
  final List<String> areas = ['La Oliva Sevilla', 'Los Pajaritos Sevilla'];
  Map<int, List<Business>> businessesMap;

  Widget _buildCategories(BuyViewModel vm) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 5.0),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Color(0xFFE8E8E8),
                ),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: areas?.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                  // leading: Container(
                  //   width: 50,
                  //   height: 50,
                  //   decoration: BoxDecoration(),
                  //   child: ClipOval(
                  //     child: CachedNetworkImage(
                  //       imageUrl: business.metadata.image,
                  //       placeholder: (context, url) => CircularProgressIndicator(),
                  //       errorWidget: (context, url, error) => Icon(Icons.error),
                  //       imageBuilder: (context, imageProvider) => Image(
                  //         image: imageProvider,
                  //         fit: BoxFit.cover,
                  //         width: 50.0,
                  //         height: 50.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  title: Text(
                    areas[index],
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    ExtendedNavigator.named('buyRouter')
                        .pushBusinessesListScreen(
                      businesses: businessesMap[index],
                      communityAddress: vm.communityAddress,
                      token: vm.token,
                      title: areas[index],
                    );
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
                          ExtendedNavigator.named('buyRouter')
                              .pushBusinessesListScreen(
                            businesses: businessesMap[index],
                            communityAddress: vm.communityAddress,
                            token: vm.token,
                            title: areas[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInit: (store) {
          store.dispatch(getBusinessListCall());
        },
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel.businesses != newViewModel.businesses) {
            List<int> area =
                newViewModel.businesses.map((e) => e.area).toSet().toList();
            setState(() {
              businessesMap = area.fold({}, (previousValue, areaId) {
                List<Business> businesses = newViewModel.businesses
                    .where((element) => element.area == areaId)
                    .toList();
                previousValue[areaId] = businesses;
                return previousValue;
              });
            });
          }
        },
        builder: (_, vm) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[BannerWidget(), _buildCategories(vm)],
            ),
          );
        });
  }
}
