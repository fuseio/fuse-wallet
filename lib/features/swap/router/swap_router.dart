import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/swap/screens/swap.dart';

const swapTab = AutoRoute(
  path: 'swap',
  name: 'swapTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: SwapScreen,
      name: 'swapScreen',
    ),
  ],
);

