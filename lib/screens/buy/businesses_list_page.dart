import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/screens/buy/router/buy_router.gr.dart';
import 'package:supervecina/screens/contacts/send_amount_arguments.dart';
import 'package:supervecina/screens/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:supervecina/widgets/main_scaffold.dart';

class BusinessesListScreen extends StatelessWidget {
  final List<Business> businesses;
  final String communityAddress;
  final Token token;
  final String title;

  BusinessesListScreen(
    this.businesses,
    this.communityAddress,
    this.token,
    this.title,
  );

  ListTile businessTile(context, Business business) {
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
    return MainScaffold(
        automaticallyImplyLeading: false,
        title: I18n.of(context).buy + ' en ' + title,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                businesses.isEmpty
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
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 5.0),
                                    child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Divider(
                                        color: Color(0xFFE8E8E8),
                                      ),
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: businesses?.length ?? 0,
                                      itemBuilder: (context, index) =>
                                          businessTile(
                                              context, businesses[index]),
                                    )))
                          ])
              ],
            ),
          ),
        ]);
  }
}
