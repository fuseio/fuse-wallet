// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'cash_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return _CashWalletState.fromJson(json);
}

/// @nodoc
class _$CashWalletStateTearOff {
  const _$CashWalletStateTearOff();

// ignore: unused_element
  _CashWalletState call(
      {String communityAddress,
      bool isDepositBanner = true,
      @JsonKey(fromJson: tokensFromJson)
          Map<String, Token> tokens = const {},
      @JsonKey(fromJson: communitiesFromJson)
          Map<String, Community> communities = const {},
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions walletActions,
      @JsonKey(ignore: true)
          String branchAddress,
      @JsonKey(ignore: true)
          bool isCommunityLoading = false,
      @JsonKey(ignore: true)
          bool isCommunityFetched = false,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted = false,
      @JsonKey(ignore: true)
          bool isListeningToBranch = false,
      @JsonKey(ignore: true)
          bool isBranchDataReceived = false,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched = false,
      @JsonKey(ignore: true)
          bool isJobProcessingStarted = false,
      @JsonKey(ignore: true)
          bool isFetchingBalances}) {
    return _CashWalletState(
      communityAddress: communityAddress,
      isDepositBanner: isDepositBanner,
      tokens: tokens,
      communities: communities,
      walletActions: walletActions,
      branchAddress: branchAddress,
      isCommunityLoading: isCommunityLoading,
      isCommunityFetched: isCommunityFetched,
      isTransfersFetchingStarted: isTransfersFetchingStarted,
      isListeningToBranch: isListeningToBranch,
      isBranchDataReceived: isBranchDataReceived,
      isCommunityBusinessesFetched: isCommunityBusinessesFetched,
      isJobProcessingStarted: isJobProcessingStarted,
      isFetchingBalances: isFetchingBalances,
    );
  }

// ignore: unused_element
  CashWalletState fromJson(Map<String, Object> json) {
    return CashWalletState.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CashWalletState = _$CashWalletStateTearOff();

/// @nodoc
mixin _$CashWalletState {
  String get communityAddress;
  bool get isDepositBanner;
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens;
  @JsonKey(fromJson: communitiesFromJson)
  Map<String, Community> get communities;
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions get walletActions;
  @JsonKey(ignore: true)
  String get branchAddress;
  @JsonKey(ignore: true)
  bool get isCommunityLoading;
  @JsonKey(ignore: true)
  bool get isCommunityFetched;
  @JsonKey(ignore: true)
  bool get isTransfersFetchingStarted;
  @JsonKey(ignore: true)
  bool get isListeningToBranch;
  @JsonKey(ignore: true)
  bool get isBranchDataReceived;
  @JsonKey(ignore: true)
  bool get isCommunityBusinessesFetched;
  @JsonKey(ignore: true)
  bool get isJobProcessingStarted;
  @JsonKey(ignore: true)
  bool get isFetchingBalances;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CashWalletStateCopyWith<CashWalletState> get copyWith;
}

/// @nodoc
abstract class $CashWalletStateCopyWith<$Res> {
  factory $CashWalletStateCopyWith(
          CashWalletState value, $Res Function(CashWalletState) then) =
      _$CashWalletStateCopyWithImpl<$Res>;
  $Res call(
      {String communityAddress,
      bool isDepositBanner,
      @JsonKey(fromJson: tokensFromJson)
          Map<String, Token> tokens,
      @JsonKey(fromJson: communitiesFromJson)
          Map<String, Community> communities,
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions walletActions,
      @JsonKey(ignore: true)
          String branchAddress,
      @JsonKey(ignore: true)
          bool isCommunityLoading,
      @JsonKey(ignore: true)
          bool isCommunityFetched,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          bool isListeningToBranch,
      @JsonKey(ignore: true)
          bool isBranchDataReceived,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched,
      @JsonKey(ignore: true)
          bool isJobProcessingStarted,
      @JsonKey(ignore: true)
          bool isFetchingBalances});

  $WalletActionsCopyWith<$Res> get walletActions;
}

/// @nodoc
class _$CashWalletStateCopyWithImpl<$Res>
    implements $CashWalletStateCopyWith<$Res> {
  _$CashWalletStateCopyWithImpl(this._value, this._then);

  final CashWalletState _value;
  // ignore: unused_field
  final $Res Function(CashWalletState) _then;

  @override
  $Res call({
    Object communityAddress = freezed,
    Object isDepositBanner = freezed,
    Object tokens = freezed,
    Object communities = freezed,
    Object walletActions = freezed,
    Object branchAddress = freezed,
    Object isCommunityLoading = freezed,
    Object isCommunityFetched = freezed,
    Object isTransfersFetchingStarted = freezed,
    Object isListeningToBranch = freezed,
    Object isBranchDataReceived = freezed,
    Object isCommunityBusinessesFetched = freezed,
    Object isJobProcessingStarted = freezed,
    Object isFetchingBalances = freezed,
  }) {
    return _then(_value.copyWith(
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress as String,
      isDepositBanner: isDepositBanner == freezed
          ? _value.isDepositBanner
          : isDepositBanner as bool,
      tokens: tokens == freezed ? _value.tokens : tokens as Map<String, Token>,
      communities: communities == freezed
          ? _value.communities
          : communities as Map<String, Community>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions as WalletActions,
      branchAddress: branchAddress == freezed
          ? _value.branchAddress
          : branchAddress as String,
      isCommunityLoading: isCommunityLoading == freezed
          ? _value.isCommunityLoading
          : isCommunityLoading as bool,
      isCommunityFetched: isCommunityFetched == freezed
          ? _value.isCommunityFetched
          : isCommunityFetched as bool,
      isTransfersFetchingStarted: isTransfersFetchingStarted == freezed
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted as bool,
      isListeningToBranch: isListeningToBranch == freezed
          ? _value.isListeningToBranch
          : isListeningToBranch as bool,
      isBranchDataReceived: isBranchDataReceived == freezed
          ? _value.isBranchDataReceived
          : isBranchDataReceived as bool,
      isCommunityBusinessesFetched: isCommunityBusinessesFetched == freezed
          ? _value.isCommunityBusinessesFetched
          : isCommunityBusinessesFetched as bool,
      isJobProcessingStarted: isJobProcessingStarted == freezed
          ? _value.isJobProcessingStarted
          : isJobProcessingStarted as bool,
      isFetchingBalances: isFetchingBalances == freezed
          ? _value.isFetchingBalances
          : isFetchingBalances as bool,
    ));
  }

  @override
  $WalletActionsCopyWith<$Res> get walletActions {
    if (_value.walletActions == null) {
      return null;
    }
    return $WalletActionsCopyWith<$Res>(_value.walletActions, (value) {
      return _then(_value.copyWith(walletActions: value));
    });
  }
}

/// @nodoc
abstract class _$CashWalletStateCopyWith<$Res>
    implements $CashWalletStateCopyWith<$Res> {
  factory _$CashWalletStateCopyWith(
          _CashWalletState value, $Res Function(_CashWalletState) then) =
      __$CashWalletStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String communityAddress,
      bool isDepositBanner,
      @JsonKey(fromJson: tokensFromJson)
          Map<String, Token> tokens,
      @JsonKey(fromJson: communitiesFromJson)
          Map<String, Community> communities,
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions walletActions,
      @JsonKey(ignore: true)
          String branchAddress,
      @JsonKey(ignore: true)
          bool isCommunityLoading,
      @JsonKey(ignore: true)
          bool isCommunityFetched,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          bool isListeningToBranch,
      @JsonKey(ignore: true)
          bool isBranchDataReceived,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched,
      @JsonKey(ignore: true)
          bool isJobProcessingStarted,
      @JsonKey(ignore: true)
          bool isFetchingBalances});

  @override
  $WalletActionsCopyWith<$Res> get walletActions;
}

/// @nodoc
class __$CashWalletStateCopyWithImpl<$Res>
    extends _$CashWalletStateCopyWithImpl<$Res>
    implements _$CashWalletStateCopyWith<$Res> {
  __$CashWalletStateCopyWithImpl(
      _CashWalletState _value, $Res Function(_CashWalletState) _then)
      : super(_value, (v) => _then(v as _CashWalletState));

  @override
  _CashWalletState get _value => super._value as _CashWalletState;

  @override
  $Res call({
    Object communityAddress = freezed,
    Object isDepositBanner = freezed,
    Object tokens = freezed,
    Object communities = freezed,
    Object walletActions = freezed,
    Object branchAddress = freezed,
    Object isCommunityLoading = freezed,
    Object isCommunityFetched = freezed,
    Object isTransfersFetchingStarted = freezed,
    Object isListeningToBranch = freezed,
    Object isBranchDataReceived = freezed,
    Object isCommunityBusinessesFetched = freezed,
    Object isJobProcessingStarted = freezed,
    Object isFetchingBalances = freezed,
  }) {
    return _then(_CashWalletState(
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress as String,
      isDepositBanner: isDepositBanner == freezed
          ? _value.isDepositBanner
          : isDepositBanner as bool,
      tokens: tokens == freezed ? _value.tokens : tokens as Map<String, Token>,
      communities: communities == freezed
          ? _value.communities
          : communities as Map<String, Community>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions as WalletActions,
      branchAddress: branchAddress == freezed
          ? _value.branchAddress
          : branchAddress as String,
      isCommunityLoading: isCommunityLoading == freezed
          ? _value.isCommunityLoading
          : isCommunityLoading as bool,
      isCommunityFetched: isCommunityFetched == freezed
          ? _value.isCommunityFetched
          : isCommunityFetched as bool,
      isTransfersFetchingStarted: isTransfersFetchingStarted == freezed
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted as bool,
      isListeningToBranch: isListeningToBranch == freezed
          ? _value.isListeningToBranch
          : isListeningToBranch as bool,
      isBranchDataReceived: isBranchDataReceived == freezed
          ? _value.isBranchDataReceived
          : isBranchDataReceived as bool,
      isCommunityBusinessesFetched: isCommunityBusinessesFetched == freezed
          ? _value.isCommunityBusinessesFetched
          : isCommunityBusinessesFetched as bool,
      isJobProcessingStarted: isJobProcessingStarted == freezed
          ? _value.isJobProcessingStarted
          : isJobProcessingStarted as bool,
      isFetchingBalances: isFetchingBalances == freezed
          ? _value.isFetchingBalances
          : isFetchingBalances as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CashWalletState extends _CashWalletState {
  _$_CashWalletState(
      {this.communityAddress,
      this.isDepositBanner = true,
      @JsonKey(fromJson: tokensFromJson) this.tokens = const {},
      @JsonKey(fromJson: communitiesFromJson) this.communities = const {},
      @JsonKey(fromJson: walletActionsFromJson) this.walletActions,
      @JsonKey(ignore: true) this.branchAddress,
      @JsonKey(ignore: true) this.isCommunityLoading = false,
      @JsonKey(ignore: true) this.isCommunityFetched = false,
      @JsonKey(ignore: true) this.isTransfersFetchingStarted = false,
      @JsonKey(ignore: true) this.isListeningToBranch = false,
      @JsonKey(ignore: true) this.isBranchDataReceived = false,
      @JsonKey(ignore: true) this.isCommunityBusinessesFetched = false,
      @JsonKey(ignore: true) this.isJobProcessingStarted = false,
      @JsonKey(ignore: true) this.isFetchingBalances})
      : assert(isDepositBanner != null),
        assert(tokens != null),
        assert(communities != null),
        assert(isCommunityLoading != null),
        assert(isCommunityFetched != null),
        assert(isTransfersFetchingStarted != null),
        assert(isListeningToBranch != null),
        assert(isBranchDataReceived != null),
        assert(isCommunityBusinessesFetched != null),
        assert(isJobProcessingStarted != null),
        super._();

  factory _$_CashWalletState.fromJson(Map<String, dynamic> json) =>
      _$_$_CashWalletStateFromJson(json);

  @override
  final String communityAddress;
  @JsonKey(defaultValue: true)
  @override
  final bool isDepositBanner;
  @override
  @JsonKey(fromJson: tokensFromJson)
  final Map<String, Token> tokens;
  @override
  @JsonKey(fromJson: communitiesFromJson)
  final Map<String, Community> communities;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  final WalletActions walletActions;
  @override
  @JsonKey(ignore: true)
  final String branchAddress;
  @override
  @JsonKey(ignore: true)
  final bool isCommunityLoading;
  @override
  @JsonKey(ignore: true)
  final bool isCommunityFetched;
  @override
  @JsonKey(ignore: true)
  final bool isTransfersFetchingStarted;
  @override
  @JsonKey(ignore: true)
  final bool isListeningToBranch;
  @override
  @JsonKey(ignore: true)
  final bool isBranchDataReceived;
  @override
  @JsonKey(ignore: true)
  final bool isCommunityBusinessesFetched;
  @override
  @JsonKey(ignore: true)
  final bool isJobProcessingStarted;
  @override
  @JsonKey(ignore: true)
  final bool isFetchingBalances;

  @override
  String toString() {
    return 'CashWalletState(communityAddress: $communityAddress, isDepositBanner: $isDepositBanner, tokens: $tokens, communities: $communities, walletActions: $walletActions, branchAddress: $branchAddress, isCommunityLoading: $isCommunityLoading, isCommunityFetched: $isCommunityFetched, isTransfersFetchingStarted: $isTransfersFetchingStarted, isListeningToBranch: $isListeningToBranch, isBranchDataReceived: $isBranchDataReceived, isCommunityBusinessesFetched: $isCommunityBusinessesFetched, isJobProcessingStarted: $isJobProcessingStarted, isFetchingBalances: $isFetchingBalances)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CashWalletState &&
            (identical(other.communityAddress, communityAddress) ||
                const DeepCollectionEquality()
                    .equals(other.communityAddress, communityAddress)) &&
            (identical(other.isDepositBanner, isDepositBanner) ||
                const DeepCollectionEquality()
                    .equals(other.isDepositBanner, isDepositBanner)) &&
            (identical(other.tokens, tokens) ||
                const DeepCollectionEquality().equals(other.tokens, tokens)) &&
            (identical(other.communities, communities) ||
                const DeepCollectionEquality()
                    .equals(other.communities, communities)) &&
            (identical(other.walletActions, walletActions) ||
                const DeepCollectionEquality()
                    .equals(other.walletActions, walletActions)) &&
            (identical(other.branchAddress, branchAddress) ||
                const DeepCollectionEquality()
                    .equals(other.branchAddress, branchAddress)) &&
            (identical(other.isCommunityLoading, isCommunityLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isCommunityLoading, isCommunityLoading)) &&
            (identical(other.isCommunityFetched, isCommunityFetched) ||
                const DeepCollectionEquality()
                    .equals(other.isCommunityFetched, isCommunityFetched)) &&
            (identical(other.isTransfersFetchingStarted,
                    isTransfersFetchingStarted) ||
                const DeepCollectionEquality().equals(
                    other.isTransfersFetchingStarted,
                    isTransfersFetchingStarted)) &&
            (identical(other.isListeningToBranch, isListeningToBranch) ||
                const DeepCollectionEquality()
                    .equals(other.isListeningToBranch, isListeningToBranch)) &&
            (identical(other.isBranchDataReceived, isBranchDataReceived) ||
                const DeepCollectionEquality().equals(
                    other.isBranchDataReceived, isBranchDataReceived)) &&
            (identical(other.isCommunityBusinessesFetched,
                    isCommunityBusinessesFetched) ||
                const DeepCollectionEquality().equals(
                    other.isCommunityBusinessesFetched,
                    isCommunityBusinessesFetched)) &&
            (identical(other.isJobProcessingStarted, isJobProcessingStarted) ||
                const DeepCollectionEquality().equals(
                    other.isJobProcessingStarted, isJobProcessingStarted)) &&
            (identical(other.isFetchingBalances, isFetchingBalances) ||
                const DeepCollectionEquality()
                    .equals(other.isFetchingBalances, isFetchingBalances)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(communityAddress) ^
      const DeepCollectionEquality().hash(isDepositBanner) ^
      const DeepCollectionEquality().hash(tokens) ^
      const DeepCollectionEquality().hash(communities) ^
      const DeepCollectionEquality().hash(walletActions) ^
      const DeepCollectionEquality().hash(branchAddress) ^
      const DeepCollectionEquality().hash(isCommunityLoading) ^
      const DeepCollectionEquality().hash(isCommunityFetched) ^
      const DeepCollectionEquality().hash(isTransfersFetchingStarted) ^
      const DeepCollectionEquality().hash(isListeningToBranch) ^
      const DeepCollectionEquality().hash(isBranchDataReceived) ^
      const DeepCollectionEquality().hash(isCommunityBusinessesFetched) ^
      const DeepCollectionEquality().hash(isJobProcessingStarted) ^
      const DeepCollectionEquality().hash(isFetchingBalances);

  @JsonKey(ignore: true)
  @override
  _$CashWalletStateCopyWith<_CashWalletState> get copyWith =>
      __$CashWalletStateCopyWithImpl<_CashWalletState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CashWalletStateToJson(this);
  }
}

abstract class _CashWalletState extends CashWalletState {
  _CashWalletState._() : super._();
  factory _CashWalletState(
      {String communityAddress,
      bool isDepositBanner,
      @JsonKey(fromJson: tokensFromJson)
          Map<String, Token> tokens,
      @JsonKey(fromJson: communitiesFromJson)
          Map<String, Community> communities,
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions walletActions,
      @JsonKey(ignore: true)
          String branchAddress,
      @JsonKey(ignore: true)
          bool isCommunityLoading,
      @JsonKey(ignore: true)
          bool isCommunityFetched,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          bool isListeningToBranch,
      @JsonKey(ignore: true)
          bool isBranchDataReceived,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched,
      @JsonKey(ignore: true)
          bool isJobProcessingStarted,
      @JsonKey(ignore: true)
          bool isFetchingBalances}) = _$_CashWalletState;

  factory _CashWalletState.fromJson(Map<String, dynamic> json) =
      _$_CashWalletState.fromJson;

  @override
  String get communityAddress;
  @override
  bool get isDepositBanner;
  @override
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens;
  @override
  @JsonKey(fromJson: communitiesFromJson)
  Map<String, Community> get communities;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions get walletActions;
  @override
  @JsonKey(ignore: true)
  String get branchAddress;
  @override
  @JsonKey(ignore: true)
  bool get isCommunityLoading;
  @override
  @JsonKey(ignore: true)
  bool get isCommunityFetched;
  @override
  @JsonKey(ignore: true)
  bool get isTransfersFetchingStarted;
  @override
  @JsonKey(ignore: true)
  bool get isListeningToBranch;
  @override
  @JsonKey(ignore: true)
  bool get isBranchDataReceived;
  @override
  @JsonKey(ignore: true)
  bool get isCommunityBusinessesFetched;
  @override
  @JsonKey(ignore: true)
  bool get isJobProcessingStarted;
  @override
  @JsonKey(ignore: true)
  bool get isFetchingBalances;
  @override
  @JsonKey(ignore: true)
  _$CashWalletStateCopyWith<_CashWalletState> get copyWith;
}
