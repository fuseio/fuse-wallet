import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supervecina/models/community/community.dart';

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
        focusColor: Theme.of(context).splashColor,
        highlightColor: Theme.of(context).splashColor,
        onTap: () {
          widget.switchCommunity(widget?.community?.address);
          Navigator.of(context).pop();
        },
        child: Container(
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
            height: 110,
            child: Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl:
                                widget?.community?.metadata?.getImageUri(),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget?.community?.name ?? '',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                )),
                            SizedBox(
                              width: 3,
                            ),
                            Text('Token: ${widget?.community?.token?.symbol}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/go_to_pro.svg',
                          width: 10,
                          height: 10,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
