import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/transaction_row.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

_launchUrl(String urlToLaunch) async {
  if (await canLaunch(urlToLaunch)) {
    await launch(urlToLaunch, forceSafariVC: false);
  } else {
    throw 'Could not launch $urlToLaunch';
  }
}

class BusinessRouteArguments {
  final Business business;
  final Token token;
  final String communityAddress;

  BusinessRouteArguments({this.token, this.business, this.communityAddress});
}

class BusinessPage extends StatefulWidget {
  BusinessPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BusinessRouteArguments businessArgs =
        ModalRoute.of(context).settings.arguments;
    String coverPhotoUrl = getCoverPhotoUrl(businessArgs.business, businessArgs.communityAddress);
    String imageUrl = getImageUrl(businessArgs.business, businessArgs.communityAddress);

    return new Scaffold(
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
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: businessArgs.business.metadata.coverPhoto ==
                                        null ||
                                    businessArgs.business.metadata.coverPhoto ==
                                        ''
                                ? SizedBox.expand(child: Image.network(
                                    coverPhotoUrl,
                                    fit: BoxFit.fill,
                                  ),)
                                : SizedBox.expand(child: Image.network(
                                    coverPhotoUrl,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                    height: 200,
                                  ),)
                          ),
                          new Positioned(
                              top: 50.0,
                              left: 18.0,
                              child: InkWell(
                                onTap: () {
                                  Router.navigator.pop();
                                },
                                child: SvgPicture.asset(
                                    'assets/images/arrow_back_business.svg',
                                    fit: BoxFit.fill,
                                    width: 25,
                                    height: 25,
                                    alignment: Alignment.topLeft,
                                )
                              )
                          ), 
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: ClipOval(
                                child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: 75.0,
                                        height: 75.0,
                                      )),
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Text(
                                businessArgs.business.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                constraints: new BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            120),
                                child: Text(
                                  businessArgs.business.metadata.address,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '#' +
                                    capitalize(
                                        businessArgs.business.metadata.type),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 0, left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Divider(
                              height: 20,
                            ),
                            Column(
                              children: <Widget>[
                                businessArgs.business.metadata.website != '' ? 
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/images/geography.svg',
                                          width: 19,
                                          height: 19,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _launchUrl(businessArgs.business.metadata.website);
                                        },
                                        child: Text(businessArgs
                                          .business.metadata.website),
                                      ),
                                      
                                    ],
                                  ),
                                ): SizedBox.shrink(),
                                businessArgs.business.metadata.phoneNumber != '' ? 
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/images/phone.svg',
                                          width: 19,
                                          height: 19,
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(businessArgs
                                          .business.metadata.phoneNumber),
                                          onTap: () {
                                            _launchUrl('tel:${businessArgs.business.metadata.phoneNumber}');
                                          },
                                      )
                                    ],
                                  ),
                                ) : SizedBox.shrink(),
                                businessArgs.business.metadata.description != '' ? 
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            'assets/images/info.svg',
                                            width: 19,
                                            height: 19,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(businessArgs.business
                                                        .metadata.description !=
                                                    ''
                                                ? 'More details'
                                                : ''),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              businessArgs.business.metadata
                                                  .description,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ),
                                          ),
                                          // Text('',
                                          //     style: TextStyle(
                                          //         color: Theme.of(context)
                                          //             .colorScheme
                                          //             .secondary)),
                                        ],
                                      )
                                    ],
                                  ),
                                ) : SizedBox.shrink()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                         businessArgs.business.metadata.latLng != null && businessArgs.business.metadata.latLng.isNotEmpty ? GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(businessArgs.business.metadata.latLng[0], businessArgs.business.metadata.latLng[1]),
                              zoom: 13.0,
                            ),
                          ) : SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Theme.of(context).buttonColor,
                              padding: EdgeInsets.only(
                                  left: 100, right: 100, top: 15, bottom: 15),
                              child: Text(
                                I18n.of(context).pay,
                                style: TextStyle(
                                    color: Theme.of(context).textTheme.button.color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                Router.navigator.pushNamed(Router.sendAmountScreen,
                                    arguments: SendAmountArguments(
                                      isBusiness: true,
                                      accountAddress:
                                          businessArgs.business.account,
                                      avatar: NetworkImage(
                                        imageUrl
                                      ),
                                      name: businessArgs.business.name ?? '',
                                    ));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
            Expanded(
              flex: 1,
              child: bottomBar(context),
            )
          ],
        ),
      ),
    );
  }
}
