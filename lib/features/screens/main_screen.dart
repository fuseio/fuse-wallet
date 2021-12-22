import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/bottom_bar.dart';
import 'package:fusecash/features/shared/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BottomBarViewModel>(
      distinct: true,
      converter: BottomBarViewModel.fromStore,
      builder: (_, vm) => AutoTabsScaffold(
        animationDuration: Duration(milliseconds: 0),
        routes: [
          HomeTab(),
          ContactsTab(),
          BuyTab(
            children: [
              vm.isDefaultCommunity ? FusePointsExplainedScreen() : BuyScreen(),
            ],
          ),
          AccountTab(),
        ],
        bottomNavigationBuilder: (_, TabsRouter tabs) => BottomBar(tabs),
      ),
    );
  }
}
