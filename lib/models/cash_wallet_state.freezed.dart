// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cash_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return _CashWalletState.fromJson(json);
}

/// @nodoc
mixin _$CashWalletState {
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens => throw _privateConstructorUsedError;
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isTransfersFetchingStarted => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetchingBalances => throw _privateConstructorUsedError;
  List<WCSessionStore> get wcSessionStores =>
      throw _privateConstructorUsedError;

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
      {@JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
      @JsonKey(ignore: true) bool isTransfersFetchingStarted,
      @JsonKey(ignore: true) bool isFetchingBalances,
      List<WCSessionStore> wcSessionStores});

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
    Object? tokens = freezed,
    Object? walletActions = freezed,
    Object? isTransfersFetchingStarted = freezed,
    Object? isFetchingBalances = freezed,
    Object? wcSessionStores = freezed,
  }) {
    return _then(_value.copyWith(
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
      isTransfersFetchingStarted: isTransfersFetchingStarted == freezed
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingBalances: isFetchingBalances == freezed
          ? _value.isFetchingBalances
          : isFetchingBalances // ignore: cast_nullable_to_non_nullable
              as bool,
      wcSessionStores: wcSessionStores == freezed
          ? _value.wcSessionStores
          : wcSessionStores // ignore: cast_nullable_to_non_nullable
              as List<WCSessionStore>,
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
abstract class _$$_CashWalletStateCopyWith<$Res>
    implements $CashWalletStateCopyWith<$Res> {
  factory _$$_CashWalletStateCopyWith(
          _$_CashWalletState value, $Res Function(_$_CashWalletState) then) =
      __$$_CashWalletStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
      @JsonKey(ignore: true) bool isTransfersFetchingStarted,
      @JsonKey(ignore: true) bool isFetchingBalances,
      List<WCSessionStore> wcSessionStores});

  @override
  $WalletActionsCopyWith<$Res>? get walletActions;
}

/// @nodoc
class __$$_CashWalletStateCopyWithImpl<$Res>
    extends _$CashWalletStateCopyWithImpl<$Res>
    implements _$$_CashWalletStateCopyWith<$Res> {
  __$$_CashWalletStateCopyWithImpl(
      _$_CashWalletState _value, $Res Function(_$_CashWalletState) _then)
      : super(_value, (v) => _then(v as _$_CashWalletState));

  @override
  _$_CashWalletState get _value => super._value as _$_CashWalletState;

  @override
  $Res call({
    Object? tokens = freezed,
    Object? walletActions = freezed,
    Object? isTransfersFetchingStarted = freezed,
    Object? isFetchingBalances = freezed,
    Object? wcSessionStores = freezed,
  }) {
    return _then(_$_CashWalletState(
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
      isTransfersFetchingStarted: isTransfersFetchingStarted == freezed
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingBalances: isFetchingBalances == freezed
          ? _value.isFetchingBalances
          : isFetchingBalances // ignore: cast_nullable_to_non_nullable
              as bool,
      wcSessionStores: wcSessionStores == freezed
          ? _value.wcSessionStores
          : wcSessionStores // ignore: cast_nullable_to_non_nullable
              as List<WCSessionStore>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CashWalletState extends _CashWalletState {
  _$_CashWalletState(
      {@JsonKey(fromJson: tokensFromJson) this.tokens = const {},
      @JsonKey(fromJson: walletActionsFromJson) this.walletActions,
      @JsonKey(ignore: true) this.isTransfersFetchingStarted = false,
      @JsonKey(ignore: true) this.isFetchingBalances = false,
      this.wcSessionStores = const []})
      : super._();

  factory _$_CashWalletState.fromJson(Map<String, dynamic> json) =>
      _$$_CashWalletStateFromJson(json);

  @override
  @JsonKey(fromJson: tokensFromJson)
  final Map<String, Token> tokens;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  final WalletActions? walletActions;
  @override
  @JsonKey(ignore: true)
  final bool isTransfersFetchingStarted;
  @override
  @JsonKey(ignore: true)
  final bool isFetchingBalances;
  @override
  @JsonKey()
  final List<WCSessionStore> wcSessionStores;

  @override
  String toString() {
    return 'CashWalletState(tokens: $tokens, walletActions: $walletActions, isTransfersFetchingStarted: $isTransfersFetchingStarted, isFetchingBalances: $isFetchingBalances, wcSessionStores: $wcSessionStores)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CashWalletState &&
            const DeepCollectionEquality().equals(other.tokens, tokens) &&
            const DeepCollectionEquality()
                .equals(other.walletActions, walletActions) &&
            const DeepCollectionEquality().equals(
                other.isTransfersFetchingStarted, isTransfersFetchingStarted) &&
            const DeepCollectionEquality()
                .equals(other.isFetchingBalances, isFetchingBalances) &&
            const DeepCollectionEquality()
                .equals(other.wcSessionStores, wcSessionStores));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tokens),
      const DeepCollectionEquality().hash(walletActions),
      const DeepCollectionEquality().hash(isTransfersFetchingStarted),
      const DeepCollectionEquality().hash(isFetchingBalances),
      const DeepCollectionEquality().hash(wcSessionStores));

  @JsonKey(ignore: true)
  @override
  _$$_CashWalletStateCopyWith<_$_CashWalletState> get copyWith =>
      __$$_CashWalletStateCopyWithImpl<_$_CashWalletState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CashWalletStateToJson(
      this,
    );
  }
}

abstract class _CashWalletState extends CashWalletState {
  factory _CashWalletState(
      {@JsonKey(fromJson: tokensFromJson)
          final Map<String, Token> tokens,
      @JsonKey(fromJson: walletActionsFromJson)
          final WalletActions? walletActions,
      @JsonKey(ignore: true)
          final bool isTransfersFetchingStarted,
      @JsonKey(ignore: true)
          final bool isFetchingBalances,
      final List<WCSessionStore> wcSessionStores}) = _$_CashWalletState;
  _CashWalletState._() : super._();

  factory _CashWalletState.fromJson(Map<String, dynamic> json) =
      _$_CashWalletState.fromJson;

  @override
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions;
  @override
  @JsonKey(ignore: true)
  bool get isTransfersFetchingStarted;
  @override
  @JsonKey(ignore: true)
  bool get isFetchingBalances;
  @override
  List<WCSessionStore> get wcSessionStores;
  @override
  @JsonKey(ignore: true)
  _$$_CashWalletStateCopyWith<_$_CashWalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
