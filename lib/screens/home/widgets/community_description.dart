import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/widgets/primary_button.dart';

class CommunityDescription extends StatefulWidget {
  final Community community;
  CommunityDescription({this.community});
  @override
  _CommunityDescriptionState createState() => _CommunityDescriptionState();
}

class _CommunityDescriptionState extends State<CommunityDescription>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimatoin;
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0)),
                            child: CachedNetworkImage(
                              imageUrl: widget?.community?.metadata
                                  ?.getCoverPhotoUri(),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                              ),
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                              ),
                            )),
                        Positioned(
                            bottom: -40,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                  ?.community?.metadata
                                                  ?.getImageUri(),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Image(
                                                width: 60,
                                                height: 60,
                                                image: imageProvider,
                                              ),
                                            )),
                                        widget.community.metadata
                                                        .isDefaultImage !=
                                                    null &&
                                                widget.community.metadata
                                                    .isDefaultImage
                                            ? Text(
                                                widget.community?.token
                                                        ?.symbol ??
                                                    '',
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
                                )))
                      ],
                    ),
                    SizedBox(height: 60.0),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 10, left: 15, right: 15),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                '${widget.community.name} ${I18n.of(context).community}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    widget.community.description,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Center(
                                child: PrimaryButton(
                              fontSize: 15,
                              width: 140,
                              preload: isPreloading,
                              labelFontWeight: FontWeight.normal,
                              label: "Ok",
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            )),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
