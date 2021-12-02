// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cash_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return _CashWalletState.fromJson(json);
}

/// @nodoc
class _$CashWalletStateTearOff {
  const _$CashWalletStateTearOff();

  _CashWalletState call(
      {String communityAddress = '',
      bool isDepositBanner = true,
      @JsonKey(fromJson: tokensFromJson)
          Map<String, Token> tokens = const {},
      @JsonKey(fromJson: communitiesFromJson)
          Map<String, Community> communities = const {},
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions? walletActions,
      @JsonKey(ignore: true)
          bool isCommunityLoading = false,
      @JsonKey(ignore: true)
          bool isCommunityFetched = false,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted = false,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched = false,
      @JsonKey(ignore: true)
          bool isFetchingBalances = false}) {
    return _CashWalletState(
      communityAddress: communityAddress,
      isDepositBanner: isDepositBanner,
      tokens: tokens,
      communities: communities,
      walletActions: walletActions,
      isCommunityLoading: isCommunityLoading,
      isCommunityFetched: isCommunityFetched,
      isTransfersFetchingStarted: isTransfersFetchingStarted,
      isCommunityBusinessesFetched: isCommunityBusinessesFetched,
      isFetchingBalances: isFetchingBalances,
    );
  }

  CashWalletState fromJson(Map<String, Object?> json) {
    return CashWalletState.fromJson(json);
  }
}

/// @nodoc
const $CashWalletState = _$CashWalletStateTearOff();

/// @nodoc
mixin _$CashWalletState {
  String get communityAddress => throw _privateConstructorUsedError;
  bool get isDepositBanner => throw _privateConstructorUsedError;
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens => throw _privateConstructorUsedError;
  @JsonKey(fromJson: communitiesFromJson)
  Map<String, Community> get communities => throw _privateConstructorUsedError;
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isCommunityLoading => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isCommunityFetched => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isTransfersFetchingStarted => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isCommunityBusinessesFetched => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetchingBalances => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashWalletStateCopyWith<CashWalletState> get copyWith =>
      throw _privateConstructorUsedError;
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
          WalletActions? walletActions,
      @JsonKey(ignore: true)
          bool isCommunityLoading,
      @JsonKey(ignore: true)
          bool isCommunityFetched,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched,
      @JsonKey(ignore: true)
          bool isFetchingBalances});

  $WalletActionsCopyWith<$Res>? get walletActions;
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
    Object? communityAddress = freezed,
    Object? isDepositBanner = freezed,
    Object? tokens = freezed,
    Object? communities = freezed,
    Object? walletActions = freezed,
    Object? isCommunityLoading = freezed,
    Object? isCommunityFetched = freezed,
    Object? isTransfersFetchingStarted = freezed,
    Object? isCommunityBusinessesFetched = freezed,
    Object? isFetchingBalances = freezed,
  }) {
    return _then(_value.copyWith(
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isDepositBanner: isDepositBanner == freezed
          ? _value.isDepositBanner
          : isDepositBanner // ignore: cast_nullable_to_non_nullable
              as bool,
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      communities: communities == freezed
          ? _value.communities
          : communities // ignore: cast_nullable_to_non_nullable
              as Map<String, Community>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
      isCommunityLoading: isCommunityLoading == freezed
          ? _value.isCommunityLoading
          : isCommunityLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunityFetched: isCommunityFetched == freezed
          ? _value.isCommunityFetched
          : isCommunityFetched // ignore: cast_nullable_to_non_nullable
              as bool,
      isTransfersFetchingStarted: isTransfersFetchingStarted == freezed
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunityBusinessesFetched: isCommunityBusinessesFetched == freezed
          ? _value.isCommunityBusinessesFetched
          : isCommunityBusinessesFetched // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingBalances: isFetchingBalances == freezed
          ? _value.isFetchingBalances
          : isFetchingBalances // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $WalletActionsCopyWith<$Res>? get walletActions {
    if (_value.walletActions == null) {
      return null;
    }

    return $WalletActionsCopyWith<$Res>(_value.walletActions!, (value) {
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
          WalletActions? walletActions,
      @JsonKey(ignore: true)
          bool isCommunityLoading,
      @JsonKey(ignore: true)
          bool isCommunityFetched,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched,
      @JsonKey(ignore: true)
          bool isFetchingBalances});

  @override
  $WalletActionsCopyWith<$Res>? get walletActions;
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
    Object? communityAddress = freezed,
    Object? isDepositBanner = freezed,
    Object? tokens = freezed,
    Object? communities = freezed,
    Object? walletActions = freezed,
    Object? isCommunityLoading = freezed,
    Object? isCommunityFetched = freezed,
    Object? isTransfersFetchingStarted = freezed,
    Object? isCommunityBusinessesFetched = freezed,
    Object? isFetchingBalances = freezed,
  }) {
    return _then(_CashWalletState(
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isDepositBanner: isDepositBanner == freezed
          ? _value.isDepositBanner
          : isDepositBanner // ignore: cast_nullable_to_non_nullable
              as bool,
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      communities: communities == freezed
          ? _value.communities
          : communities // ignore: cast_nullable_to_non_nullable
              as Map<String, Community>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
      isCommunityLoading: isCommunityLoading == freezed
          ? _value.isCommunityLoading
          : isCommunityLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunityFetched: isCommunityFetched == freezed
          ? _value.isCommunityFetched
          : isCommunityFetched // ignore: cast_nullable_to_non_nullable
              as bool,
      isTransfersFetchingStarted: isTransfersFetchingStarted == freezed
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunityBusinessesFetched: isCommunityBusinessesFetched == freezed
          ? _value.isCommunityBusinessesFetched
          : isCommunityBusinessesFetched // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingBalances: isFetchingBalances == freezed
          ? _value.isFetchingBalances
          : isFetchingBalances // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_CashWalletState extends _CashWalletState with DiagnosticableTreeMixin {
  _$_CashWalletState(
      {this.communityAddress = '',
      this.isDepositBanner = true,
      @JsonKey(fromJson: tokensFromJson) this.tokens = const {},
      @JsonKey(fromJson: communitiesFromJson) this.communities = const {},
      @JsonKey(fromJson: walletActionsFromJson) this.walletActions,
      @JsonKey(ignore: true) this.isCommunityLoading = false,
      @JsonKey(ignore: true) this.isCommunityFetched = false,
      @JsonKey(ignore: true) this.isTransfersFetchingStarted = false,
      @JsonKey(ignore: true) this.isCommunityBusinessesFetched = false,
      @JsonKey(ignore: true) this.isFetchingBalances = false})
      : super._();

  factory _$_CashWalletState.fromJson(Map<String, dynamic> json) =>
      _$$_CashWalletStateFromJson(json);

  @JsonKey(defaultValue: '')
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
  final WalletActions? walletActions;
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
  final bool isCommunityBusinessesFetched;
  @override
  @JsonKey(ignore: true)
  final bool isFetchingBalances;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CashWalletState(communityAddress: $communityAddress, isDepositBanner: $isDepositBanner, tokens: $tokens, communities: $communities, walletActions: $walletActions, isCommunityLoading: $isCommunityLoading, isCommunityFetched: $isCommunityFetched, isTransfersFetchingStarted: $isTransfersFetchingStarted, isCommunityBusinessesFetched: $isCommunityBusinessesFetched, isFetchingBalances: $isFetchingBalances)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CashWalletState'))
      ..add(DiagnosticsProperty('communityAddress', communityAddress))
      ..add(DiagnosticsProperty('isDepositBanner', isDepositBanner))
      ..add(DiagnosticsProperty('tokens', tokens))
      ..add(DiagnosticsProperty('communities', communities))
      ..add(DiagnosticsProperty('walletActions', walletActions))
      ..add(DiagnosticsProperty('isCommunityLoading', isCommunityLoading))
      ..add(DiagnosticsProperty('isCommunityFetched', isCommunityFetched))
      ..add(DiagnosticsProperty(
          'isTransfersFetchingStarted', isTransfersFetchingStarted))
      ..add(DiagnosticsProperty(
          'isCommunityBusinessesFetched', isCommunityBusinessesFetched))
      ..add(DiagnosticsProperty('isFetchingBalances', isFetchingBalances));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CashWalletState &&
            (identical(other.communityAddress, communityAddress) ||
                other.communityAddress == communityAddress) &&
            (identical(other.isDepositBanner, isDepositBanner) ||
                other.isDepositBanner == isDepositBanner) &&
            const DeepCollectionEquality().equals(other.tokens, tokens) &&
            const DeepCollectionEquality()
                .equals(other.communities, communities) &&
            (identical(other.walletActions, walletActions) ||
                other.walletActions == walletActions) &&
            (identical(other.isCommunityLoading, isCommunityLoading) ||
                other.isCommunityLoading == isCommunityLoading) &&
            (identical(other.isCommunityFetched, isCommunityFetched) ||
                other.isCommunityFetched == isCommunityFetched) &&
            (identical(other.isTransfersFetchingStarted,
                    isTransfersFetchingStarted) ||
                other.isTransfersFetchingStarted ==
                    isTransfersFetchingStarted) &&
            (identical(other.isCommunityBusinessesFetched,
                    isCommunityBusinessesFetched) ||
                other.isCommunityBusinessesFetched ==
                    isCommunityBusinessesFetched) &&
            (identical(other.isFetchingBalances, isFetchingBalances) ||
                other.isFetchingBalances == isFetchingBalances));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      communityAddress,
      isDepositBanner,
      const DeepCollectionEquality().hash(tokens),
      const DeepCollectionEquality().hash(communities),
      walletActions,
      isCommunityLoading,
      isCommunityFetched,
      isTransfersFetchingStarted,
      isCommunityBusinessesFetched,
      isFetchingBalances);

  @JsonKey(ignore: true)
  @override
  _$CashWalletStateCopyWith<_CashWalletState> get copyWith =>
      __$CashWalletStateCopyWithImpl<_CashWalletState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CashWalletStateToJson(this);
  }
}

abstract class _CashWalletState extends CashWalletState {
  factory _CashWalletState(
      {String communityAddress,
      bool isDepositBanner,
      @JsonKey(fromJson: tokensFromJson)
          Map<String, Token> tokens,
      @JsonKey(fromJson: communitiesFromJson)
          Map<String, Community> communities,
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions? walletActions,
      @JsonKey(ignore: true)
          bool isCommunityLoading,
      @JsonKey(ignore: true)
          bool isCommunityFetched,
      @JsonKey(ignore: true)
          bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          bool isCommunityBusinessesFetched,
      @JsonKey(ignore: true)
          bool isFetchingBalances}) = _$_CashWalletState;
  _CashWalletState._() : super._();

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
  WalletActions? get walletActions;
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
  bool get isCommunityBusinessesFetched;
  @override
  @JsonKey(ignore: true)
  bool get isFetchingBalances;
  @override
  @JsonKey(ignore: true)
  _$CashWalletStateCopyWith<_CashWalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
