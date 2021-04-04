import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/assets.dart';

class AssetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
      distinct: true,
      converter: TokensListViewModel.fromStore,
      builder: (_, viewModel) => Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: viewModel.tokens?.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Divider(
                        thickness: 1,
                        height: 0,
                      ),
                    ),
                    itemBuilder: (context, index) => TokenTile(
                      token: viewModel.tokens[index],
                    ),
                  ),
                ),
              ],
            ),
            // viewModel.showDepositBanner
            //     ? Positioned.fill(
            //         child: Align(
            //           alignment: Alignment.center,
            //           child: DepositBanner(),
            //         ),
            //       )
            //     : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
