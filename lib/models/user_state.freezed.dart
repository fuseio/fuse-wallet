// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return _UserState.fromJson(json);
}

/// @nodoc
mixin _$UserState {
  @JsonKey(ignore: true)
  String? get wcURI => throw _privateConstructorUsedError;
  String? get contractVersion => throw _privateConstructorUsedError;
  WalletModules? get walletModules => throw _privateConstructorUsedError;
  DateTime? get installedAt => throw _privateConstructorUsedError;
  bool? get isContactsSynced => throw _privateConstructorUsedError;
  bool get isLoggedOut => throw _privateConstructorUsedError;
  bool get backup => throw _privateConstructorUsedError;
  bool get scrollToTop => throw _privateConstructorUsedError;
  String get walletAddress => throw _privateConstructorUsedError;
  List<String> get networks => throw _privateConstructorUsedError;
  List<String> get mnemonic => throw _privateConstructorUsedError;
  String get privateKey => throw _privateConstructorUsedError;
  String get pincode => throw _privateConstructorUsedError;
  String get accountAddress => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  bool get warnSendDialogShowed => throw _privateConstructorUsedError;
  String get isoCode => throw _privateConstructorUsedError;
  String get jwtToken => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get verificationId => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  List<String> get syncedContacts => throw _privateConstructorUsedError;
  Map<String, String> get reverseContacts => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get hasUpgrade => throw _privateConstructorUsedError;
  BiometricAuth get authType => throw _privateConstructorUsedError;
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale? get locale => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  List<Contact> get contacts => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  PhoneAuthCredential? get credentials => throw _privateConstructorUsedError;
  String? get did => throw _privateConstructorUsedError;
  String? get privateKeyForDID => throw _privateConstructorUsedError;
  String? get userInfoCredential => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? wcURI,
      String? contractVersion,
      WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      bool isLoggedOut,
      bool backup,
      bool scrollToTop,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool warnSendDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String? verificationId,
      String identifier,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      String currency,
      @JsonKey(ignore: true) bool hasUpgrade,
      BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson) Locale? locale,
      @JsonKey(ignore: true) List<Contact> contacts,
      @JsonKey(ignore: true) PhoneAuthCredential? credentials,
      String? did,
      String? privateKeyForDID,
      String? userInfoCredential});

  $WalletModulesCopyWith<$Res>? get walletModules;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res> implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  final UserState _value;
  // ignore: unused_field
  final $Res Function(UserState) _then;

  @override
  $Res call({
    Object? wcURI = freezed,
    Object? contractVersion = freezed,
    Object? walletModules = freezed,
    Object? installedAt = freezed,
    Object? isContactsSynced = freezed,
    Object? isLoggedOut = freezed,
    Object? backup = freezed,
    Object? scrollToTop = freezed,
    Object? walletAddress = freezed,
    Object? networks = freezed,
    Object? mnemonic = freezed,
    Object? privateKey = freezed,
    Object? pincode = freezed,
    Object? accountAddress = freezed,
    Object? countryCode = freezed,
    Object? phoneNumber = freezed,
    Object? warnSendDialogShowed = freezed,
    Object? isoCode = freezed,
    Object? jwtToken = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? email = freezed,
    Object? verificationId = freezed,
    Object? identifier = freezed,
    Object? syncedContacts = freezed,
    Object? reverseContacts = freezed,
    Object? currency = freezed,
    Object? hasUpgrade = freezed,
    Object? authType = freezed,
    Object? locale = freezed,
    Object? contacts = freezed,
    Object? credentials = freezed,
    Object? did = freezed,
    Object? privateKeyForDID = freezed,
    Object? userInfoCredential = freezed,
  }) {
    return _then(_value.copyWith(
      wcURI: wcURI == freezed
          ? _value.wcURI
          : wcURI // ignore: cast_nullable_to_non_nullable
              as String?,
      contractVersion: contractVersion == freezed
          ? _value.contractVersion
          : contractVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      walletModules: walletModules == freezed
          ? _value.walletModules
          : walletModules // ignore: cast_nullable_to_non_nullable
              as WalletModules?,
      installedAt: installedAt == freezed
          ? _value.installedAt
          : installedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isContactsSynced: isContactsSynced == freezed
          ? _value.isContactsSynced
          : isContactsSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoggedOut: isLoggedOut == freezed
          ? _value.isLoggedOut
          : isLoggedOut // ignore: cast_nullable_to_non_nullable
              as bool,
      backup: backup == freezed
          ? _value.backup
          : backup // ignore: cast_nullable_to_non_nullable
              as bool,
      scrollToTop: scrollToTop == freezed
          ? _value.scrollToTop
          : scrollToTop // ignore: cast_nullable_to_non_nullable
              as bool,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      networks: networks == freezed
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mnemonic: mnemonic == freezed
          ? _value.mnemonic
          : mnemonic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      privateKey: privateKey == freezed
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
      pincode: pincode == freezed
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String,
      accountAddress: accountAddress == freezed
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      warnSendDialogShowed: warnSendDialogShowed == freezed
          ? _value.warnSendDialogShowed
          : warnSendDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isoCode: isoCode == freezed
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
      jwtToken: jwtToken == freezed
          ? _value.jwtToken
          : jwtToken // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: verificationId == freezed
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      syncedContacts: syncedContacts == freezed
          ? _value.syncedContacts
          : syncedContacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reverseContacts: reverseContacts == freezed
          ? _value.reverseContacts
          : reverseContacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      hasUpgrade: hasUpgrade == freezed
          ? _value.hasUpgrade
          : hasUpgrade // ignore: cast_nullable_to_non_nullable
              as bool,
      authType: authType == freezed
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as BiometricAuth,
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      contacts: contacts == freezed
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      credentials: credentials == freezed
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as PhoneAuthCredential?,
      did: did == freezed
          ? _value.did
          : did // ignore: cast_nullable_to_non_nullable
              as String?,
      privateKeyForDID: privateKeyForDID == freezed
          ? _value.privateKeyForDID
          : privateKeyForDID // ignore: cast_nullable_to_non_nullable
              as String?,
      userInfoCredential: userInfoCredential == freezed
          ? _value.userInfoCredential
          : userInfoCredential // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $WalletModulesCopyWith<$Res>? get walletModules {
    if (_value.walletModules == null) {
      return null;
    }

    return $WalletModulesCopyWith<$Res>(_value.walletModules!, (value) {
      return _then(_value.copyWith(walletModules: value));
    });
  }
}

/// @nodoc
abstract class _$$_UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$$_UserStateCopyWith(
          _$_UserState value, $Res Function(_$_UserState) then) =
      __$$_UserStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? wcURI,
      String? contractVersion,
      WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      bool isLoggedOut,
      bool backup,
      bool scrollToTop,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool warnSendDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String? verificationId,
      String identifier,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      String currency,
      @JsonKey(ignore: true) bool hasUpgrade,
      BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson) Locale? locale,
      @JsonKey(ignore: true) List<Contact> contacts,
      @JsonKey(ignore: true) PhoneAuthCredential? credentials,
      String? did,
      String? privateKeyForDID,
      String? userInfoCredential});

  @override
  $WalletModulesCopyWith<$Res>? get walletModules;
}

/// @nodoc
class __$$_UserStateCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements _$$_UserStateCopyWith<$Res> {
  __$$_UserStateCopyWithImpl(
      _$_UserState _value, $Res Function(_$_UserState) _then)
      : super(_value, (v) => _then(v as _$_UserState));

  @override
  _$_UserState get _value => super._value as _$_UserState;

  @override
  $Res call({
    Object? wcURI = freezed,
    Object? contractVersion = freezed,
    Object? walletModules = freezed,
    Object? installedAt = freezed,
    Object? isContactsSynced = freezed,
    Object? isLoggedOut = freezed,
    Object? backup = freezed,
    Object? scrollToTop = freezed,
    Object? walletAddress = freezed,
    Object? networks = freezed,
    Object? mnemonic = freezed,
    Object? privateKey = freezed,
    Object? pincode = freezed,
    Object? accountAddress = freezed,
    Object? countryCode = freezed,
    Object? phoneNumber = freezed,
    Object? warnSendDialogShowed = freezed,
    Object? isoCode = freezed,
    Object? jwtToken = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? email = freezed,
    Object? verificationId = freezed,
    Object? identifier = freezed,
    Object? syncedContacts = freezed,
    Object? reverseContacts = freezed,
    Object? currency = freezed,
    Object? hasUpgrade = freezed,
    Object? authType = freezed,
    Object? locale = freezed,
    Object? contacts = freezed,
    Object? credentials = freezed,
    Object? did = freezed,
    Object? privateKeyForDID = freezed,
    Object? userInfoCredential = freezed,
  }) {
    return _then(_$_UserState(
      wcURI: wcURI == freezed
          ? _value.wcURI
          : wcURI // ignore: cast_nullable_to_non_nullable
              as String?,
      contractVersion: contractVersion == freezed
          ? _value.contractVersion
          : contractVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      walletModules: walletModules == freezed
          ? _value.walletModules
          : walletModules // ignore: cast_nullable_to_non_nullable
              as WalletModules?,
      installedAt: installedAt == freezed
          ? _value.installedAt
          : installedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isContactsSynced: isContactsSynced == freezed
          ? _value.isContactsSynced
          : isContactsSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoggedOut: isLoggedOut == freezed
          ? _value.isLoggedOut
          : isLoggedOut // ignore: cast_nullable_to_non_nullable
              as bool,
      backup: backup == freezed
          ? _value.backup
          : backup // ignore: cast_nullable_to_non_nullable
              as bool,
      scrollToTop: scrollToTop == freezed
          ? _value.scrollToTop
          : scrollToTop // ignore: cast_nullable_to_non_nullable
              as bool,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      networks: networks == freezed
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mnemonic: mnemonic == freezed
          ? _value.mnemonic
          : mnemonic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      privateKey: privateKey == freezed
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
      pincode: pincode == freezed
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String,
      accountAddress: accountAddress == freezed
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      warnSendDialogShowed: warnSendDialogShowed == freezed
          ? _value.warnSendDialogShowed
          : warnSendDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isoCode: isoCode == freezed
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
      jwtToken: jwtToken == freezed
          ? _value.jwtToken
          : jwtToken // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: verificationId == freezed
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      syncedContacts: syncedContacts == freezed
          ? _value.syncedContacts
          : syncedContacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reverseContacts: reverseContacts == freezed
          ? _value.reverseContacts
          : reverseContacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      hasUpgrade: hasUpgrade == freezed
          ? _value.hasUpgrade
          : hasUpgrade // ignore: cast_nullable_to_non_nullable
              as bool,
      authType: authType == freezed
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as BiometricAuth,
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      contacts: contacts == freezed
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      credentials: credentials == freezed
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as PhoneAuthCredential?,
      did: did == freezed
          ? _value.did
          : did // ignore: cast_nullable_to_non_nullable
              as String?,
      privateKeyForDID: privateKeyForDID == freezed
          ? _value.privateKeyForDID
          : privateKeyForDID // ignore: cast_nullable_to_non_nullable
              as String?,
      userInfoCredential: userInfoCredential == freezed
          ? _value.userInfoCredential
          : userInfoCredential // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserState extends _UserState with DiagnosticableTreeMixin {
  _$_UserState(
      {@JsonKey(ignore: true) this.wcURI,
      this.contractVersion,
      this.walletModules,
      this.installedAt,
      this.isContactsSynced,
      this.isLoggedOut = false,
      this.backup = false,
      this.scrollToTop = false,
      this.walletAddress = '',
      this.networks = const [],
      this.mnemonic = const [],
      this.privateKey = '',
      this.pincode = '',
      this.accountAddress = '',
      this.countryCode = '',
      this.phoneNumber = '',
      this.warnSendDialogShowed = false,
      this.isoCode = '',
      this.jwtToken = '',
      this.displayName = 'Anom',
      this.avatarUrl = '',
      this.email = '',
      this.verificationId,
      this.identifier = '',
      this.syncedContacts = const [],
      this.reverseContacts = const {},
      this.currency = 'usd',
      @JsonKey(ignore: true) this.hasUpgrade = false,
      this.authType = BiometricAuth.none,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson) this.locale,
      @JsonKey(ignore: true) this.contacts = const [],
      @JsonKey(ignore: true) this.credentials,
      this.did,
      this.privateKeyForDID,
      this.userInfoCredential})
      : super._();

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$$_UserStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? wcURI;
  @override
  final String? contractVersion;
  @override
  final WalletModules? walletModules;
  @override
  final DateTime? installedAt;
  @override
  final bool? isContactsSynced;
  @override
  @JsonKey()
  final bool isLoggedOut;
  @override
  @JsonKey()
  final bool backup;
  @override
  @JsonKey()
  final bool scrollToTop;
  @override
  @JsonKey()
  final String walletAddress;
  @override
  @JsonKey()
  final List<String> networks;
  @override
  @JsonKey()
  final List<String> mnemonic;
  @override
  @JsonKey()
  final String privateKey;
  @override
  @JsonKey()
  final String pincode;
  @override
  @JsonKey()
  final String accountAddress;
  @override
  @JsonKey()
  final String countryCode;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final bool warnSendDialogShowed;
  @override
  @JsonKey()
  final String isoCode;
  @override
  @JsonKey()
  final String jwtToken;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String avatarUrl;
  @override
  @JsonKey()
  final String email;
  @override
  final String? verificationId;
  @override
  @JsonKey()
  final String identifier;
  @override
  @JsonKey()
  final List<String> syncedContacts;
  @override
  @JsonKey()
  final Map<String, String> reverseContacts;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(ignore: true)
  final bool hasUpgrade;
  @override
  @JsonKey()
  final BiometricAuth authType;
  @override
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  final Locale? locale;
  @override
  @JsonKey(ignore: true)
  final List<Contact> contacts;
  @override
  @JsonKey(ignore: true)
  final PhoneAuthCredential? credentials;
  @override
  final String? did;
  @override
  final String? privateKeyForDID;
  @override
  final String? userInfoCredential;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState(wcURI: $wcURI, contractVersion: $contractVersion, walletModules: $walletModules, installedAt: $installedAt, isContactsSynced: $isContactsSynced, isLoggedOut: $isLoggedOut, backup: $backup, scrollToTop: $scrollToTop, walletAddress: $walletAddress, networks: $networks, mnemonic: $mnemonic, privateKey: $privateKey, pincode: $pincode, accountAddress: $accountAddress, countryCode: $countryCode, phoneNumber: $phoneNumber, warnSendDialogShowed: $warnSendDialogShowed, isoCode: $isoCode, jwtToken: $jwtToken, displayName: $displayName, avatarUrl: $avatarUrl, email: $email, verificationId: $verificationId, identifier: $identifier, syncedContacts: $syncedContacts, reverseContacts: $reverseContacts, currency: $currency, hasUpgrade: $hasUpgrade, authType: $authType, locale: $locale, contacts: $contacts, credentials: $credentials, did: $did, privateKeyForDID: $privateKeyForDID, userInfoCredential: $userInfoCredential)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserState'))
      ..add(DiagnosticsProperty('wcURI', wcURI))
      ..add(DiagnosticsProperty('contractVersion', contractVersion))
      ..add(DiagnosticsProperty('walletModules', walletModules))
      ..add(DiagnosticsProperty('installedAt', installedAt))
      ..add(DiagnosticsProperty('isContactsSynced', isContactsSynced))
      ..add(DiagnosticsProperty('isLoggedOut', isLoggedOut))
      ..add(DiagnosticsProperty('backup', backup))
      ..add(DiagnosticsProperty('scrollToTop', scrollToTop))
      ..add(DiagnosticsProperty('walletAddress', walletAddress))
      ..add(DiagnosticsProperty('networks', networks))
      ..add(DiagnosticsProperty('mnemonic', mnemonic))
      ..add(DiagnosticsProperty('privateKey', privateKey))
      ..add(DiagnosticsProperty('pincode', pincode))
      ..add(DiagnosticsProperty('accountAddress', accountAddress))
      ..add(DiagnosticsProperty('countryCode', countryCode))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('warnSendDialogShowed', warnSendDialogShowed))
      ..add(DiagnosticsProperty('isoCode', isoCode))
      ..add(DiagnosticsProperty('jwtToken', jwtToken))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('verificationId', verificationId))
      ..add(DiagnosticsProperty('identifier', identifier))
      ..add(DiagnosticsProperty('syncedContacts', syncedContacts))
      ..add(DiagnosticsProperty('reverseContacts', reverseContacts))
      ..add(DiagnosticsProperty('currency', currency))
      ..add(DiagnosticsProperty('hasUpgrade', hasUpgrade))
      ..add(DiagnosticsProperty('authType', authType))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('contacts', contacts))
      ..add(DiagnosticsProperty('credentials', credentials))
      ..add(DiagnosticsProperty('did', did))
      ..add(DiagnosticsProperty('privateKeyForDID', privateKeyForDID))
      ..add(DiagnosticsProperty('userInfoCredential', userInfoCredential));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserState &&
            const DeepCollectionEquality().equals(other.wcURI, wcURI) &&
            const DeepCollectionEquality()
                .equals(other.contractVersion, contractVersion) &&
            const DeepCollectionEquality()
                .equals(other.walletModules, walletModules) &&
            const DeepCollectionEquality()
                .equals(other.installedAt, installedAt) &&
            const DeepCollectionEquality()
                .equals(other.isContactsSynced, isContactsSynced) &&
            const DeepCollectionEquality()
                .equals(other.isLoggedOut, isLoggedOut) &&
            const DeepCollectionEquality().equals(other.backup, backup) &&
            const DeepCollectionEquality()
                .equals(other.scrollToTop, scrollToTop) &&
            const DeepCollectionEquality()
                .equals(other.walletAddress, walletAddress) &&
            const DeepCollectionEquality().equals(other.networks, networks) &&
            const DeepCollectionEquality().equals(other.mnemonic, mnemonic) &&
            const DeepCollectionEquality()
                .equals(other.privateKey, privateKey) &&
            const DeepCollectionEquality().equals(other.pincode, pincode) &&
            const DeepCollectionEquality()
                .equals(other.accountAddress, accountAddress) &&
            const DeepCollectionEquality()
                .equals(other.countryCode, countryCode) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other.warnSendDialogShowed, warnSendDialogShowed) &&
            const DeepCollectionEquality().equals(other.isoCode, isoCode) &&
            const DeepCollectionEquality().equals(other.jwtToken, jwtToken) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.avatarUrl, avatarUrl) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.verificationId, verificationId) &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality()
                .equals(other.syncedContacts, syncedContacts) &&
            const DeepCollectionEquality()
                .equals(other.reverseContacts, reverseContacts) &&
            const DeepCollectionEquality().equals(other.currency, currency) &&
            const DeepCollectionEquality()
                .equals(other.hasUpgrade, hasUpgrade) &&
            const DeepCollectionEquality().equals(other.authType, authType) &&
            const DeepCollectionEquality().equals(other.locale, locale) &&
            const DeepCollectionEquality().equals(other.contacts, contacts) &&
            const DeepCollectionEquality()
                .equals(other.credentials, credentials) &&
            const DeepCollectionEquality().equals(other.did, did) &&
            const DeepCollectionEquality()
                .equals(other.privateKeyForDID, privateKeyForDID) &&
            const DeepCollectionEquality()
                .equals(other.userInfoCredential, userInfoCredential));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(wcURI),
        const DeepCollectionEquality().hash(contractVersion),
        const DeepCollectionEquality().hash(walletModules),
        const DeepCollectionEquality().hash(installedAt),
        const DeepCollectionEquality().hash(isContactsSynced),
        const DeepCollectionEquality().hash(isLoggedOut),
        const DeepCollectionEquality().hash(backup),
        const DeepCollectionEquality().hash(scrollToTop),
        const DeepCollectionEquality().hash(walletAddress),
        const DeepCollectionEquality().hash(networks),
        const DeepCollectionEquality().hash(mnemonic),
        const DeepCollectionEquality().hash(privateKey),
        const DeepCollectionEquality().hash(pincode),
        const DeepCollectionEquality().hash(accountAddress),
        const DeepCollectionEquality().hash(countryCode),
        const DeepCollectionEquality().hash(phoneNumber),
        const DeepCollectionEquality().hash(warnSendDialogShowed),
        const DeepCollectionEquality().hash(isoCode),
        const DeepCollectionEquality().hash(jwtToken),
        const DeepCollectionEquality().hash(displayName),
        const DeepCollectionEquality().hash(avatarUrl),
        const DeepCollectionEquality().hash(email),
        const DeepCollectionEquality().hash(verificationId),
        const DeepCollectionEquality().hash(identifier),
        const DeepCollectionEquality().hash(syncedContacts),
        const DeepCollectionEquality().hash(reverseContacts),
        const DeepCollectionEquality().hash(currency),
        const DeepCollectionEquality().hash(hasUpgrade),
        const DeepCollectionEquality().hash(authType),
        const DeepCollectionEquality().hash(locale),
        const DeepCollectionEquality().hash(contacts),
        const DeepCollectionEquality().hash(credentials),
        const DeepCollectionEquality().hash(did),
        const DeepCollectionEquality().hash(privateKeyForDID),
        const DeepCollectionEquality().hash(userInfoCredential)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      __$$_UserStateCopyWithImpl<_$_UserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStateToJson(
      this,
    );
  }
}

abstract class _UserState extends UserState {
  factory _UserState(
      {@JsonKey(ignore: true)
          final String? wcURI,
      final String? contractVersion,
      final WalletModules? walletModules,
      final DateTime? installedAt,
      final bool? isContactsSynced,
      final bool isLoggedOut,
      final bool backup,
      final bool scrollToTop,
      final String walletAddress,
      final List<String> networks,
      final List<String> mnemonic,
      final String privateKey,
      final String pincode,
      final String accountAddress,
      final String countryCode,
      final String phoneNumber,
      final bool warnSendDialogShowed,
      final String isoCode,
      final String jwtToken,
      final String displayName,
      final String avatarUrl,
      final String email,
      final String? verificationId,
      final String identifier,
      final List<String> syncedContacts,
      final Map<String, String> reverseContacts,
      final String currency,
      @JsonKey(ignore: true)
          final bool hasUpgrade,
      final BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          final Locale? locale,
      @JsonKey(ignore: true)
          final List<Contact> contacts,
      @JsonKey(ignore: true)
          final PhoneAuthCredential? credentials,
      final String? did,
      final String? privateKeyForDID,
      final String? userInfoCredential}) = _$_UserState;
  _UserState._() : super._();

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get wcURI;
  @override
  String? get contractVersion;
  @override
  WalletModules? get walletModules;
  @override
  DateTime? get installedAt;
  @override
  bool? get isContactsSynced;
  @override
  bool get isLoggedOut;
  @override
  bool get backup;
  @override
  bool get scrollToTop;
  @override
  String get walletAddress;
  @override
  List<String> get networks;
  @override
  List<String> get mnemonic;
  @override
  String get privateKey;
  @override
  String get pincode;
  @override
  String get accountAddress;
  @override
  String get countryCode;
  @override
  String get phoneNumber;
  @override
  bool get warnSendDialogShowed;
  @override
  String get isoCode;
  @override
  String get jwtToken;
  @override
  String get displayName;
  @override
  String get avatarUrl;
  @override
  String get email;
  @override
  String? get verificationId;
  @override
  String get identifier;
  @override
  List<String> get syncedContacts;
  @override
  Map<String, String> get reverseContacts;
  @override
  String get currency;
  @override
  @JsonKey(ignore: true)
  bool get hasUpgrade;
  @override
  BiometricAuth get authType;
  @override
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale? get locale;
  @override
  @JsonKey(ignore: true)
  List<Contact> get contacts;
  @override
  @JsonKey(ignore: true)
  PhoneAuthCredential? get credentials;
  @override
  String? get did;
  @override
  String? get privateKeyForDID;
  @override
  String? get userInfoCredential;
  @override
  @JsonKey(ignore: true)
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      throw _privateConstructorUsedError;
}
