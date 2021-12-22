import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      builder: (_, viewModel) => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: (viewModel.tokensImages[tokenAddress.toLowerCase()] ??
              imageUrl ??
              ''),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => DefaultLogo(
            symbol: tokenSymbol,
            width: width!,
            height: height!,
          ),
        ),
      ),
    );
  }
}
