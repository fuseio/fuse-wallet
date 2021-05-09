// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:contacts_service/contacts_service.dart' as _i30;
import 'package:flutter/material.dart' as _i2;

import '../../features/account/screens/account_screen.dart' as _i21;
import '../../features/account/screens/done_backup_screen.dart' as _i24;
import '../../features/account/screens/profile.dart' as _i27;
import '../../features/account/screens/protect_your_wallet.dart' as _i26;
import '../../features/account/screens/settings.dart' as _i25;
import '../../features/account/screens/show_mnemonic.dart' as _i22;
import '../../features/account/screens/social_screen.dart' as _i28;
import '../../features/account/screens/verify_mnemonic.dart' as _i23;
import '../../features/contacts/screens/contacts_list.dart' as _i19;
import '../../features/contacts/send_amount_arguments.dart' as _i31;
import '../../features/home/screens/action_details.dart' as _i12;
import '../../features/home/screens/home.dart' as _i18;
import '../../features/onboard/screens/restore_wallet_screen.dart' as _i6;
import '../../features/onboard/screens/security_screen.dart' as _i4;
import '../../features/onboard/screens/signup_screen.dart' as _i8;
import '../../features/onboard/screens/username_screen.dart' as _i10;
import '../../features/onboard/screens/verify_screen.dart' as _i9;
import '../../features/screens/home_screen.dart' as _i17;
import '../../features/screens/on_board_screen.dart' as _i7;
import '../../features/screens/pincode_screen.dart' as _i5;
import '../../features/screens/send_amount.dart' as _i13;
import '../../features/screens/send_review.dart' as _i14;
import '../../features/screens/send_success.dart' as _i15;
import '../../features/screens/splash_screen.dart' as _i3;
import '../../features/screens/webview_screen.dart' as _i11;
import '../../features/swap/screens/review_swap.dart' as _i16;
import '../../features/swap/screens/swap.dart' as _i20;
import '../../models/actions/wallet_action.dart' as _i29;
import '../../models/swap/swap.dart' as _i32;
import '../../models/tokens/token.dart' as _i33;

class RootRouter extends _i1.RootStackRouter {
  RootRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SplashScreen();
        }),
    SecurityScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.SecurityScreen();
        }),
    PinCodeScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.PinCodeScreen();
        }),
    RecoveryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.RecoveryPage();
        }),
    OnBoardScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.OnBoardScreen();
        }),
    SignUpScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.SignUpScreen();
        }),
    VerifyScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<VerifyScreenArgs>(
              orElse: () => const VerifyScreenArgs());
          return _i9.VerifyScreen(verificationId: args.verificationId);
        }),
    UserNameScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.UserNameScreen();
        }),
    Webview.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<WebviewArgs>(orElse: () => const WebviewArgs());
          return _i11.WebViewScreen(
              url: args.url, title: args.title, withBack: args.withBack);
        },
        fullscreenDialog: true),
    ActionDetailsScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ActionDetailsScreenArgs>(
              orElse: () => const ActionDetailsScreenArgs());
          return _i12.ActionDetailsScreen(
              action: args.action,
              image: args.image,
              displayName: args.displayName,
              accountAddress: args.accountAddress,
              symbol: args.symbol,
              contact: args.contact);
        }),
    SendAmountScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SendAmountScreenArgs>(
              orElse: () => const SendAmountScreenArgs());
          return _i13.SendAmountScreen(pageArgs: args.pageArgs);
        }),
    SendReviewScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SendReviewScreenArgs>(
              orElse: () => const SendReviewScreenArgs());
          return _i14.SendReviewScreen(pageArgs: args.pageArgs);
        }),
    SendSuccessScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SendSuccessScreenArgs>(
              orElse: () => const SendSuccessScreenArgs());
          return _i15.SendSuccessScreen(pageArgs: args.pageArgs);
        }),
    ReviewSwapScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ReviewSwapScreenArgs>(
              orElse: () => const ReviewSwapScreenArgs());
          return _i16.ReviewSwapScreen(
              tradeInfo: args.tradeInfo,
              rateInfo: args.rateInfo,
              swapRequestBody: args.swapRequestBody);
        }),
    MainHomeScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MainHomeScreenArgs>(
              orElse: () => const MainHomeScreenArgs());
          return _i17.MainHomeScreen(key: args.key);
        }),
    HomeTab.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    ContactsTab.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    SwapTab.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    AccountTab.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    HomeScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i18.HomeScreen();
        }),
    ContactsList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ContactsListArgs>(
              orElse: () => const ContactsListArgs());
          return _i19.ContactsList(
              pageArgs: args.pageArgs,
              automaticallyImplyLeading: args.automaticallyImplyLeading);
        }),
    SwapScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<SwapScreenArgs>(orElse: () => const SwapScreenArgs());
          return _i20.SwapScreen(
              key: args.key, primaryToken: args.primaryToken);
        }),
    AccountScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i21.AccountScreen();
        }),
    ShowMnemonic.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i22.ShowMnemonic();
        }),
    VerifyMnemonic.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i23.VerifyMnemonic();
        }),
    DoneBackup.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i24.DoneBackup();
        }),
    SettingsScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i25.SettingsScreen();
        }),
    ProtectYourWallet.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i26.ProtectYourWallet();
        }),
    ProfileScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ProfileScreenArgs>(
              orElse: () => const ProfileScreenArgs());
          return _i27.ProfileScreen(key: args.key);
        }),
    SocialScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i28.SocialScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreen.name, path: '/'),
        _i1.RouteConfig(SecurityScreen.name, path: '/security-screen'),
        _i1.RouteConfig(PinCodeScreen.name, path: '/pin-code-screen'),
        _i1.RouteConfig(RecoveryRoute.name, path: '/recovery-page'),
        _i1.RouteConfig(OnBoardScreen.name, path: '/on-board-screen'),
        _i1.RouteConfig(SignUpScreen.name, path: '/sign-up-screen'),
        _i1.RouteConfig(VerifyScreen.name, path: '/verify-screen'),
        _i1.RouteConfig(UserNameScreen.name, path: '/user-name-screen'),
        _i1.RouteConfig(Webview.name, path: '/web-view-screen'),
        _i1.RouteConfig(ActionDetailsScreen.name,
            path: '/action-details-screen'),
        _i1.RouteConfig(SendAmountScreen.name, path: '/send-amount-screen'),
        _i1.RouteConfig(SendReviewScreen.name, path: '/send-review-screen'),
        _i1.RouteConfig(SendSuccessScreen.name, path: '/send-success-screen'),
        _i1.RouteConfig(ReviewSwapScreen.name, path: '/review-swap-screen'),
        _i1.RouteConfig(MainHomeScreen.name, path: '/', children: [
          _i1.RouteConfig(HomeTab.name,
              path: 'home',
              children: [_i1.RouteConfig(HomeScreen.name, path: '')]),
          _i1.RouteConfig(ContactsTab.name,
              path: 'contacts',
              children: [_i1.RouteConfig(ContactsList.name, path: '')]),
          _i1.RouteConfig(SwapTab.name,
              path: 'swap',
              children: [_i1.RouteConfig(SwapScreen.name, path: '')]),
          _i1.RouteConfig(AccountTab.name, path: 'account', children: [
            _i1.RouteConfig(AccountScreen.name, path: ''),
            _i1.RouteConfig(ShowMnemonic.name, path: 'show-mnemonic'),
            _i1.RouteConfig(VerifyMnemonic.name, path: 'verify-mnemonic'),
            _i1.RouteConfig(DoneBackup.name, path: 'done-backup'),
            _i1.RouteConfig(SettingsScreen.name, path: 'settings-screen'),
            _i1.RouteConfig(ProtectYourWallet.name,
                path: 'protect-your-wallet'),
            _i1.RouteConfig(ProfileScreen.name, path: 'profile-screen'),
            _i1.RouteConfig(SocialScreen.name, path: 'social-screen')
          ])
        ]),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class SplashScreen extends _i1.PageRouteInfo {
  const SplashScreen() : super(name, path: '/');

  static const String name = 'SplashScreen';
}

class SecurityScreen extends _i1.PageRouteInfo {
  const SecurityScreen() : super(name, path: '/security-screen');

  static const String name = 'SecurityScreen';
}

class PinCodeScreen extends _i1.PageRouteInfo {
  const PinCodeScreen() : super(name, path: '/pin-code-screen');

  static const String name = 'PinCodeScreen';
}

class RecoveryRoute extends _i1.PageRouteInfo {
  const RecoveryRoute() : super(name, path: '/recovery-page');

  static const String name = 'RecoveryRoute';
}

class OnBoardScreen extends _i1.PageRouteInfo {
  const OnBoardScreen() : super(name, path: '/on-board-screen');

  static const String name = 'OnBoardScreen';
}

class SignUpScreen extends _i1.PageRouteInfo {
  const SignUpScreen() : super(name, path: '/sign-up-screen');

  static const String name = 'SignUpScreen';
}

class VerifyScreen extends _i1.PageRouteInfo<VerifyScreenArgs> {
  VerifyScreen({String verificationId})
      : super(name,
            path: '/verify-screen',
            args: VerifyScreenArgs(verificationId: verificationId));

  static const String name = 'VerifyScreen';
}

class VerifyScreenArgs {
  const VerifyScreenArgs({this.verificationId});

  final String verificationId;
}

class UserNameScreen extends _i1.PageRouteInfo {
  const UserNameScreen() : super(name, path: '/user-name-screen');

  static const String name = 'UserNameScreen';
}

class Webview extends _i1.PageRouteInfo<WebviewArgs> {
  Webview({String url, String title, bool withBack = false})
      : super(name,
            path: '/web-view-screen',
            args: WebviewArgs(url: url, title: title, withBack: withBack));

  static const String name = 'Webview';
}

class WebviewArgs {
  const WebviewArgs({this.url, this.title, this.withBack = false});

  final String url;

  final String title;

  final bool withBack;
}

class ActionDetailsScreen extends _i1.PageRouteInfo<ActionDetailsScreenArgs> {
  ActionDetailsScreen(
      {_i29.WalletAction action,
      _i2.ImageProvider<dynamic> image,
      String displayName,
      String accountAddress,
      String symbol,
      _i30.Contact contact})
      : super(name,
            path: '/action-details-screen',
            args: ActionDetailsScreenArgs(
                action: action,
                image: image,
                displayName: displayName,
                accountAddress: accountAddress,
                symbol: symbol,
                contact: contact));

  static const String name = 'ActionDetailsScreen';
}

class ActionDetailsScreenArgs {
  const ActionDetailsScreenArgs(
      {this.action,
      this.image,
      this.displayName,
      this.accountAddress,
      this.symbol,
      this.contact});

  final _i29.WalletAction action;

  final _i2.ImageProvider<dynamic> image;

  final String displayName;

  final String accountAddress;

  final String symbol;

  final _i30.Contact contact;
}

class SendAmountScreen extends _i1.PageRouteInfo<SendAmountScreenArgs> {
  SendAmountScreen({_i31.SendFlowArguments pageArgs})
      : super(name,
            path: '/send-amount-screen',
            args: SendAmountScreenArgs(pageArgs: pageArgs));

  static const String name = 'SendAmountScreen';
}

class SendAmountScreenArgs {
  const SendAmountScreenArgs({this.pageArgs});

  final _i31.SendFlowArguments pageArgs;
}

class SendReviewScreen extends _i1.PageRouteInfo<SendReviewScreenArgs> {
  SendReviewScreen({_i31.SendFlowArguments pageArgs})
      : super(name,
            path: '/send-review-screen',
            args: SendReviewScreenArgs(pageArgs: pageArgs));

  static const String name = 'SendReviewScreen';
}

class SendReviewScreenArgs {
  const SendReviewScreenArgs({this.pageArgs});

  final _i31.SendFlowArguments pageArgs;
}

class SendSuccessScreen extends _i1.PageRouteInfo<SendSuccessScreenArgs> {
  SendSuccessScreen({_i31.SendFlowArguments pageArgs})
      : super(name,
            path: '/send-success-screen',
            args: SendSuccessScreenArgs(pageArgs: pageArgs));

  static const String name = 'SendSuccessScreen';
}

class SendSuccessScreenArgs {
  const SendSuccessScreenArgs({this.pageArgs});

  final _i31.SendFlowArguments pageArgs;
}

class ReviewSwapScreen extends _i1.PageRouteInfo<ReviewSwapScreenArgs> {
  ReviewSwapScreen(
      {_i32.TradeInfo tradeInfo,
      _i32.TradeInfo rateInfo,
      _i32.SwapRequestBody swapRequestBody})
      : super(name,
            path: '/review-swap-screen',
            args: ReviewSwapScreenArgs(
                tradeInfo: tradeInfo,
                rateInfo: rateInfo,
                swapRequestBody: swapRequestBody));

  static const String name = 'ReviewSwapScreen';
}

class ReviewSwapScreenArgs {
  const ReviewSwapScreenArgs(
      {this.tradeInfo, this.rateInfo, this.swapRequestBody});

  final _i32.TradeInfo tradeInfo;

  final _i32.TradeInfo rateInfo;

  final _i32.SwapRequestBody swapRequestBody;
}

class MainHomeScreen extends _i1.PageRouteInfo<MainHomeScreenArgs> {
  MainHomeScreen({_i2.Key key, List<_i1.PageRouteInfo>? children})
      : super(name,
            path: '/',
            args: MainHomeScreenArgs(key: key),
            initialChildren: children);

  static const String name = 'MainHomeScreen';
}

class MainHomeScreenArgs {
  const MainHomeScreenArgs({this.key});

  final _i2.Key key;
}

class HomeTab extends _i1.PageRouteInfo {
  const HomeTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'home', initialChildren: children);

  static const String name = 'HomeTab';
}

class ContactsTab extends _i1.PageRouteInfo {
  const ContactsTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'contacts', initialChildren: children);

  static const String name = 'ContactsTab';
}

class SwapTab extends _i1.PageRouteInfo {
  const SwapTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'swap', initialChildren: children);

  static const String name = 'SwapTab';
}

class AccountTab extends _i1.PageRouteInfo {
  const AccountTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'account', initialChildren: children);

  static const String name = 'AccountTab';
}

class HomeScreen extends _i1.PageRouteInfo {
  const HomeScreen() : super(name, path: '');

  static const String name = 'HomeScreen';
}

class ContactsList extends _i1.PageRouteInfo<ContactsListArgs> {
  ContactsList(
      {_i31.SendFlowArguments pageArgs, bool automaticallyImplyLeading = false})
      : super(name,
            path: '',
            args: ContactsListArgs(
                pageArgs: pageArgs,
                automaticallyImplyLeading: automaticallyImplyLeading));

  static const String name = 'ContactsList';
}

class ContactsListArgs {
  const ContactsListArgs(
      {this.pageArgs, this.automaticallyImplyLeading = false});

  final _i31.SendFlowArguments pageArgs;

  final bool automaticallyImplyLeading;
}

class SwapScreen extends _i1.PageRouteInfo<SwapScreenArgs> {
  SwapScreen({_i2.Key key, _i33.Token primaryToken})
      : super(name,
            path: '',
            args: SwapScreenArgs(key: key, primaryToken: primaryToken));

  static const String name = 'SwapScreen';
}

class SwapScreenArgs {
  const SwapScreenArgs({this.key, this.primaryToken});

  final _i2.Key key;

  final _i33.Token primaryToken;
}

class AccountScreen extends _i1.PageRouteInfo {
  const AccountScreen() : super(name, path: '');

  static const String name = 'AccountScreen';
}

class ShowMnemonic extends _i1.PageRouteInfo {
  const ShowMnemonic() : super(name, path: 'show-mnemonic');

  static const String name = 'ShowMnemonic';
}

class VerifyMnemonic extends _i1.PageRouteInfo {
  const VerifyMnemonic() : super(name, path: 'verify-mnemonic');

  static const String name = 'VerifyMnemonic';
}

class DoneBackup extends _i1.PageRouteInfo {
  const DoneBackup() : super(name, path: 'done-backup');

  static const String name = 'DoneBackup';
}

class SettingsScreen extends _i1.PageRouteInfo {
  const SettingsScreen() : super(name, path: 'settings-screen');

  static const String name = 'SettingsScreen';
}

class ProtectYourWallet extends _i1.PageRouteInfo {
  const ProtectYourWallet() : super(name, path: 'protect-your-wallet');

  static const String name = 'ProtectYourWallet';
}

class ProfileScreen extends _i1.PageRouteInfo<ProfileScreenArgs> {
  ProfileScreen({_i2.Key key})
      : super(name, path: 'profile-screen', args: ProfileScreenArgs(key: key));

  static const String name = 'ProfileScreen';
}

class ProfileScreenArgs {
  const ProfileScreenArgs({this.key});

  final _i2.Key key;
}

class SocialScreen extends _i1.PageRouteInfo {
  const SocialScreen() : super(name, path: 'social-screen');

  static const String name = 'SocialScreen';
}
