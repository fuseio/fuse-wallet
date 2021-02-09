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
      {String walletStatus = '',
      String walletAddress = '',
      String communityManagerAddress = '',
      String transferManagerAddress = '',
      String daiPointsManagerAddress = '',
      List<String> networks,
      List<String> mnemonic,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      String privateKey = '',
      String pincode = '',
      String accountAddress = '',
      String countryCode = '',
      String phoneNumber = '',
      String normalizedPhoneNumber = '',
      String isoCode = '',
      @JsonKey(ignore: true)
          List<Contact> contacts,
      Map<String, String> reverseContacts = const {},
      List<String> syncedContacts,
      String jwtToken = '',
      String displayName = 'Anom',
      String avatarUrl = '',
      String email = '',
      String verificationId = '',
      String identifier = '',
      bool isLoggedOut = false,
      bool isContactsSynced = false,
      bool backup = false,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials,
      int displayBalance,
      DateTime installedAt,
      @JsonKey(fromJson: currencyJson)
          String currency = 'usd',
      num totalBalance = 0,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      bool depositBannerShowed = false,
      @JsonKey(ignore: true)
          bool isLoginRequest = false,
      @JsonKey(ignore: true)
          bool isVerifyRequest = false,
      @JsonKey(ignore: true)
          bool homeBackupDialogShowed = false,
      @JsonKey(ignore: true)
          bool receiveBackupDialogShowed = false}) {
    return _UserState(
      walletStatus: walletStatus,
      walletAddress: walletAddress,
      communityManagerAddress: communityManagerAddress,
      transferManagerAddress: transferManagerAddress,
      daiPointsManagerAddress: daiPointsManagerAddress,
      networks: networks,
      mnemonic: mnemonic,
      authType: authType,
      privateKey: privateKey,
      pincode: pincode,
      accountAddress: accountAddress,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      normalizedPhoneNumber: normalizedPhoneNumber,
      isoCode: isoCode,
      contacts: contacts,
      reverseContacts: reverseContacts,
      syncedContacts: syncedContacts,
      jwtToken: jwtToken,
      displayName: displayName,
      avatarUrl: avatarUrl,
      email: email,
      verificationId: verificationId,
      identifier: identifier,
      isLoggedOut: isLoggedOut,
      isContactsSynced: isContactsSynced,
      backup: backup,
      credentials: credentials,
      displayBalance: displayBalance,
      installedAt: installedAt,
      currency: currency,
      totalBalance: totalBalance,
      signupErrorMessage: signupErrorMessage,
      verifyErrorMessage: verifyErrorMessage,
      depositBannerShowed: depositBannerShowed,
      isLoginRequest: isLoginRequest,
      isVerifyRequest: isVerifyRequest,
      homeBackupDialogShowed: homeBackupDialogShowed,
      receiveBackupDialogShowed: receiveBackupDialogShowed,
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
  String get walletStatus;
  String get walletAddress;
  String get communityManagerAddress;
  String get transferManagerAddress;
  String get daiPointsManagerAddress;
  List<String> get networks;
  List<String> get mnemonic;
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  BiometricAuth get authType;
  String get privateKey;
  String get pincode;
  String get accountAddress;
  String get countryCode;
  String get phoneNumber;
  String get normalizedPhoneNumber;
  String get isoCode;
  @JsonKey(ignore: true)
  List<Contact> get contacts;
  Map<String, String> get reverseContacts;
  List<String> get syncedContacts;
  String get jwtToken;
  String get displayName;
  String get avatarUrl;
  String get email;
  String get verificationId;
  String get identifier;
  bool get isLoggedOut;
  bool get isContactsSynced;
  bool get backup;
  @JsonKey(ignore: true)
  PhoneAuthCredential get credentials;
  int get displayBalance;
  DateTime get installedAt;
  @JsonKey(fromJson: currencyJson)
  String get currency;
  num get totalBalance;
  @JsonKey(ignore: true)
  dynamic get signupErrorMessage;
  @JsonKey(ignore: true)
  dynamic get verifyErrorMessage;
  bool get depositBannerShowed;
  @JsonKey(ignore: true)
  bool get isLoginRequest;
  @JsonKey(ignore: true)
  bool get isVerifyRequest;
  @JsonKey(ignore: true)
  bool get homeBackupDialogShowed;
  @JsonKey(ignore: true)
  bool get receiveBackupDialogShowed;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res>;
  $Res call(
      {String walletStatus,
      String walletAddress,
      String communityManagerAddress,
      String transferManagerAddress,
      String daiPointsManagerAddress,
      List<String> networks,
      List<String> mnemonic,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      String normalizedPhoneNumber,
      String isoCode,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      Map<String, String> reverseContacts,
      List<String> syncedContacts,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      bool isLoggedOut,
      bool isContactsSynced,
      bool backup,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials,
      int displayBalance,
      DateTime installedAt,
      @JsonKey(fromJson: currencyJson)
          String currency,
      num totalBalance,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      bool depositBannerShowed,
      @JsonKey(ignore: true)
          bool isLoginRequest,
      @JsonKey(ignore: true)
          bool isVerifyRequest,
      @JsonKey(ignore: true)
          bool homeBackupDialogShowed,
      @JsonKey(ignore: true)
          bool receiveBackupDialogShowed});
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res> implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  final UserState _value;
  // ignore: unused_field
  final $Res Function(UserState) _then;

  @override
  $Res call({
    Object walletStatus = freezed,
    Object walletAddress = freezed,
    Object communityManagerAddress = freezed,
    Object transferManagerAddress = freezed,
    Object daiPointsManagerAddress = freezed,
    Object networks = freezed,
    Object mnemonic = freezed,
    Object authType = freezed,
    Object privateKey = freezed,
    Object pincode = freezed,
    Object accountAddress = freezed,
    Object countryCode = freezed,
    Object phoneNumber = freezed,
    Object normalizedPhoneNumber = freezed,
    Object isoCode = freezed,
    Object contacts = freezed,
    Object reverseContacts = freezed,
    Object syncedContacts = freezed,
    Object jwtToken = freezed,
    Object displayName = freezed,
    Object avatarUrl = freezed,
    Object email = freezed,
    Object verificationId = freezed,
    Object identifier = freezed,
    Object isLoggedOut = freezed,
    Object isContactsSynced = freezed,
    Object backup = freezed,
    Object credentials = freezed,
    Object displayBalance = freezed,
    Object installedAt = freezed,
    Object currency = freezed,
    Object totalBalance = freezed,
    Object signupErrorMessage = freezed,
    Object verifyErrorMessage = freezed,
    Object depositBannerShowed = freezed,
    Object isLoginRequest = freezed,
    Object isVerifyRequest = freezed,
    Object homeBackupDialogShowed = freezed,
    Object receiveBackupDialogShowed = freezed,
  }) {
    return _then(_value.copyWith(
      walletStatus: walletStatus == freezed
          ? _value.walletStatus
          : walletStatus as String,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress as String,
      communityManagerAddress: communityManagerAddress == freezed
          ? _value.communityManagerAddress
          : communityManagerAddress as String,
      transferManagerAddress: transferManagerAddress == freezed
          ? _value.transferManagerAddress
          : transferManagerAddress as String,
      daiPointsManagerAddress: daiPointsManagerAddress == freezed
          ? _value.daiPointsManagerAddress
          : daiPointsManagerAddress as String,
      networks:
          networks == freezed ? _value.networks : networks as List<String>,
      mnemonic:
          mnemonic == freezed ? _value.mnemonic : mnemonic as List<String>,
      authType:
          authType == freezed ? _value.authType : authType as BiometricAuth,
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
      normalizedPhoneNumber: normalizedPhoneNumber == freezed
          ? _value.normalizedPhoneNumber
          : normalizedPhoneNumber as String,
      isoCode: isoCode == freezed ? _value.isoCode : isoCode as String,
      contacts:
          contacts == freezed ? _value.contacts : contacts as List<Contact>,
      reverseContacts: reverseContacts == freezed
          ? _value.reverseContacts
          : reverseContacts as Map<String, String>,
      syncedContacts: syncedContacts == freezed
          ? _value.syncedContacts
          : syncedContacts as List<String>,
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
      isLoggedOut:
          isLoggedOut == freezed ? _value.isLoggedOut : isLoggedOut as bool,
      isContactsSynced: isContactsSynced == freezed
          ? _value.isContactsSynced
          : isContactsSynced as bool,
      backup: backup == freezed ? _value.backup : backup as bool,
      credentials: credentials == freezed
          ? _value.credentials
          : credentials as PhoneAuthCredential,
      displayBalance: displayBalance == freezed
          ? _value.displayBalance
          : displayBalance as int,
      installedAt:
          installedAt == freezed ? _value.installedAt : installedAt as DateTime,
      currency: currency == freezed ? _value.currency : currency as String,
      totalBalance:
          totalBalance == freezed ? _value.totalBalance : totalBalance as num,
      signupErrorMessage: signupErrorMessage == freezed
          ? _value.signupErrorMessage
          : signupErrorMessage as dynamic,
      verifyErrorMessage: verifyErrorMessage == freezed
          ? _value.verifyErrorMessage
          : verifyErrorMessage as dynamic,
      depositBannerShowed: depositBannerShowed == freezed
          ? _value.depositBannerShowed
          : depositBannerShowed as bool,
      isLoginRequest: isLoginRequest == freezed
          ? _value.isLoginRequest
          : isLoginRequest as bool,
      isVerifyRequest: isVerifyRequest == freezed
          ? _value.isVerifyRequest
          : isVerifyRequest as bool,
      homeBackupDialogShowed: homeBackupDialogShowed == freezed
          ? _value.homeBackupDialogShowed
          : homeBackupDialogShowed as bool,
      receiveBackupDialogShowed: receiveBackupDialogShowed == freezed
          ? _value.receiveBackupDialogShowed
          : receiveBackupDialogShowed as bool,
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
      {String walletStatus,
      String walletAddress,
      String communityManagerAddress,
      String transferManagerAddress,
      String daiPointsManagerAddress,
      List<String> networks,
      List<String> mnemonic,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      String normalizedPhoneNumber,
      String isoCode,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      Map<String, String> reverseContacts,
      List<String> syncedContacts,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      bool isLoggedOut,
      bool isContactsSynced,
      bool backup,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials,
      int displayBalance,
      DateTime installedAt,
      @JsonKey(fromJson: currencyJson)
          String currency,
      num totalBalance,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      bool depositBannerShowed,
      @JsonKey(ignore: true)
          bool isLoginRequest,
      @JsonKey(ignore: true)
          bool isVerifyRequest,
      @JsonKey(ignore: true)
          bool homeBackupDialogShowed,
      @JsonKey(ignore: true)
          bool receiveBackupDialogShowed});
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
    Object walletStatus = freezed,
    Object walletAddress = freezed,
    Object communityManagerAddress = freezed,
    Object transferManagerAddress = freezed,
    Object daiPointsManagerAddress = freezed,
    Object networks = freezed,
    Object mnemonic = freezed,
    Object authType = freezed,
    Object privateKey = freezed,
    Object pincode = freezed,
    Object accountAddress = freezed,
    Object countryCode = freezed,
    Object phoneNumber = freezed,
    Object normalizedPhoneNumber = freezed,
    Object isoCode = freezed,
    Object contacts = freezed,
    Object reverseContacts = freezed,
    Object syncedContacts = freezed,
    Object jwtToken = freezed,
    Object displayName = freezed,
    Object avatarUrl = freezed,
    Object email = freezed,
    Object verificationId = freezed,
    Object identifier = freezed,
    Object isLoggedOut = freezed,
    Object isContactsSynced = freezed,
    Object backup = freezed,
    Object credentials = freezed,
    Object displayBalance = freezed,
    Object installedAt = freezed,
    Object currency = freezed,
    Object totalBalance = freezed,
    Object signupErrorMessage = freezed,
    Object verifyErrorMessage = freezed,
    Object depositBannerShowed = freezed,
    Object isLoginRequest = freezed,
    Object isVerifyRequest = freezed,
    Object homeBackupDialogShowed = freezed,
    Object receiveBackupDialogShowed = freezed,
  }) {
    return _then(_UserState(
      walletStatus: walletStatus == freezed
          ? _value.walletStatus
          : walletStatus as String,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress as String,
      communityManagerAddress: communityManagerAddress == freezed
          ? _value.communityManagerAddress
          : communityManagerAddress as String,
      transferManagerAddress: transferManagerAddress == freezed
          ? _value.transferManagerAddress
          : transferManagerAddress as String,
      daiPointsManagerAddress: daiPointsManagerAddress == freezed
          ? _value.daiPointsManagerAddress
          : daiPointsManagerAddress as String,
      networks:
          networks == freezed ? _value.networks : networks as List<String>,
      mnemonic:
          mnemonic == freezed ? _value.mnemonic : mnemonic as List<String>,
      authType:
          authType == freezed ? _value.authType : authType as BiometricAuth,
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
      normalizedPhoneNumber: normalizedPhoneNumber == freezed
          ? _value.normalizedPhoneNumber
          : normalizedPhoneNumber as String,
      isoCode: isoCode == freezed ? _value.isoCode : isoCode as String,
      contacts:
          contacts == freezed ? _value.contacts : contacts as List<Contact>,
      reverseContacts: reverseContacts == freezed
          ? _value.reverseContacts
          : reverseContacts as Map<String, String>,
      syncedContacts: syncedContacts == freezed
          ? _value.syncedContacts
          : syncedContacts as List<String>,
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
      isLoggedOut:
          isLoggedOut == freezed ? _value.isLoggedOut : isLoggedOut as bool,
      isContactsSynced: isContactsSynced == freezed
          ? _value.isContactsSynced
          : isContactsSynced as bool,
      backup: backup == freezed ? _value.backup : backup as bool,
      credentials: credentials == freezed
          ? _value.credentials
          : credentials as PhoneAuthCredential,
      displayBalance: displayBalance == freezed
          ? _value.displayBalance
          : displayBalance as int,
      installedAt:
          installedAt == freezed ? _value.installedAt : installedAt as DateTime,
      currency: currency == freezed ? _value.currency : currency as String,
      totalBalance:
          totalBalance == freezed ? _value.totalBalance : totalBalance as num,
      signupErrorMessage: signupErrorMessage == freezed
          ? _value.signupErrorMessage
          : signupErrorMessage as dynamic,
      verifyErrorMessage: verifyErrorMessage == freezed
          ? _value.verifyErrorMessage
          : verifyErrorMessage as dynamic,
      depositBannerShowed: depositBannerShowed == freezed
          ? _value.depositBannerShowed
          : depositBannerShowed as bool,
      isLoginRequest: isLoginRequest == freezed
          ? _value.isLoginRequest
          : isLoginRequest as bool,
      isVerifyRequest: isVerifyRequest == freezed
          ? _value.isVerifyRequest
          : isVerifyRequest as bool,
      homeBackupDialogShowed: homeBackupDialogShowed == freezed
          ? _value.homeBackupDialogShowed
          : homeBackupDialogShowed as bool,
      receiveBackupDialogShowed: receiveBackupDialogShowed == freezed
          ? _value.receiveBackupDialogShowed
          : receiveBackupDialogShowed as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UserState implements _UserState {
  _$_UserState(
      {this.walletStatus = '',
      this.walletAddress = '',
      this.communityManagerAddress = '',
      this.transferManagerAddress = '',
      this.daiPointsManagerAddress = '',
      this.networks,
      this.mnemonic,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          this.authType,
      this.privateKey = '',
      this.pincode = '',
      this.accountAddress = '',
      this.countryCode = '',
      this.phoneNumber = '',
      this.normalizedPhoneNumber = '',
      this.isoCode = '',
      @JsonKey(ignore: true)
          this.contacts,
      this.reverseContacts = const {},
      this.syncedContacts,
      this.jwtToken = '',
      this.displayName = 'Anom',
      this.avatarUrl = '',
      this.email = '',
      this.verificationId = '',
      this.identifier = '',
      this.isLoggedOut = false,
      this.isContactsSynced = false,
      this.backup = false,
      @JsonKey(ignore: true)
          this.credentials,
      this.displayBalance,
      this.installedAt,
      @JsonKey(fromJson: currencyJson)
          this.currency = 'usd',
      this.totalBalance = 0,
      @JsonKey(ignore: true)
          this.signupErrorMessage,
      @JsonKey(ignore: true)
          this.verifyErrorMessage,
      this.depositBannerShowed = false,
      @JsonKey(ignore: true)
          this.isLoginRequest = false,
      @JsonKey(ignore: true)
          this.isVerifyRequest = false,
      @JsonKey(ignore: true)
          this.homeBackupDialogShowed = false,
      @JsonKey(ignore: true)
          this.receiveBackupDialogShowed = false})
      : assert(walletStatus != null),
        assert(walletAddress != null),
        assert(communityManagerAddress != null),
        assert(transferManagerAddress != null),
        assert(daiPointsManagerAddress != null),
        assert(privateKey != null),
        assert(pincode != null),
        assert(accountAddress != null),
        assert(countryCode != null),
        assert(phoneNumber != null),
        assert(normalizedPhoneNumber != null),
        assert(isoCode != null),
        assert(reverseContacts != null),
        assert(jwtToken != null),
        assert(displayName != null),
        assert(avatarUrl != null),
        assert(email != null),
        assert(verificationId != null),
        assert(identifier != null),
        assert(isLoggedOut != null),
        assert(isContactsSynced != null),
        assert(backup != null),
        assert(currency != null),
        assert(totalBalance != null),
        assert(depositBannerShowed != null),
        assert(isLoginRequest != null),
        assert(isVerifyRequest != null),
        assert(homeBackupDialogShowed != null),
        assert(receiveBackupDialogShowed != null);

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$_$_UserStateFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String walletStatus;
  @JsonKey(defaultValue: '')
  @override
  final String walletAddress;
  @JsonKey(defaultValue: '')
  @override
  final String communityManagerAddress;
  @JsonKey(defaultValue: '')
  @override
  final String transferManagerAddress;
  @JsonKey(defaultValue: '')
  @override
  final String daiPointsManagerAddress;
  @override
  final List<String> networks;
  @override
  final List<String> mnemonic;
  @override
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  final BiometricAuth authType;
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
  @JsonKey(defaultValue: '')
  @override
  final String normalizedPhoneNumber;
  @JsonKey(defaultValue: '')
  @override
  final String isoCode;
  @override
  @JsonKey(ignore: true)
  final List<Contact> contacts;
  @JsonKey(defaultValue: const {})
  @override
  final Map<String, String> reverseContacts;
  @override
  final List<String> syncedContacts;
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
  @JsonKey(defaultValue: false)
  @override
  final bool isLoggedOut;
  @JsonKey(defaultValue: false)
  @override
  final bool isContactsSynced;
  @JsonKey(defaultValue: false)
  @override
  final bool backup;
  @override
  @JsonKey(ignore: true)
  final PhoneAuthCredential credentials;
  @override
  final int displayBalance;
  @override
  final DateTime installedAt;
  @override
  @JsonKey(fromJson: currencyJson)
  final String currency;
  @JsonKey(defaultValue: 0)
  @override
  final num totalBalance;
  @override
  @JsonKey(ignore: true)
  final dynamic signupErrorMessage;
  @override
  @JsonKey(ignore: true)
  final dynamic verifyErrorMessage;
  @JsonKey(defaultValue: false)
  @override
  final bool depositBannerShowed;
  @override
  @JsonKey(ignore: true)
  final bool isLoginRequest;
  @override
  @JsonKey(ignore: true)
  final bool isVerifyRequest;
  @override
  @JsonKey(ignore: true)
  final bool homeBackupDialogShowed;
  @override
  @JsonKey(ignore: true)
  final bool receiveBackupDialogShowed;

  @override
  String toString() {
    return 'UserState(walletStatus: $walletStatus, walletAddress: $walletAddress, communityManagerAddress: $communityManagerAddress, transferManagerAddress: $transferManagerAddress, daiPointsManagerAddress: $daiPointsManagerAddress, networks: $networks, mnemonic: $mnemonic, authType: $authType, privateKey: $privateKey, pincode: $pincode, accountAddress: $accountAddress, countryCode: $countryCode, phoneNumber: $phoneNumber, normalizedPhoneNumber: $normalizedPhoneNumber, isoCode: $isoCode, contacts: $contacts, reverseContacts: $reverseContacts, syncedContacts: $syncedContacts, jwtToken: $jwtToken, displayName: $displayName, avatarUrl: $avatarUrl, email: $email, verificationId: $verificationId, identifier: $identifier, isLoggedOut: $isLoggedOut, isContactsSynced: $isContactsSynced, backup: $backup, credentials: $credentials, displayBalance: $displayBalance, installedAt: $installedAt, currency: $currency, totalBalance: $totalBalance, signupErrorMessage: $signupErrorMessage, verifyErrorMessage: $verifyErrorMessage, depositBannerShowed: $depositBannerShowed, isLoginRequest: $isLoginRequest, isVerifyRequest: $isVerifyRequest, homeBackupDialogShowed: $homeBackupDialogShowed, receiveBackupDialogShowed: $receiveBackupDialogShowed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserState &&
            (identical(other.walletStatus, walletStatus) ||
                const DeepCollectionEquality()
                    .equals(other.walletStatus, walletStatus)) &&
            (identical(other.walletAddress, walletAddress) ||
                const DeepCollectionEquality()
                    .equals(other.walletAddress, walletAddress)) &&
            (identical(other.communityManagerAddress, communityManagerAddress) ||
                const DeepCollectionEquality().equals(
                    other.communityManagerAddress, communityManagerAddress)) &&
            (identical(other.transferManagerAddress, transferManagerAddress) ||
                const DeepCollectionEquality().equals(
                    other.transferManagerAddress, transferManagerAddress)) &&
            (identical(other.daiPointsManagerAddress, daiPointsManagerAddress) ||
                const DeepCollectionEquality().equals(
                    other.daiPointsManagerAddress, daiPointsManagerAddress)) &&
            (identical(other.networks, networks) ||
                const DeepCollectionEquality()
                    .equals(other.networks, networks)) &&
            (identical(other.mnemonic, mnemonic) ||
                const DeepCollectionEquality()
                    .equals(other.mnemonic, mnemonic)) &&
            (identical(other.authType, authType) ||
                const DeepCollectionEquality()
                    .equals(other.authType, authType)) &&
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
            (identical(other.normalizedPhoneNumber, normalizedPhoneNumber) ||
                const DeepCollectionEquality().equals(
                    other.normalizedPhoneNumber, normalizedPhoneNumber)) &&
            (identical(other.isoCode, isoCode) || const DeepCollectionEquality().equals(other.isoCode, isoCode)) &&
            (identical(other.contacts, contacts) || const DeepCollectionEquality().equals(other.contacts, contacts)) &&
            (identical(other.reverseContacts, reverseContacts) || const DeepCollectionEquality().equals(other.reverseContacts, reverseContacts)) &&
            (identical(other.syncedContacts, syncedContacts) || const DeepCollectionEquality().equals(other.syncedContacts, syncedContacts)) &&
            (identical(other.jwtToken, jwtToken) || const DeepCollectionEquality().equals(other.jwtToken, jwtToken)) &&
            (identical(other.displayName, displayName) || const DeepCollectionEquality().equals(other.displayName, displayName)) &&
            (identical(other.avatarUrl, avatarUrl) || const DeepCollectionEquality().equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.email, email) || const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.verificationId, verificationId) || const DeepCollectionEquality().equals(other.verificationId, verificationId)) &&
            (identical(other.identifier, identifier) || const DeepCollectionEquality().equals(other.identifier, identifier)) &&
            (identical(other.isLoggedOut, isLoggedOut) || const DeepCollectionEquality().equals(other.isLoggedOut, isLoggedOut)) &&
            (identical(other.isContactsSynced, isContactsSynced) || const DeepCollectionEquality().equals(other.isContactsSynced, isContactsSynced)) &&
            (identical(other.backup, backup) || const DeepCollectionEquality().equals(other.backup, backup)) &&
            (identical(other.credentials, credentials) || const DeepCollectionEquality().equals(other.credentials, credentials)) &&
            (identical(other.displayBalance, displayBalance) || const DeepCollectionEquality().equals(other.displayBalance, displayBalance)) &&
            (identical(other.installedAt, installedAt) || const DeepCollectionEquality().equals(other.installedAt, installedAt)) &&
            (identical(other.currency, currency) || const DeepCollectionEquality().equals(other.currency, currency)) &&
            (identical(other.totalBalance, totalBalance) || const DeepCollectionEquality().equals(other.totalBalance, totalBalance)) &&
            (identical(other.signupErrorMessage, signupErrorMessage) || const DeepCollectionEquality().equals(other.signupErrorMessage, signupErrorMessage)) &&
            (identical(other.verifyErrorMessage, verifyErrorMessage) || const DeepCollectionEquality().equals(other.verifyErrorMessage, verifyErrorMessage)) &&
            (identical(other.depositBannerShowed, depositBannerShowed) || const DeepCollectionEquality().equals(other.depositBannerShowed, depositBannerShowed)) &&
            (identical(other.isLoginRequest, isLoginRequest) || const DeepCollectionEquality().equals(other.isLoginRequest, isLoginRequest)) &&
            (identical(other.isVerifyRequest, isVerifyRequest) || const DeepCollectionEquality().equals(other.isVerifyRequest, isVerifyRequest)) &&
            (identical(other.homeBackupDialogShowed, homeBackupDialogShowed) || const DeepCollectionEquality().equals(other.homeBackupDialogShowed, homeBackupDialogShowed)) &&
            (identical(other.receiveBackupDialogShowed, receiveBackupDialogShowed) || const DeepCollectionEquality().equals(other.receiveBackupDialogShowed, receiveBackupDialogShowed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(walletStatus) ^
      const DeepCollectionEquality().hash(walletAddress) ^
      const DeepCollectionEquality().hash(communityManagerAddress) ^
      const DeepCollectionEquality().hash(transferManagerAddress) ^
      const DeepCollectionEquality().hash(daiPointsManagerAddress) ^
      const DeepCollectionEquality().hash(networks) ^
      const DeepCollectionEquality().hash(mnemonic) ^
      const DeepCollectionEquality().hash(authType) ^
      const DeepCollectionEquality().hash(privateKey) ^
      const DeepCollectionEquality().hash(pincode) ^
      const DeepCollectionEquality().hash(accountAddress) ^
      const DeepCollectionEquality().hash(countryCode) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(normalizedPhoneNumber) ^
      const DeepCollectionEquality().hash(isoCode) ^
      const DeepCollectionEquality().hash(contacts) ^
      const DeepCollectionEquality().hash(reverseContacts) ^
      const DeepCollectionEquality().hash(syncedContacts) ^
      const DeepCollectionEquality().hash(jwtToken) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(verificationId) ^
      const DeepCollectionEquality().hash(identifier) ^
      const DeepCollectionEquality().hash(isLoggedOut) ^
      const DeepCollectionEquality().hash(isContactsSynced) ^
      const DeepCollectionEquality().hash(backup) ^
      const DeepCollectionEquality().hash(credentials) ^
      const DeepCollectionEquality().hash(displayBalance) ^
      const DeepCollectionEquality().hash(installedAt) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(totalBalance) ^
      const DeepCollectionEquality().hash(signupErrorMessage) ^
      const DeepCollectionEquality().hash(verifyErrorMessage) ^
      const DeepCollectionEquality().hash(depositBannerShowed) ^
      const DeepCollectionEquality().hash(isLoginRequest) ^
      const DeepCollectionEquality().hash(isVerifyRequest) ^
      const DeepCollectionEquality().hash(homeBackupDialogShowed) ^
      const DeepCollectionEquality().hash(receiveBackupDialogShowed);

  @JsonKey(ignore: true)
  @override
  _$UserStateCopyWith<_UserState> get copyWith =>
      __$UserStateCopyWithImpl<_UserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserStateToJson(this);
  }
}

abstract class _UserState implements UserState {
  factory _UserState(
      {String walletStatus,
      String walletAddress,
      String communityManagerAddress,
      String transferManagerAddress,
      String daiPointsManagerAddress,
      List<String> networks,
      List<String> mnemonic,
      @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
          BiometricAuth authType,
      String privateKey,
      String pincode,
      String accountAddress,
      String countryCode,
      String phoneNumber,
      String normalizedPhoneNumber,
      String isoCode,
      @JsonKey(ignore: true)
          List<Contact> contacts,
      Map<String, String> reverseContacts,
      List<String> syncedContacts,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String email,
      String verificationId,
      String identifier,
      bool isLoggedOut,
      bool isContactsSynced,
      bool backup,
      @JsonKey(ignore: true)
          PhoneAuthCredential credentials,
      int displayBalance,
      DateTime installedAt,
      @JsonKey(fromJson: currencyJson)
          String currency,
      num totalBalance,
      @JsonKey(ignore: true)
          dynamic signupErrorMessage,
      @JsonKey(ignore: true)
          dynamic verifyErrorMessage,
      bool depositBannerShowed,
      @JsonKey(ignore: true)
          bool isLoginRequest,
      @JsonKey(ignore: true)
          bool isVerifyRequest,
      @JsonKey(ignore: true)
          bool homeBackupDialogShowed,
      @JsonKey(ignore: true)
          bool receiveBackupDialogShowed}) = _$_UserState;

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState.fromJson;

  @override
  String get walletStatus;
  @override
  String get walletAddress;
  @override
  String get communityManagerAddress;
  @override
  String get transferManagerAddress;
  @override
  String get daiPointsManagerAddress;
  @override
  List<String> get networks;
  @override
  List<String> get mnemonic;
  @override
  @JsonKey(fromJson: authTypeFromJson, toJson: EnumToString.convertToString)
  BiometricAuth get authType;
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
  String get normalizedPhoneNumber;
  @override
  String get isoCode;
  @override
  @JsonKey(ignore: true)
  List<Contact> get contacts;
  @override
  Map<String, String> get reverseContacts;
  @override
  List<String> get syncedContacts;
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
  bool get isLoggedOut;
  @override
  bool get isContactsSynced;
  @override
  bool get backup;
  @override
  @JsonKey(ignore: true)
  PhoneAuthCredential get credentials;
  @override
  int get displayBalance;
  @override
  DateTime get installedAt;
  @override
  @JsonKey(fromJson: currencyJson)
  String get currency;
  @override
  num get totalBalance;
  @override
  @JsonKey(ignore: true)
  dynamic get signupErrorMessage;
  @override
  @JsonKey(ignore: true)
  dynamic get verifyErrorMessage;
  @override
  bool get depositBannerShowed;
  @override
  @JsonKey(ignore: true)
  bool get isLoginRequest;
  @override
  @JsonKey(ignore: true)
  bool get isVerifyRequest;
  @override
  @JsonKey(ignore: true)
  bool get homeBackupDialogShowed;
  @override
  @JsonKey(ignore: true)
  bool get receiveBackupDialogShowed;
  @override
  @JsonKey(ignore: true)
  _$UserStateCopyWith<_UserState> get copyWith;
}
