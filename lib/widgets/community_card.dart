import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/community/community.dart';
import 'package:roost/models/tokens/token.dart';

class CommunitySelectedCardScreen extends StatefulWidget {
  CommunitySelectedCardScreen(
      {Key key, this.title, this.community, this.token, this.switchCommunity})
      : super(key: key);

  final Community community;
  final Token token;
  final Function(String) switchCommunity;
  final String title;

  @override
  _CommunityCardScreenState createState() => _CommunityCardScreenState();
}

class _CommunityCardScreenState extends State<CommunitySelectedCardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.switchCommunity(widget?.community?.address);
          Navigator.of(context).pop();
        },
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(15),
                offset: Offset(0.0, 1.5),
                blurRadius: 30,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
                          imageUrl:
                              widget?.community?.metadata?.getCoverPhotoUri(),
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
                                      imageUrl: widget?.community?.metadata
                                          ?.getImageUri(),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                    ),
                                  ),
                                  widget.community.metadata.isDefaultImage !=
                                              null &&
                                          widget
                                              .community.metadata.isDefaultImage
                                      ? Text(
                                          widget?.token?.symbol ?? '',
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
                      Text(widget?.community?.name ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                          )),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                (widget?.community?.isClosed != null &&
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
                                  Text(I18n.of(context).selected,
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
