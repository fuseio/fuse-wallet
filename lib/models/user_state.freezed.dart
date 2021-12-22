// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return _UserState.fromJson(json);
}

/// @nodoc
class _$UserStateTearOff {
  const _$UserStateTearOff();

  _UserState call(
      {WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      Map<String, dynamic> installConversionData = const {},
      bool isLoggedOut = false,
      bool backup = false,
      bool? depositBannerShowed = false,
      bool? homeBackupDialogShowed = false,
      String walletAddress = '',
      List<String> networks = const [],
      List<String> mnemonic = const [],
      String privateKey = '',
      String pincode = '',
      String accountAddress = '',
      String countryCode = '',
      String phoneNumber = '',
      bool receiveBackupDialogShowed = false,
      bool warnSendDialogShowed = false,
      String isoCode = '',
      String jwtToken = '',
      String displayName = 'Anom',
      String avatarUrl = '',
      String email = '',
      String? verificationId,
      String identifier = '',
      List<String> syncedContacts = const [],
      Map<String, String> reverseContacts = const {},
      String currency = 'usd',
      @JsonKey(ignore: true)
          bool hasUpgrade = false,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType = BiometricAuth.none,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale? locale,
      @JsonKey(ignore: true)
          List<Contact> contacts = const [],
      @JsonKey(ignore: true)
          PhoneAuthCredential? credentials}) {
    return _UserState(
      walletModules: walletModules,
      installedAt: installedAt,
      isContactsSynced: isContactsSynced,
      installConversionData: installConversionData,
      isLoggedOut: isLoggedOut,
      backup: backup,
      depositBannerShowed: depositBannerShowed,
      homeBackupDialogShowed: homeBackupDialogShowed,
      walletAddress: walletAddress,
      networks: networks,
      mnemonic: mnemonic,
      privateKey: privateKey,
      pincode: pincode,
      accountAddress: accountAddress,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      receiveBackupDialogShowed: receiveBackupDialogShowed,
      warnSendDialogShowed: warnSendDialogShowed,
      isoCode: isoCode,
      jwtToken: jwtToken,
      displayName: displayName,
      avatarUrl: avatarUrl,
      email: email,
      verificationId: verificationId,
      identifier: identifier,
      syncedContacts: syncedContacts,
      reverseContacts: reverseContacts,
      currency: currency,
      hasUpgrade: hasUpgrade,
      authType: authType,
      locale: locale,
      contacts: contacts,
      credentials: credentials,
    );
  }

  UserState fromJson(Map<String, Object?> json) {
    return UserState.fromJson(json);
  }
}

/// @nodoc
const $UserState = _$UserStateTearOff();

/// @nodoc
mixin _$UserState {
  WalletModules? get walletModules => throw _privateConstructorUsedError;
  DateTime? get installedAt => throw _privateConstructorUsedError;
  bool? get isContactsSynced => throw _privateConstructorUsedError;
  Map<String, dynamic> get installConversionData =>
      throw _privateConstructorUsedError;
  bool get isLoggedOut => throw _privateConstructorUsedError;
  bool get backup => throw _privateConstructorUsedError;
  bool? get depositBannerShowed => throw _privateConstructorUsedError;
  bool? get homeBackupDialogShowed => throw _privateConstructorUsedError;
  String get walletAddress => throw _privateConstructorUsedError;
  List<String> get networks => throw _privateConstructorUsedError;
  List<String> get mnemonic => throw _privateConstructorUsedError;
  String get privateKey => throw _privateConstructorUsedError;
  String get pincode => throw _privateConstructorUsedError;
  String get accountAddress => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  bool get receiveBackupDialogShowed => throw _privateConstructorUsedError;
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
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  BiometricAuth get authType => throw _privateConstructorUsedError;
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale? get locale => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  List<Contact> get contacts => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  PhoneAuthCredential? get credentials => throw _privateConstructorUsedError;

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
      {WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      Map<String, dynamic> installConversionData,
      bool isLoggedOut,
      bool backup,
      bool? depositBannerShowed,
      bool? homeBackupDialogShowed,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool receiveBackupDialogShowed,
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
      @JsonKey(ignore: true)
          bool hasUpgrade,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale? locale,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      @JsonKey(ignore: true)
          PhoneAuthCredential? credentials});

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
    Object? walletModules = freezed,
    Object? installedAt = freezed,
    Object? isContactsSynced = freezed,
    Object? installConversionData = freezed,
    Object? isLoggedOut = freezed,
    Object? backup = freezed,
    Object? depositBannerShowed = freezed,
    Object? homeBackupDialogShowed = freezed,
    Object? walletAddress = freezed,
    Object? networks = freezed,
    Object? mnemonic = freezed,
    Object? privateKey = freezed,
    Object? pincode = freezed,
    Object? accountAddress = freezed,
    Object? countryCode = freezed,
    Object? phoneNumber = freezed,
    Object? receiveBackupDialogShowed = freezed,
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
  }) {
    return _then(_value.copyWith(
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
      installConversionData: installConversionData == freezed
          ? _value.installConversionData
          : installConversionData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isLoggedOut: isLoggedOut == freezed
          ? _value.isLoggedOut
          : isLoggedOut // ignore: cast_nullable_to_non_nullable
              as bool,
      backup: backup == freezed
          ? _value.backup
          : backup // ignore: cast_nullable_to_non_nullable
              as bool,
      depositBannerShowed: depositBannerShowed == freezed
          ? _value.depositBannerShowed
          : depositBannerShowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      homeBackupDialogShowed: homeBackupDialogShowed == freezed
          ? _value.homeBackupDialogShowed
          : homeBackupDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      receiveBackupDialogShowed: receiveBackupDialogShowed == freezed
          ? _value.receiveBackupDialogShowed
          : receiveBackupDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(
          _UserState value, $Res Function(_UserState) then) =
      __$UserStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      Map<String, dynamic> installConversionData,
      bool isLoggedOut,
      bool backup,
      bool? depositBannerShowed,
      bool? homeBackupDialogShowed,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool receiveBackupDialogShowed,
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
      @JsonKey(ignore: true)
          bool hasUpgrade,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale? locale,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      @JsonKey(ignore: true)
          PhoneAuthCredential? credentials});

  @override
  $WalletModulesCopyWith<$Res>? get walletModules;
}

/// @nodoc
class __$UserStateCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(_UserState _value, $Res Function(_UserState) _then)
      : super(_value, (v) => _then(v as _UserState));

  @override
  _UserState get _value => super._value as _UserState;

  @override
  $Res call({
    Object? walletModules = freezed,
    Object? installedAt = freezed,
    Object? isContactsSynced = freezed,
    Object? installConversionData = freezed,
    Object? isLoggedOut = freezed,
    Object? backup = freezed,
    Object? depositBannerShowed = freezed,
    Object? homeBackupDialogShowed = freezed,
    Object? walletAddress = freezed,
    Object? networks = freezed,
    Object? mnemonic = freezed,
    Object? privateKey = freezed,
    Object? pincode = freezed,
    Object? accountAddress = freezed,
    Object? countryCode = freezed,
    Object? phoneNumber = freezed,
    Object? receiveBackupDialogShowed = freezed,
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
  }) {
    return _then(_UserState(
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
      installConversionData: installConversionData == freezed
          ? _value.installConversionData
          : installConversionData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isLoggedOut: isLoggedOut == freezed
          ? _value.isLoggedOut
          : isLoggedOut // ignore: cast_nullable_to_non_nullable
              as bool,
      backup: backup == freezed
          ? _value.backup
          : backup // ignore: cast_nullable_to_non_nullable
              as bool,
      depositBannerShowed: depositBannerShowed == freezed
          ? _value.depositBannerShowed
          : depositBannerShowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      homeBackupDialogShowed: homeBackupDialogShowed == freezed
          ? _value.homeBackupDialogShowed
          : homeBackupDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      receiveBackupDialogShowed: receiveBackupDialogShowed == freezed
          ? _value.receiveBackupDialogShowed
          : receiveBackupDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool,
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
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_UserState extends _UserState with DiagnosticableTreeMixin {
  _$_UserState(
      {this.walletModules,
      this.installedAt,
      this.isContactsSynced,
      this.installConversionData = const {},
      this.isLoggedOut = false,
      this.backup = false,
      this.depositBannerShowed = false,
      this.homeBackupDialogShowed = false,
      this.walletAddress = '',
      this.networks = const [],
      this.mnemonic = const [],
      this.privateKey = '',
      this.pincode = '',
      this.accountAddress = '',
      this.countryCode = '',
      this.phoneNumber = '',
      this.receiveBackupDialogShowed = false,
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
      @JsonKey(ignore: true)
          this.hasUpgrade = false,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          this.authType = BiometricAuth.none,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          this.locale,
      @JsonKey(ignore: true)
          this.contacts = const [],
      @JsonKey(ignore: true)
          this.credentials})
      : super._();

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$$_UserStateFromJson(json);

  @override
  final WalletModules? walletModules;
  @override
  final DateTime? installedAt;
  @override
  final bool? isContactsSynced;
  @JsonKey()
  @override
  final Map<String, dynamic> installConversionData;
  @JsonKey()
  @override
  final bool isLoggedOut;
  @JsonKey()
  @override
  final bool backup;
  @JsonKey()
  @override
  final bool? depositBannerShowed;
  @JsonKey()
  @override
  final bool? homeBackupDialogShowed;
  @JsonKey()
  @override
  final String walletAddress;
  @JsonKey()
  @override
  final List<String> networks;
  @JsonKey()
  @override
  final List<String> mnemonic;
  @JsonKey()
  @override
  final String privateKey;
  @JsonKey()
  @override
  final String pincode;
  @JsonKey()
  @override
  final String accountAddress;
  @JsonKey()
  @override
  final String countryCode;
  @JsonKey()
  @override
  final String phoneNumber;
  @JsonKey()
  @override
  final bool receiveBackupDialogShowed;
  @JsonKey()
  @override
  final bool warnSendDialogShowed;
  @JsonKey()
  @override
  final String isoCode;
  @JsonKey()
  @override
  final String jwtToken;
  @JsonKey()
  @override
  final String displayName;
  @JsonKey()
  @override
  final String avatarUrl;
  @JsonKey()
  @override
  final String email;
  @override
  final String? verificationId;
  @JsonKey()
  @override
  final String identifier;
  @JsonKey()
  @override
  final List<String> syncedContacts;
  @JsonKey()
  @override
  final Map<String, String> reverseContacts;
  @JsonKey()
  @override
  final String currency;
  @override
  @JsonKey(ignore: true)
  final bool hasUpgrade;
  @override
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState(walletModules: $walletModules, installedAt: $installedAt, isContactsSynced: $isContactsSynced, installConversionData: $installConversionData, isLoggedOut: $isLoggedOut, backup: $backup, depositBannerShowed: $depositBannerShowed, homeBackupDialogShowed: $homeBackupDialogShowed, walletAddress: $walletAddress, networks: $networks, mnemonic: $mnemonic, privateKey: $privateKey, pincode: $pincode, accountAddress: $accountAddress, countryCode: $countryCode, phoneNumber: $phoneNumber, receiveBackupDialogShowed: $receiveBackupDialogShowed, warnSendDialogShowed: $warnSendDialogShowed, isoCode: $isoCode, jwtToken: $jwtToken, displayName: $displayName, avatarUrl: $avatarUrl, email: $email, verificationId: $verificationId, identifier: $identifier, syncedContacts: $syncedContacts, reverseContacts: $reverseContacts, currency: $currency, hasUpgrade: $hasUpgrade, authType: $authType, locale: $locale, contacts: $contacts, credentials: $credentials)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserState'))
      ..add(DiagnosticsProperty('walletModules', walletModules))
      ..add(DiagnosticsProperty('installedAt', installedAt))
      ..add(DiagnosticsProperty('isContactsSynced', isContactsSynced))
      ..add(DiagnosticsProperty('installConversionData', installConversionData))
      ..add(DiagnosticsProperty('isLoggedOut', isLoggedOut))
      ..add(DiagnosticsProperty('backup', backup))
      ..add(DiagnosticsProperty('depositBannerShowed', depositBannerShowed))
      ..add(
          DiagnosticsProperty('homeBackupDialogShowed', homeBackupDialogShowed))
      ..add(DiagnosticsProperty('walletAddress', walletAddress))
      ..add(DiagnosticsProperty('networks', networks))
      ..add(DiagnosticsProperty('mnemonic', mnemonic))
      ..add(DiagnosticsProperty('privateKey', privateKey))
      ..add(DiagnosticsProperty('pincode', pincode))
      ..add(DiagnosticsProperty('accountAddress', accountAddress))
      ..add(DiagnosticsProperty('countryCode', countryCode))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty(
          'receiveBackupDialogShowed', receiveBackupDialogShowed))
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
      ..add(DiagnosticsProperty('credentials', credentials));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserState &&
            const DeepCollectionEquality()
                .equals(other.walletModules, walletModules) &&
            const DeepCollectionEquality()
                .equals(other.installedAt, installedAt) &&
            const DeepCollectionEquality()
                .equals(other.isContactsSynced, isContactsSynced) &&
            const DeepCollectionEquality()
                .equals(other.installConversionData, installConversionData) &&
            const DeepCollectionEquality()
                .equals(other.isLoggedOut, isLoggedOut) &&
            const DeepCollectionEquality().equals(other.backup, backup) &&
            const DeepCollectionEquality()
                .equals(other.depositBannerShowed, depositBannerShowed) &&
            const DeepCollectionEquality()
                .equals(other.homeBackupDialogShowed, homeBackupDialogShowed) &&
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
            const DeepCollectionEquality().equals(
                other.receiveBackupDialogShowed, receiveBackupDialogShowed) &&
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
                .equals(other.credentials, credentials));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(walletModules),
        const DeepCollectionEquality().hash(installedAt),
        const DeepCollectionEquality().hash(isContactsSynced),
        const DeepCollectionEquality().hash(installConversionData),
        const DeepCollectionEquality().hash(isLoggedOut),
        const DeepCollectionEquality().hash(backup),
        const DeepCollectionEquality().hash(depositBannerShowed),
        const DeepCollectionEquality().hash(homeBackupDialogShowed),
        const DeepCollectionEquality().hash(walletAddress),
        const DeepCollectionEquality().hash(networks),
        const DeepCollectionEquality().hash(mnemonic),
        const DeepCollectionEquality().hash(privateKey),
        const DeepCollectionEquality().hash(pincode),
        const DeepCollectionEquality().hash(accountAddress),
        const DeepCollectionEquality().hash(countryCode),
        const DeepCollectionEquality().hash(phoneNumber),
        const DeepCollectionEquality().hash(receiveBackupDialogShowed),
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
        const DeepCollectionEquality().hash(credentials)
      ]);

  @JsonKey(ignore: true)
  @override
  _$UserStateCopyWith<_UserState> get copyWith =>
      __$UserStateCopyWithImpl<_UserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStateToJson(this);
  }
}

abstract class _UserState extends UserState {
  factory _UserState(
      {WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      Map<String, dynamic> installConversionData,
      bool isLoggedOut,
      bool backup,
      bool? depositBannerShowed,
      bool? homeBackupDialogShowed,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool receiveBackupDialogShowed,
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
      @JsonKey(ignore: true)
          bool hasUpgrade,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale? locale,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      @JsonKey(ignore: true)
          PhoneAuthCredential? credentials}) = _$_UserState;
  _UserState._() : super._();

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState.fromJson;

  @override
  WalletModules? get walletModules;
  @override
  DateTime? get installedAt;
  @override
  bool? get isContactsSynced;
  @override
  Map<String, dynamic> get installConversionData;
  @override
  bool get isLoggedOut;
  @override
  bool get backup;
  @override
  bool? get depositBannerShowed;
  @override
  bool? get homeBackupDialogShowed;
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
  bool get receiveBackupDialogShowed;
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
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
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
  @JsonKey(ignore: true)
  _$UserStateCopyWith<_UserState> get copyWith =>
      throw _privateConstructorUsedError;
}
