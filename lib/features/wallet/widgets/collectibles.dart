import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/wallet/widgets/collectible_tile.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/collectibles.dart';

class CollectiblesPage extends StatelessWidget {
  const CollectiblesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CollectiblesViewModel>(
      distinct: true,
      converter: CollectiblesViewModel.fromStore,
      builder: (_, viewModel) => RefreshIndicator(
        onRefresh: () async {
          viewModel.refreshCollectibles();
          await Future.delayed(const Duration(milliseconds: 500));
          return;
        },
        child: GridView.count(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          padding: const EdgeInsets.only(
            top: 20,
          ),
          children: [
            ...viewModel.collectibles.map(
              (collectible) => CollectiblesTile(collectible),
            ),
          ],
        ),
      ),
    );
  }
}
