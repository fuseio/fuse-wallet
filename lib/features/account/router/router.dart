import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/account/screens/account_screen.dart';
import 'package:fusecash/features/account/screens/done_backup_screen.dart';
import 'package:fusecash/features/account/screens/profile.dart';
import 'package:fusecash/features/account/screens/protect_your_wallet.dart';
import 'package:fusecash/features/account/screens/settings.dart';
import 'package:fusecash/features/account/screens/show_mnemonic.dart';
import 'package:fusecash/features/account/screens/social_screen.dart';
import 'package:fusecash/features/account/screens/verify_mnemonic.dart';

@MaterialAutoRouter(
  routesClassName: "AccountRoutes",
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(
      page: AccountScreen,
      name: 'accountScreen',
      initial: true,
    ),
    MaterialRoute(page: ShowMnemonic),
    MaterialRoute(page: VerifyMnemonic),
    MaterialRoute(page: DoneBackup),
    MaterialRoute(page: SettingsScreen),
    MaterialRoute(page: ProtectYourWallet),
    MaterialRoute(page: ProfileScreen),
    MaterialRoute(page: SocialScreen),
  ],
)
class $AccountRouter {}
