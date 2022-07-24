import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charge_wallet_sdk/models/models.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/collectible.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class CollectiblePage extends StatefulWidget {
  final Collectible collectible;
  const CollectiblePage({
    Key? key,
    required this.collectible,
  }) : super(key: key);

  @override
  State<CollectiblePage> createState() => _CollectiblePageState();
}

class _CollectiblePageState extends SfWidget<CollectiblePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CollectibleViewModel>(
      distinct: true,
      converter: CollectibleViewModel.fromStore,
      builder: (_, viewModel) {
        final Collectible col = viewModel.collectibles[widget
            .collectible.collectionAddress]![int.parse(widget.collectible.id)]!;
        return InnerScaffold(
          hasScrollBody: false,
          expandedHeight: kToolbarHeight,
          body: SizedBox(
            height: 1,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: boxShadow,
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const Preloader(),
                          width: MediaQuery.of(context).size.width,
                          height: 335,
                          imageUrl: col.imageURL,
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/anom.png'),
                            radius: 30,
                          ),
                          imageBuilder: (context, imageProvider) => Image(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              col.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: InkWell(
                                    focusColor: Theme.of(context).canvasColor,
                                    highlightColor:
                                        Theme.of(context).canvasColor,
                                    onTap: () {
                                      GallerySaver.saveImage(col.imageURL)
                                          .then((value) {
                                        super.throwAlert(
                                          context,
                                          I10n.of(context).image_saved,
                                          type: AlertsTypeEnum.SUCCESS,
                                        );
                                      }).catchError((error, s) {
                                        super.throwAlert(
                                          context,
                                          I10n.of(context).something_went_wrong,
                                          type: AlertsTypeEnum.ERROR,
                                          popupType: AlertsPopupEnum.WIDGET,
                                        );
                                      });
                                    },
                                    child: const Icon(
                                      Icons.file_download_outlined,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                MenuTile(
                  contentPadding: const EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 20,
                    right: 20,
                  ),
                  fontSize: 14,
                  label: I10n.of(context).collection,
                  menuIcon: 'nft_collection.svg',
                  onTap: () {},
                  trailing: Text(
                    col.collectionName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                ),
                MenuTile(
                  contentPadding: const EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 20,
                    right: 20,
                  ),
                  fontSize: 14,
                  label: I10n.of(context).nft_name,
                  menuIcon: 'nft_finger.svg',
                  onTap: () {},
                  trailing: Text(
                    col.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          bottomContent: GradientButton(
            width: MediaQuery.of(context).size.width * .9,
            textColor: Theme.of(context).canvasColor,
            text: I10n.of(context).send,
            onPressed: () {
              Analytics.track(
                  eventName: AnalyticsEvents.send1MainButton,
                  properties: {
                    "fromScreen": "Collection",
                  });
              context.router.push(
                ContactsRoute(
                  pageArgs: SendFlowArguments(
                    collectible: col,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
