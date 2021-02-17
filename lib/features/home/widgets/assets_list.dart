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
      builder: (_, viewModel) {
        return Scaffold(
          key: key,
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: viewModel.tokens?.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Color(0xFFE8E8E8),
                    thickness: 1,
                    height: 0,
                  ),
                  itemBuilder: (context, index) => TokenTile(
                    token: viewModel.tokens[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
