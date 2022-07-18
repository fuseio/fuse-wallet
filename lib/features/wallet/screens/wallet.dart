import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/widgets/balance_title.dart';
import 'package:fusecash/features/shared/widgets/barcode_scanner.dart';
import 'package:fusecash/features/shared/widgets/floating_actions.dart';
import 'package:fusecash/features/shared/widgets/scroll_to_hide_widget.dart';
import 'package:fusecash/features/shared/widgets/slide_transition.dart';
import 'package:fusecash/features/wallet/screens/tabs.dart';
import 'package:fusecash/features/wallet/widgets/tokens.dart';
import 'package:fusecash/features/wallet/widgets/wallet_app_bar.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/collectibles.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      sized: false,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: controller,
            headerSliverBuilder: (context, innerBoxScrolled) => [
              SliverAppBar(
                surfaceTintColor: Theme.of(context).canvasColor,
                pinned: true,
                expandedHeight: 180,
                actions: [
                  Container(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: const BarcodeScanner(),
                  )
                ],
                backgroundColor: Theme.of(context).canvasColor,
                flexibleSpace: LayoutBuilder(
                  builder: (
                    ctx,
                    BoxConstraints boxConstraints,
                  ) =>
                      FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.fadeTitle,
                    ],
                    collapseMode: CollapseMode.pin,
                    titlePadding: const EdgeInsets.only(
                      bottom: 15,
                      left: 15,
                      right: 15,
                    ),
                    background: const WalletAppBar(),
                    title: AnimatedOpacity(
                      opacity: boxConstraints.biggest.height <= 60 ? 1.0 : 0.0,
                      duration: boxConstraints.biggest.height <= 60
                          ? const Duration(seconds: 1)
                          : const Duration(microseconds: 100000),
                      child: const BalanceTitle(),
                    ),
                  ),
                ),
              ),
            ],
            body: StoreConnector<AppState, CollectiblesViewModel>(
              distinct: true,
              converter: CollectiblesViewModel.fromStore,
              builder: (_, viewModel) {
                if (viewModel.collectibles.isNotEmpty) {
                  return const Tabs();
                } else {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          I10n.of(context).your_coins,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                      const TokensPage(),
                    ],
                  );
                }
              },
            ),
          ),
          bottomNavigationBar: MySlideTransition(
            delay: 1000,
            begin: const Offset(0.0, 1),
            end: const Offset(0.0, 0.0),
            child: ScrollToHideWidget(
              controller: controller,
              child: const FloatingActions(),
            ),
          ),
        ),
      ),
    );
  }
}
