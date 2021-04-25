import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/account.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'dart:core';
import 'package:fusecash/features/home/router/home_router.gr.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I18n.of(context).account,
      body: StoreConnector<AppState, AccountViewModel>(
        distinct: true,
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/receive-screen');
        },
        converter: AccountViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            padding: EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ExtendedNavigator.named('homeRouter')
                                  .pushProfileScreen();
                            },
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Colors.grey[400],
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: ![null, '']
                                                  .contains(viewModel.avatarUrl)
                                              ? CachedNetworkImage(
                                                  imageUrl: viewModel.avatarUrl,
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          'assets/images/anom.png',
                                                          width: 40,
                                                          height: 40),
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Image(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: new AssetImage(
                                                      'assets/images/anom.png'),
                                                  radius: 30,
                                                )),
                                      Positioned.directional(
                                          textDirection: TextDirection.ltr,
                                          bottom: 0,
                                          start: 0,
                                          end: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3),
                                            alignment: Alignment.center,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            child: Text(
                                              I18n.of(context).edit,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize: 9),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            viewModel?.displayName ?? '',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Button(
                                text: formatAddress(viewModel.walletAddress),
                                icon: 'copy',
                                onPressed: () {},
                              ),
                              Button(
                                text: I18n.of(context).receive,
                                icon: 'receiveIcon',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
