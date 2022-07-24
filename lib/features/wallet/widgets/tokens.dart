import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/widgets/token_tile.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/tokens_list.dart';

class TokensPage extends StatelessWidget {
  const TokensPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
      distinct: true,
      converter: TokensListViewModel.fromStore,
      builder: (_, viewModel) => RefreshIndicator(
        onRefresh: () async {
          viewModel.refreshTokenList();
          await Future.delayed(const Duration(milliseconds: 500));
          return;
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(
            top: 5,
          ),
          itemCount: viewModel.tokenList.length,
          itemBuilder: (context, index) => TokenTile(
            token: viewModel.tokenList[index],
          ),
        ),
      ),
    );
  }
}
