import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/account/screens/account_screen.dart';
import 'package:fusecash/features/account/screens/connected_dapps.dart';
import 'package:fusecash/features/account/screens/done_backup_screen.dart';
import 'package:fusecash/features/account/screens/profile.dart';
import 'package:fusecash/features/account/screens/protect_your_wallet.dart';
import 'package:fusecash/features/account/screens/settings.dart';
import 'package:fusecash/features/account/screens/show_mnemonic.dart';
import 'package:fusecash/features/account/screens/verify_mnemonic.dart';
import 'package:fusecash/features/account/screens/verify_credential.dart';

const accountTab = AutoRoute(
  path: 'account',
  name: 'accountTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      page: AccountPage,
      initial: true,
    ),
    AutoRoute(
      page: ShowMnemonicPage,
    ),
    AutoRoute(
      page: VerifyMnemonicPage,
    ),
    AutoRoute(
      page: DoneBackupPage,
    ),
    AutoRoute(
      page: SettingsPage,
    ),
    AutoRoute(
      page: ProtectYourWalletPage,
    ),
    AutoRoute(
      page: ProfilePage,
    ),
    AutoRoute(
      page: ConnectedDAppsPage,
    ),
    AutoRoute(
      page: VerifyCredentialPage,
    ),
  ],
);
