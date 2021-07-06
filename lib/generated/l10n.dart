// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class I10n {
  I10n();

  static I10n? _current;

  static I10n get current {
    assert(_current != null,
        'No instance of I10n was loaded. Try to initialize the I10n delegate before accessing I10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I10n();
      I10n._current = instance;

      return instance;
    });
  }

  static I10n of(BuildContext context) {
    final instance = I10n.maybeOf(context);
    assert(instance != null,
        'No instance of I10n present in the widget tree. Did you add I10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static I10n? maybeOf(BuildContext context) {
    return Localizations.of<I10n>(context, I10n);
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message(
      'Activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Assets and contracts`
  String get assets_and_contracts {
    return Intl.message(
      'Assets and contracts',
      name: 'assets_and_contracts',
      desc: '',
      args: [],
    );
  }

  /// `Please try again to continue`
  String get auth_failed_message {
    return Intl.message(
      'Please try again to continue',
      name: 'auth_failed_message',
      desc: '',
      args: [],
    );
  }

  /// `Authentication failed`
  String get auth_failed_title {
    return Intl.message(
      'Authentication failed',
      name: 'auth_failed_title',
      desc: '',
      args: [],
    );
  }

  /// `available`
  String get available {
    return Intl.message(
      'available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Back up`
  String get back_up {
    return Intl.message(
      'Back up',
      name: 'back_up',
      desc: '',
      args: [],
    );
  }

  /// `Back up now`
  String get back_up_now {
    return Intl.message(
      'Back up now',
      name: 'back_up_now',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup_wallet {
    return Intl.message(
      'Backup',
      name: 'backup_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `bonus`
  String get bonus {
    return Intl.message(
      'bonus',
      name: 'bonus',
      desc: '',
      args: [],
    );
  }

  /// `Bridge ETH or BNB from Binance Smart Chain`
  String get bridge_from_BSC {
    return Intl.message(
      'Bridge ETH or BNB from Binance Smart Chain',
      name: 'bridge_from_BSC',
      desc: '',
      args: [],
    );
  }

  /// `Bridge assets from Ethereum network`
  String get bridge_from_ethereum {
    return Intl.message(
      'Bridge assets from Ethereum network',
      name: 'bridge_from_ethereum',
      desc: '',
      args: [],
    );
  }

  /// `Bridge to`
  String get bridge_to {
    return Intl.message(
      'Bridge to',
      name: 'bridge_to',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please choose how your prefer to protect your wallet by selecting the following methods`
  String get choose_lock_method {
    return Intl.message(
      'Please choose how your prefer to protect your wallet by selecting the following methods',
      name: 'choose_lock_method',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get coming_soon {
    return Intl.message(
      'Coming soon',
      name: 'coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `community`
  String get community {
    return Intl.message(
      'community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Community Address`
  String get community_address {
    return Intl.message(
      'Community Address',
      name: 'community_address',
      desc: '',
      args: [],
    );
  }

  /// `Community webpage`
  String get community_webpage {
    return Intl.message(
      'Community webpage',
      name: 'community_webpage',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRMED`
  String get confirmed {
    return Intl.message(
      'CONFIRMED',
      name: 'confirmed',
      desc: '',
      args: [],
    );
  }

  /// `please fix your internet connection and try again!`
  String get connection {
    return Intl.message(
      'please fix your internet connection and try again!',
      name: 'connection',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Contact us for support`
  String get contact_us_for_support {
    return Intl.message(
      'Contact us for support',
      name: 'contact_us_for_support',
      desc: '',
      args: [],
    );
  }

  /// `Continue with`
  String get continue_with {
    return Intl.message(
      'Continue with',
      name: 'continue_with',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copied_to_clipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copied_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy to clipboard`
  String get copy_to_clipboard {
    return Intl.message(
      'Copy to clipboard',
      name: 'copy_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Create a new wallet`
  String get create_new_wallet {
    return Intl.message(
      'Create a new wallet',
      name: 'create_new_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Create your passcode`
  String get create_passcode {
    return Intl.message(
      'Create your passcode',
      name: 'create_passcode',
      desc: '',
      args: [],
    );
  }

  /// `Create wallet`
  String get create__wallet {
    return Intl.message(
      'Create wallet',
      name: 'create__wallet',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get credit_card {
    return Intl.message(
      'Credit Card',
      name: 'credit_card',
      desc: '',
      args: [],
    );
  }

  /// `If you have ETH, BNB or FUSE on Binance Smart Chain (BSC) please use the URL below with your Metamask account on a desktop browser to deposit to Fuse:`
  String get crypto_deposit_bsc {
    return Intl.message(
      'If you have ETH, BNB or FUSE on Binance Smart Chain (BSC) please use the URL below with your Metamask account on a desktop browser to deposit to Fuse:',
      name: 'crypto_deposit_bsc',
      desc: '',
      args: [],
    );
  }

  /// `If you have USDC on Ethereum please use the URL below with your Metamask account on a desktop browser to deposit to Fuse:`
  String get crypto_deposit_eth {
    return Intl.message(
      'If you have USDC on Ethereum please use the URL below with your Metamask account on a desktop browser to deposit to Fuse:',
      name: 'crypto_deposit_eth',
      desc: '',
      args: [],
    );
  }

  /// `Please note that this is a personal link that will bridge the funds directly to your account.`
  String get crypto_deposit_risk {
    return Intl.message(
      'Please note that this is a personal link that will bridge the funds directly to your account.',
      name: 'crypto_deposit_risk',
      desc: '',
      args: [],
    );
  }

  /// `Please use it responsibly and at your own risk.`
  String get crypto_deposit_risk_2 {
    return Intl.message(
      'Please use it responsibly and at your own risk.',
      name: 'crypto_deposit_risk_2',
      desc: '',
      args: [],
    );
  }

  /// `Current community`
  String get current_community {
    return Intl.message(
      'Current community',
      name: 'current_community',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get date_and_time {
    return Intl.message(
      'Date & Time',
      name: 'date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `deposit`
  String get deposit {
    return Intl.message(
      'deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `deposit failed`
  String get deposit_failed {
    return Intl.message(
      'deposit failed',
      name: 'deposit_failed',
      desc: '',
      args: [],
    );
  }

  /// `Deposit from BSC`
  String get deposit_from_BSC {
    return Intl.message(
      'Deposit from BSC',
      name: 'deposit_from_BSC',
      desc: '',
      args: [],
    );
  }

  /// `Deposit from Ethereum`
  String get deposit_from_ethereum {
    return Intl.message(
      'Deposit from Ethereum',
      name: 'deposit_from_ethereum',
      desc: '',
      args: [],
    );
  }

  /// `Deposit from Ethereum or BSC`
  String get deposit_from_ethereum_or_BSC {
    return Intl.message(
      'Deposit from Ethereum or BSC',
      name: 'deposit_from_ethereum_or_BSC',
      desc: '',
      args: [],
    );
  }

  /// `Deposit your`
  String get deposit_your {
    return Intl.message(
      'Deposit your',
      name: 'deposit_your',
      desc: '',
      args: [],
    );
  }

  /// `Deposit your first Dollars`
  String get deposit_your_first_dollars {
    return Intl.message(
      'Deposit your first Dollars',
      name: 'deposit_your_first_dollars',
      desc: '',
      args: [],
    );
  }

  /// `Didn't get the message? - `
  String get didnt_get_message {
    return Intl.message(
      'Didn\'t get the message? - ',
      name: 'didnt_get_message',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry:`
  String get dont_worry {
    return Intl.message(
      'Don\'t worry:',
      name: 'dont_worry',
      desc: '',
      args: [],
    );
  }

  /// `Earn`
  String get earn {
    return Intl.message(
      'Earn',
      name: 'earn',
      desc: '',
      args: [],
    );
  }

  /// `Holders of Fuse Dollars are eligible to earn a yield of 5% a year just by holding those Dollars in your balance.`
  String get earn_description {
    return Intl.message(
      'Holders of Fuse Dollars are eligible to earn a yield of 5% a year just by holding those Dollars in your balance.',
      name: 'earn_description',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Enable Contacts Access`
  String get enable_contacts_access {
    return Intl.message(
      'Enable Contacts Access',
      name: 'enable_contacts_access',
      desc: '',
      args: [],
    );
  }

  /// `Enable contact sync to send\n money to your phone contacts`
  String get enable_contacts_text {
    return Intl.message(
      'Enable contact sync to send\n money to your phone contacts',
      name: 'enable_contacts_text',
      desc: '',
      args: [],
    );
  }

  /// `Your contacts will not be saved on our \n server and this action will not send  \n them any messages`
  String get enable_text {
    return Intl.message(
      'Your contacts will not be saved on our \n server and this action will not send  \n them any messages',
      name: 'enable_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter Community Address`
  String get enter_community_address {
    return Intl.message(
      'Enter Community Address',
      name: 'enter_community_address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number so we can setup your account`
  String get enter_phone_number {
    return Intl.message(
      'Please enter your phone number so we can setup your account',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Pincode:`
  String get enter_pincode {
    return Intl.message(
      'Enter your Pincode:',
      name: 'enter_pincode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter 6-digit code from\n that message here`
  String get enter_verification_code {
    return Intl.message(
      'Please enter 6-digit code from\n that message here',
      name: 'enter_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Face ID`
  String get face_id {
    return Intl.message(
      'Face ID',
      name: 'face_id',
      desc: '',
      args: [],
    );
  }

  /// `FAILED`
  String get failed {
    return Intl.message(
      'FAILED',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Fee amount:`
  String get fee_amount {
    return Intl.message(
      'Fee amount:',
      name: 'fee_amount',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get feed {
    return Intl.message(
      'Feed',
      name: 'feed',
      desc: '',
      args: [],
    );
  }

  /// `first Dollars`
  String get first_dollars {
    return Intl.message(
      'first Dollars',
      name: 'first_dollars',
      desc: '',
      args: [],
    );
  }

  /// `Flash off`
  String get flash_off {
    return Intl.message(
      'Flash off',
      name: 'flash_off',
      desc: '',
      args: [],
    );
  }

  /// `Flash on`
  String get flash_on {
    return Intl.message(
      'Flash on',
      name: 'flash_on',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on Twitter.`
  String get follow_us_on_twitter {
    return Intl.message(
      'Follow us on Twitter.',
      name: 'follow_us_on_twitter',
      desc: '',
      args: [],
    );
  }

  /// `For more information: `
  String get for_more_info {
    return Intl.message(
      'For more information: ',
      name: 'for_more_info',
      desc: '',
      args: [],
    );
  }

  /// `for`
  String get for_text {
    return Intl.message(
      'for',
      name: 'for_text',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `friend`
  String get friend {
    return Intl.message(
      'friend',
      name: 'friend',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `FuseDollar is the first Fuse-native stablecoin. In the future, we are planning to add stablecoins pegged to other major currencies to bolster the adoption and reduce friction for users around the world. Stay tuned!`
  String get fusd_stablecoins_explain {
    return Intl.message(
      'FuseDollar is the first Fuse-native stablecoin. In the future, we are planning to add stablecoins pegged to other major currencies to bolster the adoption and reduce friction for users around the world. Stay tuned!',
      name: 'fusd_stablecoins_explain',
      desc: '',
      args: [],
    );
  }

  /// `Fuse Dollar`
  String get fuse_dollar {
    return Intl.message(
      'Fuse Dollar',
      name: 'fuse_dollar',
      desc: '',
      args: [],
    );
  }

  /// `FuseDollar (fUSD) is a US Dollar-pegged stablecoin that is minted on the Fuse Network blockchain. It was created to make cryptocurrencies and DeFi simple for everyday people. `
  String get fuse_dollar_explain {
    return Intl.message(
      'FuseDollar (fUSD) is a US Dollar-pegged stablecoin that is minted on the Fuse Network blockchain. It was created to make cryptocurrencies and DeFi simple for everyday people. ',
      name: 'fuse_dollar_explain',
      desc: '',
      args: [],
    );
  }

  /// `You can switch to a new community by entering your Asset ID (available from the Fuse Studio) or scanning a QR code`
  String get fuse_studio {
    return Intl.message(
      'You can switch to a new community by entering your Asset ID (available from the Fuse Studio) or scanning a QR code',
      name: 'fuse_studio',
      desc: '',
      args: [],
    );
  }

  /// `Future stablecoins`
  String get future_stablecoins {
    return Intl.message(
      'Future stablecoins',
      name: 'future_stablecoins',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Fuse wallet`
  String get generated_wallet {
    return Intl.message(
      'Welcome to Fuse wallet',
      name: 'generated_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Generate wallet failed`
  String get generate_wallet_failed {
    return Intl.message(
      'Generate wallet failed',
      name: 'generate_wallet_failed',
      desc: '',
      args: [],
    );
  }

  /// `Generating fuse wallet`
  String get generating_wallet {
    return Intl.message(
      'Generating fuse wallet',
      name: 'generating_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hi {
    return Intl.message(
      'Hello',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `How much?`
  String get how_much {
    return Intl.message(
      'How much?',
      name: 'how_much',
      desc: '',
      args: [],
    );
  }

  /// `How you can use FuseDollar?`
  String get how_to_use_fusd {
    return Intl.message(
      'How you can use FuseDollar?',
      name: 'how_to_use_fusd',
      desc: '',
      args: [],
    );
  }

  /// `Important!`
  String get important {
    return Intl.message(
      'Important!',
      name: 'important',
      desc: '',
      args: [],
    );
  }

  /// `Initializing your wallet on Fuse`
  String get initializing_wallet {
    return Intl.message(
      'Initializing your wallet on Fuse',
      name: 'initializing_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient funds`
  String get insufficient_fund {
    return Intl.message(
      'Insufficient funds',
      name: 'insufficient_fund',
      desc: '',
      args: [],
    );
  }

  /// `Pay and get paid or send money to friends without fees or friction`
  String get intro_text_one {
    return Intl.message(
      'Pay and get paid or send money to friends without fees or friction',
      name: 'intro_text_one',
      desc: '',
      args: [],
    );
  }

  /// `Create a secure and smart token account to access decentralized finance`
  String get intro_text_three {
    return Intl.message(
      'Create a secure and smart token account to access decentralized finance',
      name: 'intro_text_three',
      desc: '',
      args: [],
    );
  }

  /// `Deposit \b$ and swap to other currencies with little to no fees`
  String get intro_text_two {
    return Intl.message(
      'Deposit \b\$ and swap to other currencies with little to no fees',
      name: 'intro_text_two',
      desc: '',
      args: [],
    );
  }

  /// `Invalid number`
  String get invalid_number {
    return Intl.message(
      'Invalid number',
      name: 'invalid_number',
      desc: '',
      args: [],
    );
  }

  /// `Invalid pincode`
  String get invalid_pincode {
    return Intl.message(
      'Invalid pincode',
      name: 'invalid_pincode',
      desc: '',
      args: [],
    );
  }

  /// `Invalid QA Code`
  String get invalid_qa_code {
    return Intl.message(
      'Invalid QA Code',
      name: 'invalid_qa_code',
      desc: '',
      args: [],
    );
  }

  /// `Invite a friend`
  String get invite_friend {
    return Intl.message(
      'Invite a friend',
      name: 'invite_friend',
      desc: '',
      args: [],
    );
  }

  /// `Hey, your friend shared with you the fuse.cash wallet: `
  String get invite_friend_text {
    return Intl.message(
      'Hey, your friend shared with you the fuse.cash wallet: ',
      name: 'invite_friend_text',
      desc: '',
      args: [],
    );
  }

  /// `Sending money to {name} will automatically invite them to Fuse and let them redeem the funds you sent`
  String invite_text(Object name) {
    return Intl.message(
      'Sending money to $name will automatically invite them to Fuse and let them redeem the funds you sent',
      name: 'invite_text',
      desc: '',
      args: [name],
    );
  }

  /// `You got a join bonus!`
  String get join_bonus {
    return Intl.message(
      'You got a join bonus!',
      name: 'join_bonus',
      desc: '',
      args: [],
    );
  }

  /// `Joined`
  String get joined {
    return Intl.message(
      'Joined',
      name: 'joined',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get joined_community {
    return Intl.message(
      '',
      name: 'joined_community',
      desc: '',
      args: [],
    );
  }

  /// `Joining`
  String get joining {
    return Intl.message(
      'Joining',
      name: 'joining',
      desc: '',
      args: [],
    );
  }

  /// `Joining Community`
  String get joining_community {
    return Intl.message(
      'Joining Community',
      name: 'joining_community',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Learn about Fuse Dollar`
  String get learn_about_fuse_dollar {
    return Intl.message(
      'Learn about Fuse Dollar',
      name: 'learn_about_fuse_dollar',
      desc: '',
      args: [],
    );
  }

  /// `Learn more`
  String get learn_more {
    return Intl.message(
      'Learn more',
      name: 'learn_more',
      desc: '',
      args: [],
    );
  }

  /// `Legal`
  String get legal {
    return Intl.message(
      'Legal',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `That's it! Let's start`
  String get lets_start {
    return Intl.message(
      'That\'s it! Let\'s start',
      name: 'lets_start',
      desc: '',
      args: [],
    );
  }

  /// `(for deposits above 200$)`
  String get limit_discalimer {
    return Intl.message(
      '(for deposits above 200\$)',
      name: 'limit_discalimer',
      desc: '',
      args: [],
    );
  }

  /// `Limited time offer! 50 $ deposit bonus 💸`
  String get limit_offer {
    return Intl.message(
      'Limited time offer! 50 \$ deposit bonus 💸',
      name: 'limit_offer',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Move to`
  String get move_to {
    return Intl.message(
      'Move to',
      name: 'move_to',
      desc: '',
      args: [],
    );
  }

  /// `My communities`
  String get my_communities {
    return Intl.message(
      'My communities',
      name: 'my_communities',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Network`
  String get network {
    return Intl.message(
      'Network',
      name: 'network',
      desc: '',
      args: [],
    );
  }

  /// `Network Fee`
  String get network_fee {
    return Intl.message(
      'Network Fee',
      name: 'network_fee',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_button {
    return Intl.message(
      'Next',
      name: 'next_button',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No activity`
  String get no_activity {
    return Intl.message(
      'No activity',
      name: 'no_activity',
      desc: '',
      args: [],
    );
  }

  /// `No businesses found`
  String get no_businesses {
    return Intl.message(
      'No businesses found',
      name: 'no_businesses',
      desc: '',
      args: [],
    );
  }

  /// `No funds available`
  String get no_funds_available {
    return Intl.message(
      'No funds available',
      name: 'no_funds_available',
      desc: '',
      args: [],
    );
  }

  /// `You don't have tokens to swap yet`
  String get no_swap_option {
    return Intl.message(
      'You don\'t have tokens to swap yet',
      name: 'no_swap_option',
      desc: '',
      args: [],
    );
  }

  /// `Not enough balance in your account`
  String get not_enough_balance {
    return Intl.message(
      'Not enough balance in your account',
      name: 'not_enough_balance',
      desc: '',
      args: [],
    );
  }

  /// `it's seems you are offline`
  String get offline {
    return Intl.message(
      'it\'s seems you are offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `OK Thanks`
  String get ok_thanks {
    return Intl.message(
      'OK Thanks',
      name: 'ok_thanks',
      desc: '',
      args: [],
    );
  }

  /// `Oops`
  String get oops {
    return Intl.message(
      'Oops',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `PAY`
  String get pay {
    return Intl.message(
      'PAY',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Pay with`
  String get pay_with {
    return Intl.message(
      'Pay with',
      name: 'pay_with',
      desc: '',
      args: [],
    );
  }

  /// `FuseDollar is fully collateralized by the USD Coin (USDC) on Fuse. Issued by circle.com, USDC is a fully dollar-backed, regulated stablecoin that is widely recognized in the cryptocurrency space.`
  String get peg_explain {
    return Intl.message(
      'FuseDollar is fully collateralized by the USD Coin (USDC) on Fuse. Issued by circle.com, USDC is a fully dollar-backed, regulated stablecoin that is widely recognized in the cryptocurrency space.',
      name: 'peg_explain',
      desc: '',
      args: [],
    );
  }

  /// `PENDING`
  String get pending {
    return Intl.message(
      'PENDING',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `One of the 12 words is invalid`
  String get phrase_invaild {
    return Intl.message(
      'One of the 12 words is invalid',
      name: 'phrase_invaild',
      desc: '',
      args: [],
    );
  }

  /// `Pick your display name`
  String get pickup_display_name {
    return Intl.message(
      'Pick your display name',
      name: 'pickup_display_name',
      desc: '',
      args: [],
    );
  }

  /// `This name will be shown to contacts that send you money to identify your account`
  String get pickup_display_name_text {
    return Intl.message(
      'This name will be shown to contacts that send you money to identify your account',
      name: 'pickup_display_name_text',
      desc: '',
      args: [],
    );
  }

  /// `Pincode`
  String get pincode {
    return Intl.message(
      'Pincode',
      name: 'pincode',
      desc: '',
      args: [],
    );
  }

  /// `Pin code doesn't match`
  String get pincode_dont_match {
    return Intl.message(
      'Pin code doesn\'t match',
      name: 'pincode_dont_match',
      desc: '',
      args: [],
    );
  }

  /// `Please choose how you prefer to unlock the wallet:`
  String get please_choose_security {
    return Intl.message(
      'Please choose how you prefer to unlock the wallet:',
      name: 'please_choose_security',
      desc: '',
      args: [],
    );
  }

  /// `Please use`
  String get please_use {
    return Intl.message(
      'Please use',
      name: 'please_use',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Fuse.io/privacy`
  String get privacy {
    return Intl.message(
      'Fuse.io/privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Protect your wallet`
  String get protect_wallet {
    return Intl.message(
      'Protect your wallet',
      name: 'protect_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Rate us in the store`
  String get rate_us {
    return Intl.message(
      'Rate us in the store',
      name: 'rate_us',
      desc: '',
      args: [],
    );
  }

  /// `Receive`
  String get receive {
    return Intl.message(
      'Receive',
      name: 'receive',
      desc: '',
      args: [],
    );
  }

  /// `Received from Ethereum`
  String get received_from_ethereum {
    return Intl.message(
      'Received from Ethereum',
      name: 'received_from_ethereum',
      desc: '',
      args: [],
    );
  }

  /// `Receive from`
  String get receive_from {
    return Intl.message(
      'Receive from',
      name: 'receive_from',
      desc: '',
      args: [],
    );
  }

  /// `Receiving`
  String get receiving {
    return Intl.message(
      'Receiving',
      name: 'receiving',
      desc: '',
      args: [],
    );
  }

  /// `Recent`
  String get recent {
    return Intl.message(
      'Recent',
      name: 'recent',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resend_code {
    return Intl.message(
      'Resend code',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Creating a new account will reset your existing account - are you sure you want to continue?`
  String get reset_account {
    return Intl.message(
      'Creating a new account will reset your existing account - are you sure you want to continue?',
      name: 'reset_account',
      desc: '',
      args: [],
    );
  }

  /// `Restore backup`
  String get restore_backup {
    return Intl.message(
      'Restore backup',
      name: 'restore_backup',
      desc: '',
      args: [],
    );
  }

  /// `Restore from backup`
  String get restore_from_backup {
    return Intl.message(
      'Restore from backup',
      name: 'restore_from_backup',
      desc: '',
      args: [],
    );
  }

  /// `This is a 12 word phrase you were given when you created your previous wallet`
  String get restore_words {
    return Intl.message(
      'This is a 12 word phrase you were given when you created your previous wallet',
      name: 'restore_words',
      desc: '',
      args: [],
    );
  }

  /// `Re-type your passcode`
  String get re_type_passcode {
    return Intl.message(
      'Re-type your passcode',
      name: 're_type_passcode',
      desc: '',
      args: [],
    );
  }

  /// `Review swap`
  String get review_swap {
    return Intl.message(
      'Review swap',
      name: 'review_swap',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get review_trade {
    return Intl.message(
      '',
      name: 'review_trade',
      desc: '',
      args: [],
    );
  }

  /// `Review transfer`
  String get review_transfer {
    return Intl.message(
      'Review transfer',
      name: 'review_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save_button {
    return Intl.message(
      'Save',
      name: 'save_button',
      desc: '',
      args: [],
    );
  }

  /// `Scan the QR code to receive money`
  String get scan_to_receive {
    return Intl.message(
      'Scan the QR code to receive money',
      name: 'scan_to_receive',
      desc: '',
      args: [],
    );
  }

  /// `Name or Address`
  String get search {
    return Intl.message(
      'Name or Address',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send_button {
    return Intl.message(
      'Send',
      name: 'send_button',
      desc: '',
      args: [],
    );
  }

  /// `Sent to your Ethereum wallet`
  String get sending_to_ethereum {
    return Intl.message(
      'Sent to your Ethereum wallet',
      name: 'sending_to_ethereum',
      desc: '',
      args: [],
    );
  }

  /// `Send to`
  String get send_to {
    return Intl.message(
      'Send to',
      name: 'send_to',
      desc: '',
      args: [],
    );
  }

  /// `Send to an address`
  String get send_to_address {
    return Intl.message(
      'Send to an address',
      name: 'send_to_address',
      desc: '',
      args: [],
    );
  }

  /// `Send to`
  String get sent_to {
    return Intl.message(
      'Send to',
      name: 'sent_to',
      desc: '',
      args: [],
    );
  }

  /// `Sent to Ethereum`
  String get sent_to_ethereum {
    return Intl.message(
      'Sent to Ethereum',
      name: 'sent_to_ethereum',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share_button {
    return Intl.message(
      'Share',
      name: 'share_button',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Simple`
  String get simple {
    return Intl.message(
      'Simple',
      name: 'simple',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip_button {
    return Intl.message(
      'Skip',
      name: 'skip_button',
      desc: '',
      args: [],
    );
  }

  /// `Slippage`
  String get slippage {
    return Intl.message(
      'Slippage',
      name: 'slippage',
      desc: '',
      args: [],
    );
  }

  /// `Smart`
  String get smart {
    return Intl.message(
      'Smart',
      name: 'smart',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR to switch`
  String get sqan_qr_code {
    return Intl.message(
      'Scan QR to switch',
      name: 'sqan_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `The fuse wallet stores private information locally on the device. Only the phone number is used to be able to verify your identity and reduce friction when sending money to phone contacts.`
  String get stores_private {
    return Intl.message(
      'The fuse wallet stores private information locally on the device. Only the phone number is used to be able to verify your identity and reduce friction when sending money to phone contacts.',
      name: 'stores_private',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Swap`
  String get swap {
    return Intl.message(
      'Swap',
      name: 'swap',
      desc: '',
      args: [],
    );
  }

  /// `Swapped`
  String get swapped {
    return Intl.message(
      'Swapped',
      name: 'swapped',
      desc: '',
      args: [],
    );
  }

  /// `Swapping`
  String get swapping {
    return Intl.message(
      'Swapping',
      name: 'swapping',
      desc: '',
      args: [],
    );
  }

  /// `Switch community`
  String get switch_community {
    return Intl.message(
      'Switch community',
      name: 'switch_community',
      desc: '',
      args: [],
    );
  }

  /// `Sync contacts`
  String get sync_contacts {
    return Intl.message(
      'Sync contacts',
      name: 'sync_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Sync your contact`
  String get sync_your_contacts {
    return Intl.message(
      'Sync your contact',
      name: 'sync_your_contacts',
      desc: '',
      args: [],
    );
  }

  /// `(up to 10 seconds)`
  String get ten_seconds {
    return Intl.message(
      '(up to 10 seconds)',
      name: 'ten_seconds',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Token`
  String get token {
    return Intl.message(
      'Token',
      name: 'token',
      desc: '',
      args: [],
    );
  }

  /// `To protect your money and wallet go now to the settings and back up your wallet in few easy steps`
  String get to_protect {
    return Intl.message(
      'To protect your money and wallet go now to the settings and back up your wallet in few easy steps',
      name: 'to_protect',
      desc: '',
      args: [],
    );
  }

  /// `Top up`
  String get top_up {
    return Intl.message(
      'Top up',
      name: 'top_up',
      desc: '',
      args: [],
    );
  }

  /// `Top up your account`
  String get top_up_your_account {
    return Intl.message(
      'Top up your account',
      name: 'top_up_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Total amount:`
  String get total_amount {
    return Intl.message(
      'Total amount:',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Touch ID`
  String get touch_id {
    return Intl.message(
      'Touch ID',
      name: 'touch_id',
      desc: '',
      args: [],
    );
  }

  /// `to unlock!`
  String get to_unlock {
    return Intl.message(
      'to unlock!',
      name: 'to_unlock',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get trade {
    return Intl.message(
      '',
      name: 'trade',
      desc: '',
      args: [],
    );
  }

  /// `Transaction details`
  String get transaction_details {
    return Intl.message(
      'Transaction details',
      name: 'transaction_details',
      desc: '',
      args: [],
    );
  }

  /// `Transaction failed`
  String get transaction_failed {
    return Intl.message(
      'Transaction failed',
      name: 'transaction_failed',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Txn`
  String get txn {
    return Intl.message(
      'Txn',
      name: 'txn',
      desc: '',
      args: [],
    );
  }

  /// `(up to 10 seconds)`
  String get up_to_10 {
    return Intl.message(
      '(up to 10 seconds)',
      name: 'up_to_10',
      desc: '',
      args: [],
    );
  }

  /// `Useful`
  String get useful {
    return Intl.message(
      'Useful',
      name: 'useful',
      desc: '',
      args: [],
    );
  }

  /// `FuseDollars can be freely moved between accounts on FuseCash, as well as to Fuse accounts outside Fuse Cash. They can also be swapped for other cryptocurrencies straight from Fuse Cash using the FuseSwap DEX, and will soon be usable for earning passive income.`
  String get use_fusd_explain {
    return Intl.message(
      'FuseDollars can be freely moved between accounts on FuseCash, as well as to Fuse accounts outside Fuse Cash. They can also be swapped for other cryptocurrencies straight from Fuse Cash using the FuseSwap DEX, and will soon be usable for earning passive income.',
      name: 'use_fusd_explain',
      desc: '',
      args: [],
    );
  }

  /// `Use max`
  String get use_max {
    return Intl.message(
      'Use max',
      name: 'use_max',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get version {
    return Intl.message(
      'App version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Visit fuse.io to learn more about Fuse and how things work behind the scenes.`
  String get visit_fuseio {
    return Intl.message(
      'Visit fuse.io to learn more about Fuse and how things work behind the scenes.',
      name: 'visit_fuseio',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for your deposit to arrive`
  String get waiting_for_deposit {
    return Intl.message(
      'Waiting for your deposit to arrive',
      name: 'waiting_for_deposit',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Wallet address`
  String get wallet_address {
    return Intl.message(
      'Wallet address',
      name: 'wallet_address',
      desc: '',
      args: [],
    );
  }

  /// `Your fuse wallet is protected!`
  String get wallet_protected {
    return Intl.message(
      'Your fuse wallet is protected!',
      name: 'wallet_protected',
      desc: '',
      args: [],
    );
  }

  /// `Great, you’ve backed up your secret phrase. Remember to keep your secret phrase in a safe and secure place and never let anyone know what it is.`
  String get wallet_protected_text {
    return Intl.message(
      'Great, you’ve backed up your secret phrase. Remember to keep your secret phrase in a safe and secure place and never let anyone know what it is.',
      name: 'wallet_protected_text',
      desc: '',
      args: [],
    );
  }

  /// `We just sent a message to \n`
  String get we_just_sent {
    return Intl.message(
      'We just sent a message to \n',
      name: 'we_just_sent',
      desc: '',
      args: [],
    );
  }

  /// `We notice you haven’t backup your wallet yet.`
  String get we_notice {
    return Intl.message(
      'We notice you haven’t backup your wallet yet.',
      name: 'we_notice',
      desc: '',
      args: [],
    );
  }

  /// `What is FuseDollar?`
  String get what_is_fuse_dollar {
    return Intl.message(
      'What is FuseDollar?',
      name: 'what_is_fuse_dollar',
      desc: '',
      args: [],
    );
  }

  /// `How the FuseDollar peg is maintained?`
  String get what_is_peg {
    return Intl.message(
      'How the FuseDollar peg is maintained?',
      name: 'what_is_peg',
      desc: '',
      args: [],
    );
  }

  /// `Why do we need this?`
  String get why_do_we_need_this {
    return Intl.message(
      'Why do we need this?',
      name: 'why_do_we_need_this',
      desc: '',
      args: [],
    );
  }

  /// `Fuse will never share this information with 3rd party.`
  String get will_never_share {
    return Intl.message(
      'Fuse will never share this information with 3rd party.',
      name: 'will_never_share',
      desc: '',
      args: [],
    );
  }

  /// `Wire Transfer`
  String get wire_transfer {
    return Intl.message(
      'Wire Transfer',
      name: 'wire_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Word `
  String get word {
    return Intl.message(
      'Word ',
      name: 'word',
      desc: '',
      args: [],
    );
  }

  /// `The word does not match`
  String get word_not_match {
    return Intl.message(
      'The word does not match',
      name: 'word_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Write down your 12 words...`
  String get write_down_your_words {
    return Intl.message(
      'Write down your 12 words...',
      name: 'write_down_your_words',
      desc: '',
      args: [],
    );
  }

  /// `Please write down words \n`
  String get write_word {
    return Intl.message(
      'Please write down words \n',
      name: 'write_word',
      desc: '',
      args: [],
    );
  }

  /// `Write down the words in order and keep safe. You won’t be able to recover your account without it.`
  String get write_words {
    return Intl.message(
      'Write down the words in order and keep safe. You won’t be able to recover your account without it.',
      name: 'write_words',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `You got a`
  String get you_got_a {
    return Intl.message(
      'You got a',
      name: 'you_got_a',
      desc: '',
      args: [],
    );
  }

  /// `Your balance`
  String get your_balance {
    return Intl.message(
      'Your balance',
      name: 'your_balance',
      desc: '',
      args: [],
    );
  }

  /// `You have no balance`
  String get your_balance_is_empty {
    return Intl.message(
      'You have no balance',
      name: 'your_balance_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Your wallet is empty!`
  String get your_wallet_is_empty {
    return Intl.message(
      'Your wallet is empty!',
      name: 'your_wallet_is_empty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'PH'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'MX'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
      Locale.fromSubtags(languageCode: 'id', countryCode: 'ID'),
      Locale.fromSubtags(languageCode: 'it', countryCode: 'IT'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'nl', countryCode: 'NL'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
      Locale.fromSubtags(languageCode: 'sr', countryCode: 'RS'),
      Locale.fromSubtags(languageCode: 'th', countryCode: 'TH'),
      Locale.fromSubtags(languageCode: 'tl'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I10n> load(Locale locale) => I10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
