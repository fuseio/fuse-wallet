import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeedItem extends StatelessWidget {
  const WeedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://picsum.photos/250?image=9', //ImageUrl.getLink(vm.walletBanner!.walletBannerHash!),
              imageBuilder: (context, imageProvider) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text('asd'),
          ],
        ),
        Icon(Icons.arrow_forward_ios)
      ],
    );
  }
}
