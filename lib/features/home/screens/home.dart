import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/home/widgets/empty_action.dart';
import 'package:fusecash/features/home/widgets/feed_tile.dart';
import 'package:fusecash/features/home/widgets/home_app_bar.dart';
import 'package:fusecash/features/shared/widgets/balance_title.dart';
import 'package:fusecash/features/shared/widgets/barcode_scanner.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/feed.dart';
import 'package:fusecash/redux/viewsmodels/home.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: HomeViewModel.fromStore,
      builder: (_, viewModel) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          sized: false,
          child: SafeArea(
            child: Scaffold(
              body: NestedScrollView(
                controller: scrollController,
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
                      ) {
                        return FlexibleSpaceBar(
                          titlePadding: const EdgeInsets.only(
                            bottom: 15,
                            left: 15,
                            right: 15,
                          ),
                          background: const HomeAppBar(),
                          stretchModes: const [
                            StretchMode.fadeTitle,
                          ],
                          title: AnimatedOpacity(
                            opacity:
                                boxConstraints.biggest.height <= 60 ? 1.0 : 0.0,
                            duration: boxConstraints.biggest.height <= 60
                                ? const Duration(seconds: 1)
                                : Duration.zero,
                            child: const BalanceTitle(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                body: LazyLoadScrollView(
                  isLoading: isLoading,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      viewModel.refreshFeed();
                      await Future.delayed(const Duration(milliseconds: 500));
                      return;
                    },
                    child: StoreConnector<AppState, FeedViewModel>(
                      converter: FeedViewModel.fromStore,
                      distinct: true,
                      onWillChange: (prev, next) {
                        if (prev?.scrollToTop != next.scrollToTop &&
                            next.scrollToTop) {
                          scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        }
                      },
                      builder: (_, viewModel) {
                        if (viewModel.walletActions.isEmpty) {
                          return const DepositDollarsEmptyActions();
                        }
                        return ListView.separated(
                          itemCount: viewModel.walletActions.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Divider(
                              thickness: 3,
                              height: 3,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          itemBuilder: (context, index) => FeedTile(
                            action: viewModel.walletActions[index],
                          ),
                        );
                      },
                    ),
                  ),
                  onEndOfPage: () {
                    setState(() {
                      isLoading = true;
                    });
                    viewModel.fetchNextPage(() {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
