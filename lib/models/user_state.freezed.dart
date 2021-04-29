// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return _UserState.fromJson(json);
}

/// @nodoc
class _$UserStateTearOff {
  const _$UserStateTearOff();

// ignore: unused_element
  _UserState call(
      {bool isContactsSynced,
      DateTime installedAt,
      bool isLoggedOut,
      bool backup,
      bool depositBannerShowed,
      bool homeBackupDialogShowed,
      String walletAddress = '',
      List<String> networks = const [],
      List<String> mnemonic = const [],
      String privateKey = '',
      String pincode = '',
      String accountAddress = '',
      String countryCode = '',
      String phoneNumber = '',
      bool receiveBackupDialogShowed = false,
      String isoCode = '',
      String jwtToken = '',
      String displayName = 'Anom',
      String avatarUrl = '',
      String email = '',
      String verificationId = '',
      String identifier = '',
      List<String> syncedContacts = const [],
      Map<String, String> reverseContacts = const {},
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      @JsonKey(fromJson: currencyJson)
          String currency = 'usd',
      @JsonKey(ignore: true)
          bool isLoginRequest = false,
      @JsonKey(ignore: true)
          bool isVerifyRequest = false,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale locale,
      @JsonKey(ignore: true)
          List<Contact> contacts = const [],
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials}) {
    return _UserState(
      isContactsSynced: isContactsSynced,
      installedAt: installedAt,
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
      isoCode: isoCode,
      jwtToken: jwtToken,
      displayName: displayName,
      avatarUrl: avatarUrl,
      email: email,
      verificationId: verificationId,
      identifier: identifier,
      syncedContacts: syncedContacts,
      reverseContacts: reverseContacts,
      signupErrorMessage: signupErrorMessage,
      verifyErrorMessage: verifyErrorMessage,
      currency: currency,
      isLoginRequest: isLoginRequest,
      isVerifyRequest: isVerifyRequest,
      authType: authType,
      locale: locale,
      contacts: contacts,
      credentials: credentials,
    );
  }

// ignore: unused_element
  UserState fromJson(Map<String, Object> json) {
    return UserState.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $UserState = _$UserStateTearOff();

/// @nodoc
mixin _$UserState {
  bool get isContactsSynced;
  DateTime get installedAt;
  bool get isLoggedOut;
  bool get backup;
  bool get depositBannerShowed;
  bool get homeBackupDialogShowed;
  String get walletAddress;
  List<String> get networks;
  List<String> get mnemonic;
  String get privateKey;
  String get pincode;
  String get accountAddress;
  String get countryCode;
  String get phoneNumber;
  bool get receiveBackupDialogShowed;
  String get isoCode;
  String get jwtToken;
  String get displayName;
  String get avatarUrl;
  String get email;
  String get verificationId;
  String get identifier;
  List<String> get syncedContacts;
  Map<String, String> get reverseContacts;
  @JsonKey(ignore: true)
  dynamic get signupErrorMessage;
  @JsonKey(ignore: true)
  dynamic get verifyErrorMessage;
  @JsonKey(fromJson: currencyJson)
  String get currency;
  @JsonKey(ignore: true)
  bool get isLoginRequest;
  @JsonKey(ignore: true)
  bool get isVerifyRequest;
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  BiometricAuth get authType;
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale get locale;
  @JsonKey(ignore: true)
  List<Contact> get contacts;
  @JsonKey(ignore: true)
  PhoneAuthCredential get credentials;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res>;
  $Res call(
      {bool isContactsSynced,
      DateTime installedAt,
      bool isLoggedOut,
      bool backup,
      bool depositBannerShowed,
      bool homeBackupDialogShowed,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool receiveBackupDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      @JsonKey(fromJson: currencyJson)
          String currency,
      @JsonKey(ignore: true)
          bool isLoginRequest,
      @JsonKey(ignore: true)
          bool isVerifyRequest,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale locale,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials});
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res> implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  final UserState _value;
  // ignore: unused_field
  final $Res Function(UserState) _then;

  @override
  $Res call({
    Object isContactsSynced = freezed,
    Object installedAt = freezed,
    Object isLoggedOut = freezed,
    Object backup = freezed,
    Object depositBannerShowed = freezed,
    Object homeBackupDialogShowed = freezed,
    Object walletAddress = freezed,
    Object networks = freezed,
    Object mnemonic = freezed,
    Object privateKey = freezed,
    Object pincode = freezed,
    Object accountAddress = freezed,
    Object countryCode = freezed,
    Object phoneNumber = freezed,
    Object receiveBackupDialogShowed = freezed,
    Object isoCode = freezed,
    Object jwtToken = freezed,
    Object displayName = freezed,
    Object avatarUrl = freezed,
    Object email = freezed,
    Object verificationId = freezed,
    Object identifier = freezed,
    Object syncedContacts = freezed,
    Object reverseContacts = freezed,
    Object signupErrorMessage = freezed,
    Object verifyErrorMessage = freezed,
    Object currency = freezed,
    Object isLoginRequest = freezed,
    Object isVerifyRequest = freezed,
    Object authType = freezed,
    Object locale = freezed,
    Object contacts = freezed,
    Object credentials = freezed,
  }) {
    return _then(_value.copyWith(
      isContactsSynced: isContactsSynced == freezed
          ? _value.isContactsSynced
          : isContactsSynced as bool,
      installedAt:
          installedAt == freezed ? _value.installedAt : installedAt as DateTime,
      isLoggedOut:
          isLoggedOut == freezed ? _value.isLoggedOut : isLoggedOut as bool,
      backup: backup == freezed ? _value.backup : backup as bool,
      depositBannerShowed: depositBannerShowed == freezed
          ? _value.depositBannerShowed
          : depositBannerShowed as bool,
      homeBackupDialogShowed: homeBackupDialogShowed == freezed
          ? _value.homeBackupDialogShowed
          : homeBackupDialogShowed as bool,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress as String,
      networks:
          networks == freezed ? _value.networks : networks as List<String>,
      mnemonic:
          mnemonic == freezed ? _value.mnemonic : mnemonic as List<String>,
      privateKey:
          privateKey == freezed ? _value.privateKey : privateKey as String,
      pincode: pincode == freezed ? _value.pincode : pincode as String,
      accountAddress: accountAddress == freezed
          ? _value.accountAddress
          : accountAddress as String,
      countryCode:
          countryCode == freezed ? _value.countryCode : countryCode as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      receiveBackupDialogShowed: receiveBackupDialogShowed == freezed
          ? _value.receiveBackupDialogShowed
          : receiveBackupDialogShowed as bool,
      isoCode: isoCode == freezed ? _value.isoCode : isoCode as String,
      jwtToken: jwtToken == freezed ? _value.jwtToken : jwtToken as String,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      email: email == freezed ? _value.email : email as String,
      verificationId: verificationId == freezed
          ? _value.verificationId
          : verificationId as String,
      identifier:
          identifier == freezed ? _value.identifier : identifier as String,
      syncedContacts: syncedContacts == freezed
          ? _value.syncedContacts
          : syncedContacts as List<String>,
      reverseContacts: reverseContacts == freezed
          ? _value.reverseContacts
          : reverseContacts as Map<String, String>,
      signupErrorMessage: signupErrorMessage == freezed
          ? _value.signupErrorMessage
          : signupErrorMessage as dynamic,
      verifyErrorMessage: verifyErrorMessage == freezed
          ? _value.verifyErrorMessage
          : verifyErrorMessage as dynamic,
      currency: currency == freezed ? _value.currency : currency as String,
      isLoginRequest: isLoginRequest == freezed
          ? _value.isLoginRequest
          : isLoginRequest as bool,
      isVerifyRequest: isVerifyRequest == freezed
          ? _value.isVerifyRequest
          : isVerifyRequest as bool,
      authType:
          authType == freezed ? _value.authType : authType as BiometricAuth,
      locale: locale == freezed ? _value.locale : locale as Locale,
      contacts:
          contacts == freezed ? _value.contacts : contacts as List<Contact>,
      credentials: credentials == freezed
          ? _value.credentials
          : credentials as PhoneAuthCredential,
    ));
  }
}

/// @nodoc
abstract class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(
          _UserState value, $Res Function(_UserState) then) =
      __$UserStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isContactsSynced,
      DateTime installedAt,
      bool isLoggedOut,
      bool backup,
      bool depositBannerShowed,
      bool homeBackupDialogShowed,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool receiveBackupDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      @JsonKey(fromJson: currencyJson)
          String currency,
      @JsonKey(ignore: true)
          bool isLoginRequest,
      @JsonKey(ignore: true)
          bool isVerifyRequest,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale locale,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials});
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
    Object isContactsSynced = freezed,
    Object installedAt = freezed,
    Object isLoggedOut = freezed,
    Object backup = freezed,
    Object depositBannerShowed = freezed,
    Object homeBackupDialogShowed = freezed,
    Object walletAddress = freezed,
    Object networks = freezed,
    Object mnemonic = freezed,
    Object privateKey = freezed,
    Object pincode = freezed,
    Object accountAddress = freezed,
    Object countryCode = freezed,
    Object phoneNumber = freezed,
    Object receiveBackupDialogShowed = freezed,
    Object isoCode = freezed,
    Object jwtToken = freezed,
    Object displayName = freezed,
    Object avatarUrl = freezed,
    Object email = freezed,
    Object verificationId = freezed,
    Object identifier = freezed,
    Object syncedContacts = freezed,
    Object reverseContacts = freezed,
    Object signupErrorMessage = freezed,
    Object verifyErrorMessage = freezed,
    Object currency = freezed,
    Object isLoginRequest = freezed,
    Object isVerifyRequest = freezed,
    Object authType = freezed,
    Object locale = freezed,
    Object contacts = freezed,
    Object credentials = freezed,
  }) {
    return _then(_UserState(
      isContactsSynced: isContactsSynced == freezed
          ? _value.isContactsSynced
          : isContactsSynced as bool,
      installedAt:
          installedAt == freezed ? _value.installedAt : installedAt as DateTime,
      isLoggedOut:
          isLoggedOut == freezed ? _value.isLoggedOut : isLoggedOut as bool,
      backup: backup == freezed ? _value.backup : backup as bool,
      depositBannerShowed: depositBannerShowed == freezed
          ? _value.depositBannerShowed
          : depositBannerShowed as bool,
      homeBackupDialogShowed: homeBackupDialogShowed == freezed
          ? _value.homeBackupDialogShowed
          : homeBackupDialogShowed as bool,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress as String,
      networks:
          networks == freezed ? _value.networks : networks as List<String>,
      mnemonic:
          mnemonic == freezed ? _value.mnemonic : mnemonic as List<String>,
      privateKey:
          privateKey == freezed ? _value.privateKey : privateKey as String,
      pincode: pincode == freezed ? _value.pincode : pincode as String,
      accountAddress: accountAddress == freezed
          ? _value.accountAddress
          : accountAddress as String,
      countryCode:
          countryCode == freezed ? _value.countryCode : countryCode as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      receiveBackupDialogShowed: receiveBackupDialogShowed == freezed
          ? _value.receiveBackupDialogShowed
          : receiveBackupDialogShowed as bool,
      isoCode: isoCode == freezed ? _value.isoCode : isoCode as String,
      jwtToken: jwtToken == freezed ? _value.jwtToken : jwtToken as String,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      email: email == freezed ? _value.email : email as String,
      verificationId: verificationId == freezed
          ? _value.verificationId
          : verificationId as String,
      identifier:
          identifier == freezed ? _value.identifier : identifier as String,
      syncedContacts: syncedContacts == freezed
          ? _value.syncedContacts
          : syncedContacts as List<String>,
      reverseContacts: reverseContacts == freezed
          ? _value.reverseContacts
          : reverseContacts as Map<String, String>,
      signupErrorMessage: signupErrorMessage == freezed
          ? _value.signupErrorMessage
          : signupErrorMessage as dynamic,
      verifyErrorMessage: verifyErrorMessage == freezed
          ? _value.verifyErrorMessage
          : verifyErrorMessage as dynamic,
      currency: currency == freezed ? _value.currency : currency as String,
      isLoginRequest: isLoginRequest == freezed
          ? _value.isLoginRequest
          : isLoginRequest as bool,
      isVerifyRequest: isVerifyRequest == freezed
          ? _value.isVerifyRequest
          : isVerifyRequest as bool,
      authType:
          authType == freezed ? _value.authType : authType as BiometricAuth,
      locale: locale == freezed ? _value.locale : locale as Locale,
      contacts:
          contacts == freezed ? _value.contacts : contacts as List<Contact>,
      credentials: credentials == freezed
          ? _value.credentials
          : credentials as PhoneAuthCredential,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UserState extends _UserState {
  _$_UserState(
      {this.isContactsSynced,
      this.installedAt,
      this.isLoggedOut,
      this.backup,
      this.depositBannerShowed,
      this.homeBackupDialogShowed,
      this.walletAddress = '',
      this.networks = const [],
      this.mnemonic = const [],
      this.privateKey = '',
      this.pincode = '',
      this.accountAddress = '',
      this.countryCode = '',
      this.phoneNumber = '',
      this.receiveBackupDialogShowed = false,
      this.isoCode = '',
      this.jwtToken = '',
      this.displayName = 'Anom',
      this.avatarUrl = '',
      this.email = '',
      this.verificationId = '',
      this.identifier = '',
      this.syncedContacts = const [],
      this.reverseContacts = const {},
      @JsonKey(ignore: true)
          this.signupErrorMessage,
      @JsonKey(ignore: true)
          this.verifyErrorMessage,
      @JsonKey(fromJson: currencyJson)
          this.currency = 'usd',
      @JsonKey(ignore: true)
          this.isLoginRequest = false,
      @JsonKey(ignore: true)
          this.isVerifyRequest = false,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          this.authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          this.locale,
      @JsonKey(ignore: true)
          this.contacts = const [],
      @JsonKey(ignore: true)
          this.credentials})
      : assert(walletAddress != null),
        assert(networks != null),
        assert(mnemonic != null),
        assert(privateKey != null),
        assert(pincode != null),
        assert(accountAddress != null),
        assert(countryCode != null),
        assert(phoneNumber != null),
        assert(receiveBackupDialogShowed != null),
        assert(isoCode != null),
        assert(jwtToken != null),
        assert(displayName != null),
        assert(avatarUrl != null),
        assert(email != null),
        assert(verificationId != null),
        assert(identifier != null),
        assert(syncedContacts != null),
        assert(reverseContacts != null),
        assert(currency != null),
        assert(isLoginRequest != null),
        assert(isVerifyRequest != null),
        assert(contacts != null),
        super._();

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$_$_UserStateFromJson(json);

  @override
  final bool isContactsSynced;
  @override
  final DateTime installedAt;
  @override
  final bool isLoggedOut;
  @override
  final bool backup;
  @override
  final bool depositBannerShowed;
  @override
  final bool homeBackupDialogShowed;
  @JsonKey(defaultValue: '')
  @override
  final String walletAddress;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> networks;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> mnemonic;
  @JsonKey(defaultValue: '')
  @override
  final String privateKey;
  @JsonKey(defaultValue: '')
  @override
  final String pincode;
  @JsonKey(defaultValue: '')
  @override
  final String accountAddress;
  @JsonKey(defaultValue: '')
  @override
  final String countryCode;
  @JsonKey(defaultValue: '')
  @override
  final String phoneNumber;
  @JsonKey(defaultValue: false)
  @override
  final bool receiveBackupDialogShowed;
  @JsonKey(defaultValue: '')
  @override
  final String isoCode;
  @JsonKey(defaultValue: '')
  @override
  final String jwtToken;
  @JsonKey(defaultValue: 'Anom')
  @override
  final String displayName;
  @JsonKey(defaultValue: '')
  @override
  final String avatarUrl;
  @JsonKey(defaultValue: '')
  @override
  final String email;
  @JsonKey(defaultValue: '')
  @override
  final String verificationId;
  @JsonKey(defaultValue: '')
  @override
  final String identifier;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> syncedContacts;
  @JsonKey(defaultValue: const {})
  @override
  final Map<String, String> reverseContacts;
  @override
  @JsonKey(ignore: true)
  final dynamic signupErrorMessage;
  @override
  @JsonKey(ignore: true)
  final dynamic verifyErrorMessage;
  @override
  @JsonKey(fromJson: currencyJson)
  final String currency;
  @override
  @JsonKey(ignore: true)
  final bool isLoginRequest;
  @override
  @JsonKey(ignore: true)
  final bool isVerifyRequest;
  @override
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  final BiometricAuth authType;
  @override
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  final Locale locale;
  @override
  @JsonKey(ignore: true)
  final List<Contact> contacts;
  @override
  @JsonKey(ignore: true)
  final PhoneAuthCredential credentials;

  @override
  String toString() {
    return 'UserState(isContactsSynced: $isContactsSynced, installedAt: $installedAt, isLoggedOut: $isLoggedOut, backup: $backup, depositBannerShowed: $depositBannerShowed, homeBackupDialogShowed: $homeBackupDialogShowed, walletAddress: $walletAddress, networks: $networks, mnemonic: $mnemonic, privateKey: $privateKey, pincode: $pincode, accountAddress: $accountAddress, countryCode: $countryCode, phoneNumber: $phoneNumber, receiveBackupDialogShowed: $receiveBackupDialogShowed, isoCode: $isoCode, jwtToken: $jwtToken, displayName: $displayName, avatarUrl: $avatarUrl, email: $email, verificationId: $verificationId, identifier: $identifier, syncedContacts: $syncedContacts, reverseContacts: $reverseContacts, signupErrorMessage: $signupErrorMessage, verifyErrorMessage: $verifyErrorMessage, currency: $currency, isLoginRequest: $isLoginRequest, isVerifyRequest: $isVerifyRequest, authType: $authType, locale: $locale, contacts: $contacts, credentials: $credentials)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserState &&
            (identical(other.isContactsSynced, isContactsSynced) ||
                const DeepCollectionEquality()
                    .equals(other.isContactsSynced, isContactsSynced)) &&
            (identical(other.installedAt, installedAt) ||
                const DeepCollectionEquality()
                    .equals(other.installedAt, installedAt)) &&
            (identical(other.isLoggedOut, isLoggedOut) ||
                const DeepCollectionEquality()
                    .equals(other.isLoggedOut, isLoggedOut)) &&
            (identical(other.backup, backup) ||
                const DeepCollectionEquality().equals(other.backup, backup)) &&
            (identical(other.depositBannerShowed, depositBannerShowed) ||
                const DeepCollectionEquality()
                    .equals(other.depositBannerShowed, depositBannerShowed)) &&
            (identical(other.homeBackupDialogShowed, homeBackupDialogShowed) ||
                const DeepCollectionEquality().equals(
                    other.homeBackupDialogShowed, homeBackupDialogShowed)) &&
            (identical(other.walletAddress, walletAddress) ||
                const DeepCollectionEquality()
                    .equals(other.walletAddress, walletAddress)) &&
            (identical(other.networks, networks) ||
                const DeepCollectionEquality()
                    .equals(other.networks, networks)) &&
            (identical(other.mnemonic, mnemonic) ||
                const DeepCollectionEquality()
                    .equals(other.mnemonic, mnemonic)) &&
            (identical(other.privateKey, privateKey) ||
                const DeepCollectionEquality()
                    .equals(other.privateKey, privateKey)) &&
            (identical(other.pincode, pincode) ||
                const DeepCollectionEquality()
                    .equals(other.pincode, pincode)) &&
            (identical(other.accountAddress, accountAddress) ||
                const DeepCollectionEquality()
                    .equals(other.accountAddress, accountAddress)) &&
            (identical(other.countryCode, countryCode) ||
                const DeepCollectionEquality()
                    .equals(other.countryCode, countryCode)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.receiveBackupDialogShowed, receiveBackupDialogShowed) ||
                const DeepCollectionEquality().equals(
                    other.receiveBackupDialogShowed,
                    receiveBackupDialogShowed)) &&
            (identical(other.isoCode, isoCode) ||
                const DeepCollectionEquality()
                    .equals(other.isoCode, isoCode)) &&
            (identical(other.jwtToken, jwtToken) ||
                const DeepCollectionEquality()
                    .equals(other.jwtToken, jwtToken)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.verificationId, verificationId) ||
                const DeepCollectionEquality()
                    .equals(other.verificationId, verificationId)) &&
            (identical(other.identifier, identifier) || const DeepCollectionEquality().equals(other.identifier, identifier)) &&
            (identical(other.syncedContacts, syncedContacts) || const DeepCollectionEquality().equals(other.syncedContacts, syncedContacts)) &&
            (identical(other.reverseContacts, reverseContacts) || const DeepCollectionEquality().equals(other.reverseContacts, reverseContacts)) &&
            (identical(other.signupErrorMessage, signupErrorMessage) || const DeepCollectionEquality().equals(other.signupErrorMessage, signupErrorMessage)) &&
            (identical(other.verifyErrorMessage, verifyErrorMessage) || const DeepCollectionEquality().equals(other.verifyErrorMessage, verifyErrorMessage)) &&
            (identical(other.currency, currency) || const DeepCollectionEquality().equals(other.currency, currency)) &&
            (identical(other.isLoginRequest, isLoginRequest) || const DeepCollectionEquality().equals(other.isLoginRequest, isLoginRequest)) &&
            (identical(other.isVerifyRequest, isVerifyRequest) || const DeepCollectionEquality().equals(other.isVerifyRequest, isVerifyRequest)) &&
            (identical(other.authType, authType) || const DeepCollectionEquality().equals(other.authType, authType)) &&
            (identical(other.locale, locale) || const DeepCollectionEquality().equals(other.locale, locale)) &&
            (identical(other.contacts, contacts) || const DeepCollectionEquality().equals(other.contacts, contacts)) &&
            (identical(other.credentials, credentials) || const DeepCollectionEquality().equals(other.credentials, credentials)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isContactsSynced) ^
      const DeepCollectionEquality().hash(installedAt) ^
      const DeepCollectionEquality().hash(isLoggedOut) ^
      const DeepCollectionEquality().hash(backup) ^
      const DeepCollectionEquality().hash(depositBannerShowed) ^
      const DeepCollectionEquality().hash(homeBackupDialogShowed) ^
      const DeepCollectionEquality().hash(walletAddress) ^
      const DeepCollectionEquality().hash(networks) ^
      const DeepCollectionEquality().hash(mnemonic) ^
      const DeepCollectionEquality().hash(privateKey) ^
      const DeepCollectionEquality().hash(pincode) ^
      const DeepCollectionEquality().hash(accountAddress) ^
      const DeepCollectionEquality().hash(countryCode) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(receiveBackupDialogShowed) ^
      const DeepCollectionEquality().hash(isoCode) ^
      const DeepCollectionEquality().hash(jwtToken) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(verificationId) ^
      const DeepCollectionEquality().hash(identifier) ^
      const DeepCollectionEquality().hash(syncedContacts) ^
      const DeepCollectionEquality().hash(reverseContacts) ^
      const DeepCollectionEquality().hash(signupErrorMessage) ^
      const DeepCollectionEquality().hash(verifyErrorMessage) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(isLoginRequest) ^
      const DeepCollectionEquality().hash(isVerifyRequest) ^
      const DeepCollectionEquality().hash(authType) ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(contacts) ^
      const DeepCollectionEquality().hash(credentials);

  @JsonKey(ignore: true)
  @override
  _$UserStateCopyWith<_UserState> get copyWith =>
      __$UserStateCopyWithImpl<_UserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserStateToJson(this);
  }
}

abstract class _UserState extends UserState {
  _UserState._() : super._();
  factory _UserState(
      {bool isContactsSynced,
      DateTime installedAt,
      bool isLoggedOut,
      bool backup,
      bool depositBannerShowed,
      bool homeBackupDialogShowed,
      String walletAddress,
      List<String> networks,
      List<String> mnemonic,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      bool receiveBackupDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      @JsonKey(fromJson: currencyJson)
          String currency,
      @JsonKey(ignore: true)
          bool isLoginRequest,
      @JsonKey(ignore: true)
          bool isVerifyRequest,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
          Locale locale,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials}) = _$_UserState;

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState.fromJson;

  @override
  bool get isContactsSynced;
  @override
  DateTime get installedAt;
  @override
  bool get isLoggedOut;
  @override
  bool get backup;
  @override
  bool get depositBannerShowed;
  @override
  bool get homeBackupDialogShowed;
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
  String get verificationId;
  @override
  String get identifier;
  @override
  List<String> get syncedContacts;
  @override
  Map<String, String> get reverseContacts;
  @override
  @JsonKey(ignore: true)
  dynamic get signupErrorMessage;
  @override
  @JsonKey(ignore: true)
  dynamic get verifyErrorMessage;
  @override
  @JsonKey(fromJson: currencyJson)
  String get currency;
  @override
  @JsonKey(ignore: true)
  bool get isLoginRequest;
  @override
  @JsonKey(ignore: true)
  bool get isVerifyRequest;
  @override
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  BiometricAuth get authType;
  @override
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale get locale;
  @override
  @JsonKey(ignore: true)
  List<Contact> get contacts;
  @override
  @JsonKey(ignore: true)
  PhoneAuthCredential get credentials;
  @override
  @JsonKey(ignore: true)
  _$UserStateCopyWith<_UserState> get copyWith;
}
