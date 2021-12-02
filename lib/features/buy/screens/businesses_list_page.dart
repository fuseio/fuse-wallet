import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supervecina/common/router/routes.gr.dart';
import 'package:supervecina/features/contacts/send_amount_arguments.dart';
import 'package:supervecina/features/shared/widgets/my_scaffold.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:auto_route/auto_route.dart';

class BusinessesListScreen extends StatefulWidget {
  final List<Business> businesses;
  final Token token;
  final String title;

  BusinessesListScreen(
    this.businesses,
    this.token,
    this.title,
  );

  @override
  State<BusinessesListScreen> createState() => _BusinessesListScreenState();
}

class _BusinessesListScreenState extends State<BusinessesListScreen> {
  ListTile businessTile(Business business) {
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
          token: widget.token,
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
                tokenToSend: widget.token,
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

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).buy + ' en ' + widget.title,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.businesses.isEmpty
                ? Container(
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Text(I10n.of(context).no_businesses),
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
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              color: Color(0xFFE8E8E8),
                            ),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: widget.businesses.length,
                            itemBuilder: (context, index) =>
                                businessTile(widget.businesses[index]),
                          ),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
