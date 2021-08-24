import 'dart:async';
import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/string.dart';
import 'package:fusecash/utils/url.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessScreen extends StatefulWidget {
  final Business business;
  final Token token;
  BusinessScreen({
    required this.business,
    required this.token,
  });

  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  GlobalKey<ScaffoldState>? scaffoldState;
  late Completer<GoogleMapController> _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    _controller = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Color description_icon_color = Colors.white;

    return Scaffold(
      key: scaffoldState,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ///
                    /// business image
                    ///
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: SizedBox.expand(
                              child: CachedNetworkImage(
                                imageUrl: widget.business.metadata.coverPhoto,
                                placeholder: (context, url) =>
                                    Center(child: SizedBox(child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageBuilder: (context, imageProvider) => Image(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 60,
                              left: 20,
                              child: InkWell(
                                focusColor: Theme.of(context).canvasColor,
                                highlightColor: Theme.of(context).canvasColor,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(PlatformIcons(context).back),
                              )),
                        ],
                      ),
                    ),
                    ///
                    /// business profile & info
                    ///
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 10),
                            child: ClipOval(
                                child: CachedNetworkImage(
                              imageUrl: widget.business.metadata.image,
                              placeholder: (context, url) =>
                                  Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                width: 75.0,
                                height: 75.0,
                              ),
                            )),
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Text(
                                widget.business.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            120),
                                child: Text(
                                  widget.business.metadata.address,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ![null, '']
                                      .contains(widget.business.metadata.type)
                                  ? Text(
                                      '#' +
                                          widget.business.metadata.type
                                              .capitalize(),
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ],
                      ),
                    ),
                    ///
                    /// business info
                    ///
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 0, left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Divider(
                              height: 20,
                            ),
                            Column(
                              children: <Widget>[
                                widget.business.metadata.website != ''
                                    ? Container(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/images/geography.svg',
                                                width: 19,
                                                height: 19,
                                                color: description_icon_color,
                                              ),
                                            ),
                                            InkWell(
                                              focusColor:
                                                  Theme.of(context).canvasColor,
                                              highlightColor:
                                                  Theme.of(context).canvasColor,
                                              onTap: () {
                                                launchUrl(widget
                                                    .business.metadata.website);
                                              },
                                              child: Text(widget
                                                  .business.metadata.website),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                widget.business.metadata.phoneNumber != ''
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/images/phone.svg',
                                                width: 19,
                                                height: 19,
                                                color: description_icon_color,
                                              ),
                                            ),
                                            InkWell(
                                              focusColor:
                                                  Theme.of(context).canvasColor,
                                              highlightColor:
                                                  Theme.of(context).canvasColor,
                                              child: Text(widget.business
                                                  .metadata.phoneNumber),
                                              onTap: () {
                                                final Uri _phoneLaunchUri = Uri(
                                                  scheme: 'tel',
                                                  path: widget.business.metadata
                                                      .phoneNumber,
                                                );
                                                launchUrl(
                                                    _phoneLaunchUri.toString());
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                widget.business.metadata.description != ''
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/info.svg',
                                                  width: 19,
                                                  height: 19,
                                                  color: description_icon_color,
                                                )),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Text(widget
                                                              .business
                                                              .metadata
                                                              .description !=
                                                          ''
                                                      ? 'More details'
                                                      : ''),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Text(
                                                    widget.business.metadata
                                                        .description,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ///
                    /// map
                    ///
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          widget.business.metadata.latLng.isNotEmpty
                              ? GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        widget.business.metadata.latLng[0],
                                        widget.business.metadata.latLng[1]),
                                    zoom: 13.0,
                                  ),
                                )
                              : SizedBox.shrink(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).buttonColor,
                                padding: EdgeInsets.only(
                                    left: 100, right: 100, top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: Text(
                                I10n.of(context).pay,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                final SendFlowArguments args =
                                    SendFlowArguments(
                                  tokenToSend: widget.token,
                                  name: widget.business.name,
                                  accountAddress: widget.business.account,
                                  avatar: NetworkImage(
                                    widget.business.metadata.image,
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
                          )
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
