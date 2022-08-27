// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:charge_wallet_sdk/charge_wallet_sdk.dart' as _i36;
import 'package:contacts_service/contacts_service.dart' as _i35;
import 'package:flutter/material.dart' as _i32;

import '../../features/account/screens/account_screen.dart' as _i23;
import '../../features/account/screens/connected_dapps.dart' as _i30;
import '../../features/account/screens/done_backup_screen.dart' as _i26;
import '../../features/account/screens/profile.dart' as _i29;
import '../../features/account/screens/protect_your_wallet.dart' as _i28;
import '../../features/account/screens/settings.dart' as _i27;
import '../../features/account/screens/show_mnemonic.dart' as _i24;
import '../../features/account/screens/verify_mnemonic.dart' as _i25;
import '../../features/account/screens/verify_verifiable_credential.dart'
    as _i31;
import '../../features/home/screens/action_details.dart' as _i13;
import '../../features/home/screens/home.dart' as _i12;
import '../../features/onboard/screens/restore_wallet_screen.dart' as _i4;
import '../../features/onboard/screens/security_screen.dart' as _i2;
import '../../features/onboard/screens/signup_screen.dart' as _i6;
import '../../features/onboard/screens/username_screen.dart' as _i8;
import '../../features/onboard/screens/verify_screen.dart' as _i7;
import '../../features/screens/main_screen.dart' as _i10;
import '../../features/screens/on_board_screen.dart' as _i5;
import '../../features/screens/pincode_screen.dart' as _i3;
import '../../features/screens/splash_screen.dart' as _i1;
import '../../features/screens/webview_screen.dart' as _i9;
import '../../features/swap/screens/review_swap.dart' as _i22;
import '../../features/swap/screens/swap.dart' as _i21;
import '../../features/wallet/screens/collectible.dart' as _i16;
import '../../features/wallet/screens/contacts_list.dart' as _i17;
import '../../features/wallet/screens/send_amount.dart' as _i18;
import '../../features/wallet/screens/send_review.dart' as _i19;
import '../../features/wallet/screens/send_success.dart' as _i20;
import '../../features/wallet/screens/token.dart' as _i15;
import '../../features/wallet/screens/wallet.dart' as _i14;
import '../../features/wallet/send_amount_arguments.dart' as _i37;
import '../../models/actions/wallet_action.dart' as _i34;
import '../../models/tokens/token.dart' as _i38;
import 'route_guards.dart' as _i33;

class RootRouter extends _i11.RootStackRouter {
  RootRouter(
      {_i32.GlobalKey<_i32.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i33.AuthGuard authGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i1.SplashPage(key: args.key, onLoginResult: args.onLoginResult));
    },
    ChooseSecurityRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ChooseSecurityPage());
    },
    PinCodeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.PinCodePage());
    },
    RestoreWalletRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RestoreWalletPage());
    },
    OnBoardingRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.OnBoardingPage());
    },
    SignUpRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SignUpPage());
    },
    VerifyPhoneNumberRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyPhoneNumberRouteArgs>(
          orElse: () => const VerifyPhoneNumberRouteArgs());
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.VerifyPhoneNumberPage(
              verificationId: args.verificationId, key: args.key));
    },
    UserNameRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.UserNamePage());
    },
    Webview.name: (routeData) {
      final args = routeData.argsAs<WebviewArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WebViewPage(args.url, args.title,
              onPageStarted: args.onPageStarted, key: args.key),
          fullscreenDialog: true);
    },
    MainRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.MainPage());
    },
    HomeTab.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    WalletTab.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    SwapTab.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    AccountTab.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.HomePage());
    },
    ActionDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ActionDetailsRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.ActionDetailsPage(
              key: args.key,
              action: args.action,
              image: args.image,
              displayName: args.displayName,
              accountAddress: args.accountAddress,
              symbol: args.symbol,
              contact: args.contact));
    },
    WalletRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.WalletPage());
    },
    TokenRoute.name: (routeData) {
      final args = routeData.argsAs<TokenRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i15.TokenPage(key: args.key, tokenAddress: args.tokenAddress));
    },
    CollectibleRoute.name: (routeData) {
      final args = routeData.argsAs<CollectibleRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i16.CollectiblePage(
              key: args.key, collectible: args.collectible));
    },
    ContactsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsRouteArgs>(
          orElse: () => const ContactsRouteArgs());
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.ContactsPage(key: args.key, pageArgs: args.pageArgs));
    },
    SendAmountRoute.name: (routeData) {
      final args = routeData.argsAs<SendAmountRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i18.SendAmountPage(pageArgs: args.pageArgs, key: args.key));
    },
    SendReviewRoute.name: (routeData) {
      final args = routeData.argsAs<SendReviewRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i19.SendReviewPage(pageArgs: args.pageArgs, key: args.key));
    },
    SendSuccessRoute.name: (routeData) {
      final args = routeData.argsAs<SendSuccessRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i20.SendSuccessPage(pageArgs: args.pageArgs, key: args.key));
    },
    SwapRoute.name: (routeData) {
      final args =
          routeData.argsAs<SwapRouteArgs>(orElse: () => const SwapRouteArgs());
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i21.SwapPage(key: args.key, primaryToken: args.primaryToken));
    },
    ReviewSwapRoute.name: (routeData) {
      final args = routeData.argsAs<ReviewSwapRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i22.ReviewSwapPage(
              rateInfo: args.rateInfo,
              tradeInfo: args.tradeInfo,
              swapRequestBody: args.swapRequestBody,
              key: args.key));
    },
    AccountRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.AccountPage());
    },
    ShowMnemonicRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i24.ShowMnemonicPage());
    },
    VerifyMnemonicRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i25.VerifyMnemonicPage());
    },
    DoneBackupRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i26.DoneBackupPage());
    },
    SettingsRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i27.SettingsPage());
    },
    ProtectYourWalletRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i28.ProtectYourWalletPage());
    },
    ProfileRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i29.ProfilePage());
    },
    ConnectedDAppsRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i30.ConnectedDAppsPage());
    },
    VerifyVerifiableCredentialRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i31.VerifyVerifiableCredentialPage());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(SplashRoute.name, path: '/'),
        _i11.RouteConfig(ChooseSecurityRoute.name,
            path: '/choose-security-page'),
        _i11.RouteConfig(PinCodeRoute.name, path: '/pin-code-page'),
        _i11.RouteConfig(RestoreWalletRoute.name, path: '/restore-wallet-page'),
        _i11.RouteConfig(OnBoardingRoute.name, path: '/on-boarding-page'),
        _i11.RouteConfig(SignUpRoute.name, path: '/sign-up-page'),
        _i11.RouteConfig(VerifyPhoneNumberRoute.name,
            path: '/verify-phone-number-page'),
        _i11.RouteConfig(UserNameRoute.name, path: '/user-name-page'),
        _i11.RouteConfig(Webview.name, path: '/web-view-page'),
        _i11.RouteConfig(MainRoute.name, path: '/main-page', guards: [
          authGuard
        ], children: [
          _i11.RouteConfig(HomeTab.name,
              path: 'home',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(HomeRoute.name,
                    path: '', parent: HomeTab.name),
                _i11.RouteConfig(ActionDetailsRoute.name,
                    path: 'action-details', parent: HomeTab.name)
              ]),
          _i11.RouteConfig(WalletTab.name,
              path: 'wallet',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(WalletRoute.name,
                    path: '', parent: WalletTab.name),
                _i11.RouteConfig(ActionDetailsRoute.name,
                    path: 'action-details', parent: WalletTab.name),
                _i11.RouteConfig(TokenRoute.name,
                    path: 'token-page', parent: WalletTab.name),
                _i11.RouteConfig(CollectibleRoute.name,
                    path: 'collectible-page', parent: WalletTab.name),
                _i11.RouteConfig(ContactsRoute.name,
                    path: 'contacts-page', parent: WalletTab.name),
                _i11.RouteConfig(SendAmountRoute.name,
                    path: 'send-amount', parent: WalletTab.name),
                _i11.RouteConfig(SendReviewRoute.name,
                    path: 'send-review', parent: WalletTab.name),
                _i11.RouteConfig(SendSuccessRoute.name,
                    path: 'send-success', parent: WalletTab.name)
              ]),
          _i11.RouteConfig(SwapTab.name,
              path: 'swap',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(SwapRoute.name,
                    path: '', parent: SwapTab.name),
                _i11.RouteConfig(ReviewSwapRoute.name,
                    path: 'review-swap-page', parent: SwapTab.name)
              ]),
          _i11.RouteConfig(AccountTab.name,
              path: 'account',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(AccountRoute.name,
                    path: '', parent: AccountTab.name),
                _i11.RouteConfig(ShowMnemonicRoute.name,
                    path: 'show-mnemonic-page', parent: AccountTab.name),
                _i11.RouteConfig(VerifyMnemonicRoute.name,
                    path: 'verify-mnemonic-page', parent: AccountTab.name),
                _i11.RouteConfig(DoneBackupRoute.name,
                    path: 'done-backup-page', parent: AccountTab.name),
                _i11.RouteConfig(SettingsRoute.name,
                    path: 'settings-page', parent: AccountTab.name),
                _i11.RouteConfig(ProtectYourWalletRoute.name,
                    path: 'protect-your-wallet-page', parent: AccountTab.name),
                _i11.RouteConfig(ProfileRoute.name,
                    path: 'profile-page', parent: AccountTab.name),
                _i11.RouteConfig(ConnectedDAppsRoute.name,
                    path: 'connected-dapps-page', parent: AccountTab.name),
                _i11.RouteConfig(VerifyVerifiableCredentialRoute.name,
                    path: 'verify-verifiable-credential-page',
                    parent: AccountTab.name)
              ])
        ]),
        _i11.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({_i32.Key? key, void Function(bool)? onLoginResult})
      : super(SplashRoute.name,
            path: '/',
            args: SplashRouteArgs(key: key, onLoginResult: onLoginResult));

  static const String name = 'SplashRoute';
}

class SplashRouteArgs {
  const SplashRouteArgs({this.key, this.onLoginResult});

  final _i32.Key? key;

  final void Function(bool)? onLoginResult;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, onLoginResult: $onLoginResult}';
  }
}

/// generated route for
/// [_i2.ChooseSecurityPage]
class ChooseSecurityRoute extends _i11.PageRouteInfo<void> {
  const ChooseSecurityRoute()
      : super(ChooseSecurityRoute.name, path: '/choose-security-page');

  static const String name = 'ChooseSecurityRoute';
}

/// generated route for
/// [_i3.PinCodePage]
class PinCodeRoute extends _i11.PageRouteInfo<void> {
  const PinCodeRoute() : super(PinCodeRoute.name, path: '/pin-code-page');

  static const String name = 'PinCodeRoute';
}

/// generated route for
/// [_i4.RestoreWalletPage]
class RestoreWalletRoute extends _i11.PageRouteInfo<void> {
  const RestoreWalletRoute()
      : super(RestoreWalletRoute.name, path: '/restore-wallet-page');

  static const String name = 'RestoreWalletRoute';
}

/// generated route for
/// [_i5.OnBoardingPage]
class OnBoardingRoute extends _i11.PageRouteInfo<void> {
  const OnBoardingRoute()
      : super(OnBoardingRoute.name, path: '/on-boarding-page');

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i6.SignUpPage]
class SignUpRoute extends _i11.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/sign-up-page');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i7.VerifyPhoneNumberPage]
class VerifyPhoneNumberRoute
    extends _i11.PageRouteInfo<VerifyPhoneNumberRouteArgs> {
  VerifyPhoneNumberRoute({String? verificationId, _i32.Key? key})
      : super(VerifyPhoneNumberRoute.name,
            path: '/verify-phone-number-page',
            args: VerifyPhoneNumberRouteArgs(
                verificationId: verificationId, key: key));

  static const String name = 'VerifyPhoneNumberRoute';
}

class VerifyPhoneNumberRouteArgs {
  const VerifyPhoneNumberRouteArgs({this.verificationId, this.key});

  final String? verificationId;

  final _i32.Key? key;

  @override
  String toString() {
    return 'VerifyPhoneNumberRouteArgs{verificationId: $verificationId, key: $key}';
  }
}

/// generated route for
/// [_i8.UserNamePage]
class UserNameRoute extends _i11.PageRouteInfo<void> {
  const UserNameRoute() : super(UserNameRoute.name, path: '/user-name-page');

  static const String name = 'UserNameRoute';
}

/// generated route for
/// [_i9.WebViewPage]
class Webview extends _i11.PageRouteInfo<WebviewArgs> {
  Webview(
      {required String url,
      required String title,
      void Function(String)? onPageStarted,
      _i32.Key? key})
      : super(Webview.name,
            path: '/web-view-page',
            args: WebviewArgs(
                url: url,
                title: title,
                onPageStarted: onPageStarted,
                key: key));

  static const String name = 'Webview';
}

class WebviewArgs {
  const WebviewArgs(
      {required this.url, required this.title, this.onPageStarted, this.key});

  final String url;

  final String title;

  final void Function(String)? onPageStarted;

  final _i32.Key? key;

  @override
  String toString() {
    return 'WebviewArgs{url: $url, title: $title, onPageStarted: $onPageStarted, key: $key}';
  }
}

/// generated route for
/// [_i10.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(MainRoute.name, path: '/main-page', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class HomeTab extends _i11.PageRouteInfo<void> {
  const HomeTab({List<_i11.PageRouteInfo>? children})
      : super(HomeTab.name, path: 'home', initialChildren: children);

  static const String name = 'HomeTab';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class WalletTab extends _i11.PageRouteInfo<void> {
  const WalletTab({List<_i11.PageRouteInfo>? children})
      : super(WalletTab.name, path: 'wallet', initialChildren: children);

  static const String name = 'WalletTab';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class SwapTab extends _i11.PageRouteInfo<void> {
  const SwapTab({List<_i11.PageRouteInfo>? children})
      : super(SwapTab.name, path: 'swap', initialChildren: children);

  static const String name = 'SwapTab';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class AccountTab extends _i11.PageRouteInfo<void> {
  const AccountTab({List<_i11.PageRouteInfo>? children})
      : super(AccountTab.name, path: 'account', initialChildren: children);

  static const String name = 'AccountTab';
}

/// generated route for
/// [_i12.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i13.ActionDetailsPage]
class ActionDetailsRoute extends _i11.PageRouteInfo<ActionDetailsRouteArgs> {
  ActionDetailsRoute(
      {_i32.Key? key,
      required _i34.WalletAction action,
      _i32.ImageProvider<Object>? image,
      required String displayName,
      String? accountAddress,
      required String symbol,
      _i35.Contact? contact})
      : super(ActionDetailsRoute.name,
            path: 'action-details',
            args: ActionDetailsRouteArgs(
                key: key,
                action: action,
                image: image,
                displayName: displayName,
                accountAddress: accountAddress,
                symbol: symbol,
                contact: contact));

  static const String name = 'ActionDetailsRoute';
}

class ActionDetailsRouteArgs {
  const ActionDetailsRouteArgs(
      {this.key,
      required this.action,
      this.image,
      required this.displayName,
      this.accountAddress,
      required this.symbol,
      this.contact});

  final _i32.Key? key;

  final _i34.WalletAction action;

  final _i32.ImageProvider<Object>? image;

  final String displayName;

  final String? accountAddress;

  final String symbol;

  final _i35.Contact? contact;

  @override
  String toString() {
    return 'ActionDetailsRouteArgs{key: $key, action: $action, image: $image, displayName: $displayName, accountAddress: $accountAddress, symbol: $symbol, contact: $contact}';
  }
}

/// generated route for
/// [_i14.WalletPage]
class WalletRoute extends _i11.PageRouteInfo<void> {
  const WalletRoute() : super(WalletRoute.name, path: '');

  static const String name = 'WalletRoute';
}

/// generated route for
/// [_i15.TokenPage]
class TokenRoute extends _i11.PageRouteInfo<TokenRouteArgs> {
  TokenRoute({_i32.Key? key, required String tokenAddress})
      : super(TokenRoute.name,
            path: 'token-page',
            args: TokenRouteArgs(key: key, tokenAddress: tokenAddress));

  static const String name = 'TokenRoute';
}

class TokenRouteArgs {
  const TokenRouteArgs({this.key, required this.tokenAddress});

  final _i32.Key? key;

  final String tokenAddress;

  @override
  String toString() {
    return 'TokenRouteArgs{key: $key, tokenAddress: $tokenAddress}';
  }
}

/// generated route for
/// [_i16.CollectiblePage]
class CollectibleRoute extends _i11.PageRouteInfo<CollectibleRouteArgs> {
  CollectibleRoute({_i32.Key? key, required _i36.Collectible collectible})
      : super(CollectibleRoute.name,
            path: 'collectible-page',
            args: CollectibleRouteArgs(key: key, collectible: collectible));

  static const String name = 'CollectibleRoute';
}

class CollectibleRouteArgs {
  const CollectibleRouteArgs({this.key, required this.collectible});

  final _i32.Key? key;

  final _i36.Collectible collectible;

  @override
  String toString() {
    return 'CollectibleRouteArgs{key: $key, collectible: $collectible}';
  }
}

/// generated route for
/// [_i17.ContactsPage]
class ContactsRoute extends _i11.PageRouteInfo<ContactsRouteArgs> {
  ContactsRoute({_i32.Key? key, _i37.SendFlowArguments? pageArgs})
      : super(ContactsRoute.name,
            path: 'contacts-page',
            args: ContactsRouteArgs(key: key, pageArgs: pageArgs));

  static const String name = 'ContactsRoute';
}

class ContactsRouteArgs {
  const ContactsRouteArgs({this.key, this.pageArgs});

  final _i32.Key? key;

  final _i37.SendFlowArguments? pageArgs;

  @override
  String toString() {
    return 'ContactsRouteArgs{key: $key, pageArgs: $pageArgs}';
  }
}

/// generated route for
/// [_i18.SendAmountPage]
class SendAmountRoute extends _i11.PageRouteInfo<SendAmountRouteArgs> {
  SendAmountRoute({required _i37.SendFlowArguments pageArgs, _i32.Key? key})
      : super(SendAmountRoute.name,
            path: 'send-amount',
            args: SendAmountRouteArgs(pageArgs: pageArgs, key: key));

  static const String name = 'SendAmountRoute';
}

class SendAmountRouteArgs {
  const SendAmountRouteArgs({required this.pageArgs, this.key});

  final _i37.SendFlowArguments pageArgs;

  final _i32.Key? key;

  @override
  String toString() {
    return 'SendAmountRouteArgs{pageArgs: $pageArgs, key: $key}';
  }
}

/// generated route for
/// [_i19.SendReviewPage]
class SendReviewRoute extends _i11.PageRouteInfo<SendReviewRouteArgs> {
  SendReviewRoute({required _i37.SendFlowArguments pageArgs, _i32.Key? key})
      : super(SendReviewRoute.name,
            path: 'send-review',
            args: SendReviewRouteArgs(pageArgs: pageArgs, key: key));

  static const String name = 'SendReviewRoute';
}

class SendReviewRouteArgs {
  const SendReviewRouteArgs({required this.pageArgs, this.key});

  final _i37.SendFlowArguments pageArgs;

  final _i32.Key? key;

  @override
  String toString() {
    return 'SendReviewRouteArgs{pageArgs: $pageArgs, key: $key}';
  }
}

/// generated route for
/// [_i20.SendSuccessPage]
class SendSuccessRoute extends _i11.PageRouteInfo<SendSuccessRouteArgs> {
  SendSuccessRoute({required _i37.SendFlowArguments pageArgs, _i32.Key? key})
      : super(SendSuccessRoute.name,
            path: 'send-success',
            args: SendSuccessRouteArgs(pageArgs: pageArgs, key: key));

  static const String name = 'SendSuccessRoute';
}

class SendSuccessRouteArgs {
  const SendSuccessRouteArgs({required this.pageArgs, this.key});

  final _i37.SendFlowArguments pageArgs;

  final _i32.Key? key;

  @override
  String toString() {
    return 'SendSuccessRouteArgs{pageArgs: $pageArgs, key: $key}';
  }
}

/// generated route for
/// [_i21.SwapPage]
class SwapRoute extends _i11.PageRouteInfo<SwapRouteArgs> {
  SwapRoute({_i32.Key? key, _i38.Token? primaryToken})
      : super(SwapRoute.name,
            path: '',
            args: SwapRouteArgs(key: key, primaryToken: primaryToken));

  static const String name = 'SwapRoute';
}

class SwapRouteArgs {
  const SwapRouteArgs({this.key, this.primaryToken});

  final _i32.Key? key;

  final _i38.Token? primaryToken;

  @override
  String toString() {
    return 'SwapRouteArgs{key: $key, primaryToken: $primaryToken}';
  }
}

/// generated route for
/// [_i22.ReviewSwapPage]
class ReviewSwapRoute extends _i11.PageRouteInfo<ReviewSwapRouteArgs> {
  ReviewSwapRoute(
      {_i36.Trade? rateInfo,
      required _i36.Trade tradeInfo,
      required _i36.TradeRequestBody swapRequestBody,
      _i32.Key? key})
      : super(ReviewSwapRoute.name,
            path: 'review-swap-page',
            args: ReviewSwapRouteArgs(
                rateInfo: rateInfo,
                tradeInfo: tradeInfo,
                swapRequestBody: swapRequestBody,
                key: key));

  static const String name = 'ReviewSwapRoute';
}

class ReviewSwapRouteArgs {
  const ReviewSwapRouteArgs(
      {this.rateInfo,
      required this.tradeInfo,
      required this.swapRequestBody,
      this.key});

  final _i36.Trade? rateInfo;

  final _i36.Trade tradeInfo;

  final _i36.TradeRequestBody swapRequestBody;

  final _i32.Key? key;

  @override
  String toString() {
    return 'ReviewSwapRouteArgs{rateInfo: $rateInfo, tradeInfo: $tradeInfo, swapRequestBody: $swapRequestBody, key: $key}';
  }
}

/// generated route for
/// [_i23.AccountPage]
class AccountRoute extends _i11.PageRouteInfo<void> {
  const AccountRoute() : super(AccountRoute.name, path: '');

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i24.ShowMnemonicPage]
class ShowMnemonicRoute extends _i11.PageRouteInfo<void> {
  const ShowMnemonicRoute()
      : super(ShowMnemonicRoute.name, path: 'show-mnemonic-page');

  static const String name = 'ShowMnemonicRoute';
}

/// generated route for
/// [_i25.VerifyMnemonicPage]
class VerifyMnemonicRoute extends _i11.PageRouteInfo<void> {
  const VerifyMnemonicRoute()
      : super(VerifyMnemonicRoute.name, path: 'verify-mnemonic-page');

  static const String name = 'VerifyMnemonicRoute';
}

/// generated route for
/// [_i26.DoneBackupPage]
class DoneBackupRoute extends _i11.PageRouteInfo<void> {
  const DoneBackupRoute()
      : super(DoneBackupRoute.name, path: 'done-backup-page');

  static const String name = 'DoneBackupRoute';
}

/// generated route for
/// [_i27.SettingsPage]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i28.ProtectYourWalletPage]
class ProtectYourWalletRoute extends _i11.PageRouteInfo<void> {
  const ProtectYourWalletRoute()
      : super(ProtectYourWalletRoute.name, path: 'protect-your-wallet-page');

  static const String name = 'ProtectYourWalletRoute';
}

/// generated route for
/// [_i29.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile-page');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i30.ConnectedDAppsPage]
class ConnectedDAppsRoute extends _i11.PageRouteInfo<void> {
  const ConnectedDAppsRoute()
      : super(ConnectedDAppsRoute.name, path: 'connected-dapps-page');

  static const String name = 'ConnectedDAppsRoute';
}

/// generated route for
/// [_i31.VerifyVerifiableCredentialPage]
class VerifyVerifiableCredentialRoute extends _i11.PageRouteInfo<void> {
  const VerifyVerifiableCredentialRoute()
      : super(VerifyVerifiableCredentialRoute.name,
            path: 'verify-verifiable-credential-page');

  static const String name = 'VerifyVerifiableCredentialRoute';
}
