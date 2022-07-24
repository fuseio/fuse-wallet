import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/account.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountViewModel>(
      distinct: true,
      converter: AccountViewModel.fromStore,
      builder: (_, viewModel) {
        return InkWell(
          focusColor: Theme.of(context).canvasColor,
          highlightColor: Theme.of(context).canvasColor,
          onTap: () {
            context.router.push(const ProfileRoute());
          },
          child: Column(
            children: [
              viewModel.avatarUrl == ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/anom.png'),
                        radius: 30,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        width: 90,
                        height: 90,
                        imageUrl: viewModel.avatarUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/anom.png'),
                          radius: 30,
                        ),
                        imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    viewModel.displayName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
