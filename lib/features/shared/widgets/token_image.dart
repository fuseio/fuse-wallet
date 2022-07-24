import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/widgets/default_logo.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/token_image.dart';

class TokenImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String tokenAddress;
  final String? imageUrl;
  final String tokenSymbol;
  const TokenImage({
    Key? key,
    this.width = 45,
    this.height = 45,
    required this.tokenAddress,
    required this.tokenSymbol,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenImageViewModel>(
      distinct: true,
      converter: TokenImageViewModel.fromStore,
      builder: (_, viewModel) {
        final String? imageURI =
            viewModel.tokensImages[tokenAddress.toLowerCase()] ?? imageUrl;
        if (imageURI == null) {
          return DefaultLogo(
            symbol: tokenSymbol,
            width: width!,
            height: height!,
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: width,
              height: height,
              imageUrl: imageURI,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => DefaultLogo(
                symbol: tokenSymbol,
                width: width!,
                height: height!,
              ),
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          );
        }
      },
    );
  }
}
