import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/community/business_metadata.dart';
import 'package:supervecina/models/views/buy_page.dart';
import 'package:supervecina/screens/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BannerViewModel>(
        distinct: true,
        converter: BannerViewModel.fromStore,
        builder: (_, viewModel) {
          return viewModel.walletBanner != null &&
                  viewModel.walletBanner.walletBannerHash != null &&
                  viewModel.walletBanner.walletBannerHash.isNotEmpty
              ? Container(
                  constraints: BoxConstraints(maxHeight: 140),
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      ExtendedNavigator.root.pushWebview(
                        withBack: true,
                        url: viewModel.walletBanner.link,
                        title: '',
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          getImage(viewModel.walletBanner.walletBannerHash),
                      imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: imageProvider))),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ))
              : SizedBox.shrink();
        });
  }
}
