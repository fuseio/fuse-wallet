import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charge_wallet_sdk/models/models.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';

class CollectiblesTile extends StatelessWidget {
  final Collectible collectible;
  const CollectiblesTile(this.collectible, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        splashColor: Theme.of(context).canvasColor,
        hoverColor: Theme.of(context).canvasColor,
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onTap: () {
          context.router.push(
            CollectibleRoute(
              collectible: collectible,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                width: 154,
                height: 154,
                imageUrl: collectible.imageURL,
                errorWidget: (context, url, error) => const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/anom.png'),
                  radius: 30,
                ),
                placeholder: (context, url) => const Preloader(),
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              collectible.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
