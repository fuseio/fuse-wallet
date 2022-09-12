import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import 'package:fusecash/features/swap/screens/review_swap.dart';
import 'package:fusecash/features/swap/screens/swap.dart';

const swapTab = AutoRoute(
  path: 'swap',
  name: 'swapTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: SwapPage,
    ),
    AutoRoute(
      page: ReviewSwapPage,
    ),
  ],
);
