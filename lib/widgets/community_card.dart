import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/community/community.dart';
import 'dart:core';

import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/utils/transaction_row.dart';

class CommunityCardScreen extends StatefulWidget {
  CommunityCardScreen(
      {Key key, this.title, this.community, this.switchCommunity})
      : super(key: key);

  final Community community;
  final Function(String) switchCommunity;
  final String title;

  @override
  _CommunityCardScreenState createState() => _CommunityCardScreenState();
}

class _CommunityCardScreenState extends State<CommunityCardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.switchCommunity(widget.community.address);
          Router.navigator.pushNamedAndRemoveUntil(
              Router.cashHomeScreen, (Route<dynamic> route) => false);
        },
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(15),
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: Offset(
                  2.0,
                  2.0,
                ),
              )
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        child: CachedNetworkImage(
                          imageUrl: getIPFSImageUrl(
                              widget.community.metadata.coverPhoto),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                          ),
                          imageBuilder: (context, imageProvider) => Image(
                            image: imageProvider,
                            fit: BoxFit.fill,
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                          ),
                        )),
                    Positioned(
                      bottom: -30,
                      right: 10,
                      child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      imageUrl: getIPFSImageUrl(
                                          widget.community.metadata.image),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                  ),
                                  widget.community.metadata.isDefaultImage !=
                                              null &&
                                          widget
                                              .community.metadata.isDefaultImage
                                      ? Text(
                                          widget.community.token.symbol,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      : SizedBox.shrink()
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(widget.community.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                          )),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                (widget.community.isClosed != null &&
                                            widget.community.isClosed
                                        ? 'Closed'
                                        : 'Open') +
                                    ' community',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/joined.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Joined',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ])
                          ])
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
