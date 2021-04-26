import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/home/dialogs/receive.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/account.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/snackbars.dart';
import 'package:fusecash/features/account/router/router.gr.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountViewModel>(
        distinct: true,
        converter: AccountViewModel.fromStore,
        builder: (_, viewModel) {
          return Column(
            children: [
              GestureDetector(
                onTap:
                    ExtendedNavigator.named('accountRouter').pushProfileScreen,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.grey[400],
                      child: CachedNetworkImage(
                        imageUrl: viewModel?.avatarUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundImage: AssetImage('assets/images/anom.png'),
                          radius: 30,
                        ),
                        imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    viewModel?.displayName ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: formatAddress(viewModel.walletAddress, 3),
                    icon: 'copy',
                    iconHeight: 12,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: viewModel?.walletAddress),
                      );
                      showCopiedFlushbar(context);
                    },
                  ),
                  Button(
                    text: I18n.of(context).receive,
                    icon: 'receiveIcon',
                    iconHeight: 12,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ReceiveDialog(
                          'fuse:${viewModel?.walletAddress}',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}
