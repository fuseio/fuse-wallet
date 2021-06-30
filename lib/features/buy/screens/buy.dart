import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/buy_page.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';

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
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyViewModel>(
      distinct: true,
      converter: BuyViewModel.fromStore,
      builder: (_, vm) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // banner(context, vm),
            businessList(context, vm),
          ],
        ),
      ),
    );
  }

  // Widget banner(BuildContext context, BuyViewModel vm) {
  //   return vm.walletBanner != null &&
  //           vm.walletBanner?.walletBannerHash != null &&
  //           vm.walletBanner?.walletBannerHash != ''
  //       ? Container(
  //           constraints: BoxConstraints(maxHeight: 140),
  //           padding: EdgeInsets.all(10),
  //           child: InkWell(
  //             focusColor: Theme.of(context).canvasColor,
  //             highlightColor: Theme.of(context).canvasColor,
  //             onTap: () {
  //               context.router.push(
  //                 Webview(
  //                   url: vm.walletBanner?.link ?? '',
  //                   title: '',
  //                 ),
  //               );
  //             },
  //             child: CachedNetworkImage(
  //               imageUrl: ImageUrl.getLink(vm.walletBanner!.walletBannerHash!),
  //               imageBuilder: (context, imageProvider) => Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 height: 140,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     fit: BoxFit.cover,
  //                     image: imageProvider,
  //                   ),
  //                 ),
  //               ),
  //               placeholder: (context, url) => CircularProgressIndicator(),
  //               errorWidget: (context, url, error) => Icon(Icons.error),
  //             ),
  //           ),
  //         )
  //       : SizedBox.shrink();
  // }

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
                  vm.communityAddress,
                  vm.token!,
                ),
              ),
            ),
          );
  }

  ListTile businessTile(
    Business business,
    String communityAddress,
    Token? token,
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
          token: token!,
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
                tokenToSend: token!,
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
