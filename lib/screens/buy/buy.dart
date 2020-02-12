import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/buy_page.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}

class BuyScreen extends StatefulWidget {
  BuyScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BuyViewModel>(
        distinct: true,
        converter: BuyViewModel.fromStore,
        onInitialBuild: (viewModel) {
          viewModel.loadBusinesses();
        },
        builder: (_, viewModel) {
          return MainScaffold(
              // TODO - added map with all business
              // actions: <Widget>[
              //   IconButton(
              //     icon: InkWell(
              //         onTap: () {
              //           Navigator.pushNamed(context, '/Map');
              //         },
              //         child: Padding(
              //             padding: EdgeInsets.all(0),
              //             child: Image.asset(
              //               'assets/images/pin_drop.png',
              //               width: 30,
              //               height: 30,
              //             ))),
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/Map');
              //     },
              //   ),
              // ],
              key: scaffoldState,
              withPadding: false,
              titleFontSize: 15,
              footer: bottomBar(context),
              title: I18n.of(context).buy,
              children: <Widget>[BusinessesListView()]);
        });
  }
}

class BusinessesListView extends StatefulWidget {
  @override
  createState() => new BusinessesListViewState();
}

class BusinessesListViewState extends State<BusinessesListView> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BuyViewModel>(
      converter: BuyViewModel.fromStore,
      builder: (_, viewModel) {
        return Builder(
            // viewModel.isCommunityBusinessesFetched
            //       ? Padding(
            //           child: Preloader(),
            //           padding: EdgeInsets.only(top: 70),
            //         )
            //       :
            builder: (context) {
          Widget businesses = viewModel.businesses.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(I18n.of(context).no_businesses),
                  ),
                )
              : new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      viewModel.walletBanner != null &&
                              viewModel.walletBanner.walletBannerHash != null &&
                              viewModel.walletBanner.walletBannerHash.isNotEmpty
                          ? new Container(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  launchUrl(viewModel.walletBanner.link);
                                },
                                child: new Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              DotEnv().env['IPFS_BASE_URL'] +
                                                  '/image/' +
                                                  viewModel.walletBanner
                                                      .walletBannerHash,
                                            )))),
                              ))
                          : Container(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Expanded(
                            child: new Padding(
                                padding:
                                    new EdgeInsets.only(left: 10, bottom: 5.0),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          new Divider(),
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: viewModel.businesses?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(),
                                        child: ClipOval(
                                            child: viewModel.businesses[index]
                                                            .metadata.image ==
                                                        null ||
                                                    viewModel.businesses[index]
                                                            .metadata.image ==
                                                        ''
                                                ? Image.network(getImageUrl(
                                                    viewModel.businesses[index],
                                                    viewModel.communityAddres))
                                                : Image.network(
                                                    getImageUrl(
                                                        viewModel
                                                            .businesses[index],
                                                        viewModel
                                                            .communityAddres),
                                                    fit: BoxFit.cover,
                                                    width: 50.0,
                                                    height: 50.0,
                                                  )),
                                      ),
                                      title: Text(
                                        viewModel.businesses[index].name ?? '',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      subtitle: Text(
                                        viewModel.businesses[index].metadata
                                                .description ??
                                            '',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/Business',
                                            arguments: BusinessRouteArguments(
                                                communityAddress:
                                                    viewModel.communityAddres,
                                                token: viewModel.token,
                                                business: viewModel
                                                    .businesses[index]));
                                      },
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          FlatButton(
                                            padding: EdgeInsets.all(10),
                                            shape: CircleBorder(),
                                            color:
                                                Theme.of(context).buttonColor,
                                            child: Text(
                                              I18n.of(context).pay,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .button
                                                      .color,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/SendAmount',
                                                  arguments: SendAmountArguments(
                                                      avatar: NetworkImage(
                                                          getImageUrl(
                                                              viewModel
                                                                      .businesses[
                                                                  index],
                                                              viewModel
                                                                  .communityAddres)),
                                                      name: viewModel
                                                              .businesses[index]
                                                              .name ??
                                                          '',
                                                      accountAddress: viewModel
                                                          .businesses[index]
                                                          .account));
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                );
          return businesses;
        });
      },
    );
  }
}
