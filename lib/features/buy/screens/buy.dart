import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/redux/viewsmodels/buy_page.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/common/router/routes.dart';
import 'package:supervecina/features/contacts/send_amount_arguments.dart';
import 'package:auto_route/auto_route.dart';
import 'package:supervecina/features/shared/widgets/my_scaffold.dart';

class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyViewModel>(
      distinct: true,
      converter: BuyViewModel.fromStore,
      onInit: (store) {
        store.dispatch(getBusinessListCall());
      },
      builder: (_, viewModel) {
        return MyScaffold(
          title: I10n.of(context).buy,
          body: Container(
            child: BusinessesListView(),
          ),
        );
      },
    );
  }
}

class BusinessesListView extends StatefulWidget {
  @override
  _BusinessesListViewState createState() => _BusinessesListViewState();
}

class _BusinessesListViewState extends State<BusinessesListView> {
  final List<String> areas = ['La Oliva Sevilla', 'Los Pajaritos Sevilla'];
  Map<int, List<Business>> businessesMap = {};

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
              itemCount: areas.length,
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
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  context.router.push(
                    BusinessesListScreen(
                      businesses: businessesMap[index]!,
                      token: vm.token,
                      title: areas[index],
                    ),
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
                        context.router.push(
                          BusinessesListScreen(
                            businesses: businessesMap[index]!,
                            token: vm.token,
                            title: areas[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyViewModel>(
      distinct: true,
      converter: BuyViewModel.fromStore,
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.businesses != newViewModel.businesses) {
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
      builder: (_, vm) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_buildCategories(vm)],
        ),
      ),
    );
  }

  Widget businessList(context, BuyViewModel vm) {
    return vm.businesses.isEmpty
        ? Container(
            padding: EdgeInsets.all(40.0),
            child: Center(
              child: Text(I10n.of(context).no_businesses),
            ),
          )
        : Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 5.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                shrinkWrap: true,
                itemCount: vm.businesses.length,
                itemBuilder: (context, index) => businessTile(
                  vm.businesses[index],
                  vm.token,
                ),
              ),
            ),
          );
  }

  ListTile businessTile(
    Business business,
    Token token,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: business
                .metadata.image, //ImageUrl.getLink(business.metadata.image),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: 50.0,
              height: 50.0,
            ),
          ),
        ),
      ),
      title: Text(
        business.name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: Text(
        business.metadata.description,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: () {
        context.router.push(BusinessScreen(
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
              ),
            ),
            onTap: () {
              final SendFlowArguments args = SendFlowArguments(
                tokenToSend: token,
                name: business.name,
                accountAddress: business.account,
                avatar: NetworkImage(
                  business.metadata.image,
                ),
              );
              context.navigateTo(
                ContactsTab(
                  children: [
                    ContactsList(
                      pageArgs: args,
                    ),
                    SendAmountScreen(pageArgs: args),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
