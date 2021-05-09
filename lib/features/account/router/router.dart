import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/account/screens/account_screen.dart';
import 'package:fusecash/features/account/screens/done_backup_screen.dart';
import 'package:fusecash/features/account/screens/profile.dart';
import 'package:fusecash/features/account/screens/protect_your_wallet.dart';
import 'package:fusecash/features/account/screens/settings.dart';
import 'package:fusecash/features/account/screens/show_mnemonic.dart';
import 'package:fusecash/features/account/screens/social_screen.dart';
import 'package:fusecash/features/account/screens/verify_mnemonic.dart';


const accountTab = AutoRoute(
  path: 'account',
  name: 'accountTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      page: AccountScreen,
      name: 'accountScreen',
      initial: true,
    ),
    AutoRoute(
      page: ShowMnemonic,
    ),
    AutoRoute(
      page: VerifyMnemonic,
    ),
    AutoRoute(
      page: DoneBackup,
    ),
    AutoRoute(
      page: SettingsScreen,
    ),
    AutoRoute(
      page: ProtectYourWallet,
    ),
    AutoRoute(
      page: ProfileScreen,
    ),
    AutoRoute(
      page: SocialScreen,
    ),
  ],
);
