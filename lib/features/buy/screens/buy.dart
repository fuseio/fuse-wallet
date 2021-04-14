import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/buy_page.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/features/buy/router/buy_router.gr.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/utils/images.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

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
        return MyScaffold(
          title: I18n.of(context).buy,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                banner(context, viewModel),
                businessList(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget banner(BuildContext context, BuyViewModel vm) {
    return vm.walletBanner != null &&
            vm.walletBanner.walletBannerHash != null &&
            vm.walletBanner.walletBannerHash.isNotEmpty
        ? Container(
            constraints: BoxConstraints(maxHeight: 140),
            padding: EdgeInsets.all(10),
            child: InkWell(
              focusColor: Theme.of(context).canvasColor,
              highlightColor: Theme.of(context).canvasColor,
              onTap: () {
                ExtendedNavigator.root.pushWebview(
                  title: '',
                  withBack: true,
                  url: vm.walletBanner.link,
                );
              },
              child: CachedNetworkImage(
                imageUrl: ImageUrl.getLink(vm.walletBanner.walletBannerHash),
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          )
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
                    separatorBuilder: (context, index) => Divider(),
                    shrinkWrap: true,
                    itemCount: vm.businesses?.length ?? 0,
                    itemBuilder: (context, index) => businessTile(
                      context,
                      vm.businesses[index],
                      vm.communityAddress,
                      vm.token,
                    ),
                  ),
                ),
              )
            ],
          );
  }

  ListTile businessTile(
    context,
    Business business,
    String communityAddress,
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
            imageUrl: ImageUrl.getLink(business.metadata.image),
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
        business.name ?? '',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: Text(
        business.metadata.description ?? '',
        style: TextStyle(
          // color: Theme.of(context).accentColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: () {
        ExtendedNavigator.named('buyRouter').pushBusinessPage(
          business: business,
          token: token,
        );
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
                  color: Theme.of(context).textTheme.button.color,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              ExtendedNavigator.root.pushSendAmountScreen(
                pageArgs: SendFlowArguments(
                  tokenToSend: token,
                  name: business.name ?? '',
                  accountAddress: business.account,
                  avatar: NetworkImage(
                    ImageUrl.getLink(business.metadata.image),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
