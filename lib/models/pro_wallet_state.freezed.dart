// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'pro_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProWalletState _$ProWalletStateFromJson(Map<String, dynamic> json) {
  return _ProWalletState.fromJson(json);
}

/// @nodoc
class _$ProWalletStateTearOff {
  const _$ProWalletStateTearOff();

  _ProWalletState call(
      {@JsonKey(fromJson: balanceFromJson)
          BigInt etherBalance = null,
      @JsonKey(fromJson: erc20TokensFromJson)
          Map<String, Token>? erc20Tokens = const {},
      @JsonKey(ignore: true)
          bool isFetchTransferEvents = false,
      @JsonKey(ignore: true)
          bool isListenToTransferEvents = false,
      @JsonKey(ignore: true)
          bool isProcessingTokensJobs = false,
      @JsonKey(ignore: true)
          bool isFetchTokensBalances = false,
      @JsonKey(ignore: true)
          bool isProcessingSwapActions = false,
      @JsonKey(ignore: true)
          bool isFetchTokensLatestPrice = false,
      @JsonKey(ignore: true)
          bool isFetchNewTokens = false}) {
    return _ProWalletState(
      etherBalance: etherBalance,
      erc20Tokens: erc20Tokens,
      isFetchTransferEvents: isFetchTransferEvents,
      isListenToTransferEvents: isListenToTransferEvents,
      isProcessingTokensJobs: isProcessingTokensJobs,
      isFetchTokensBalances: isFetchTokensBalances,
      isProcessingSwapActions: isProcessingSwapActions,
      isFetchTokensLatestPrice: isFetchTokensLatestPrice,
      isFetchNewTokens: isFetchNewTokens,
    );
  }

  ProWalletState fromJson(Map<String, Object> json) {
    return ProWalletState.fromJson(json);
  }
}

/// @nodoc
const $ProWalletState = _$ProWalletStateTearOff();

/// @nodoc
mixin _$ProWalletState {
  @JsonKey(fromJson: balanceFromJson)
  BigInt get etherBalance => throw _privateConstructorUsedError;
  @JsonKey(fromJson: erc20TokensFromJson)
  Map<String, Token>? get erc20Tokens => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetchTransferEvents => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isListenToTransferEvents => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isProcessingTokensJobs => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetchTokensBalances => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isProcessingSwapActions => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetchTokensLatestPrice => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetchNewTokens => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProWalletStateCopyWith<ProWalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProWalletStateCopyWith<$Res> {
  factory $ProWalletStateCopyWith(
          ProWalletState value, $Res Function(ProWalletState) then) =
      _$ProWalletStateCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: balanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token>? erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLatestPrice,
      @JsonKey(ignore: true) bool isFetchNewTokens});
}

/// @nodoc
class _$ProWalletStateCopyWithImpl<$Res>
    implements $ProWalletStateCopyWith<$Res> {
  _$ProWalletStateCopyWithImpl(this._value, this._then);

  final ProWalletState _value;
  // ignore: unused_field
  final $Res Function(ProWalletState) _then;

  @override
  $Res call({
    Object? etherBalance = freezed,
    Object? erc20Tokens = freezed,
    Object? isFetchTransferEvents = freezed,
    Object? isListenToTransferEvents = freezed,
    Object? isProcessingTokensJobs = freezed,
    Object? isFetchTokensBalances = freezed,
    Object? isProcessingSwapActions = freezed,
    Object? isFetchTokensLatestPrice = freezed,
    Object? isFetchNewTokens = freezed,
  }) {
    return _then(_value.copyWith(
      etherBalance: etherBalance == freezed
          ? _value.etherBalance
          : etherBalance // ignore: cast_nullable_to_non_nullable
              as BigInt,
      erc20Tokens: erc20Tokens == freezed
          ? _value.erc20Tokens
          : erc20Tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>?,
      isFetchTransferEvents: isFetchTransferEvents == freezed
          ? _value.isFetchTransferEvents
          : isFetchTransferEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      isListenToTransferEvents: isListenToTransferEvents == freezed
          ? _value.isListenToTransferEvents
          : isListenToTransferEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingTokensJobs: isProcessingTokensJobs == freezed
          ? _value.isProcessingTokensJobs
          : isProcessingTokensJobs // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchTokensBalances: isFetchTokensBalances == freezed
          ? _value.isFetchTokensBalances
          : isFetchTokensBalances // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingSwapActions: isProcessingSwapActions == freezed
          ? _value.isProcessingSwapActions
          : isProcessingSwapActions // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchTokensLatestPrice: isFetchTokensLatestPrice == freezed
          ? _value.isFetchTokensLatestPrice
          : isFetchTokensLatestPrice // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchNewTokens: isFetchNewTokens == freezed
          ? _value.isFetchNewTokens
          : isFetchNewTokens // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ProWalletStateCopyWith<$Res>
    implements $ProWalletStateCopyWith<$Res> {
  factory _$ProWalletStateCopyWith(
          _ProWalletState value, $Res Function(_ProWalletState) then) =
      __$ProWalletStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(fromJson: balanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token>? erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLatestPrice,
      @JsonKey(ignore: true) bool isFetchNewTokens});
}

/// @nodoc
class __$ProWalletStateCopyWithImpl<$Res>
    extends _$ProWalletStateCopyWithImpl<$Res>
    implements _$ProWalletStateCopyWith<$Res> {
  __$ProWalletStateCopyWithImpl(
      _ProWalletState _value, $Res Function(_ProWalletState) _then)
      : super(_value, (v) => _then(v as _ProWalletState));

  @override
  _ProWalletState get _value => super._value as _ProWalletState;

  @override
  $Res call({
    Object? etherBalance = freezed,
    Object? erc20Tokens = freezed,
    Object? isFetchTransferEvents = freezed,
    Object? isListenToTransferEvents = freezed,
    Object? isProcessingTokensJobs = freezed,
    Object? isFetchTokensBalances = freezed,
    Object? isProcessingSwapActions = freezed,
    Object? isFetchTokensLatestPrice = freezed,
    Object? isFetchNewTokens = freezed,
  }) {
    return _then(_ProWalletState(
      etherBalance: etherBalance == freezed
          ? _value.etherBalance
          : etherBalance // ignore: cast_nullable_to_non_nullable
              as BigInt,
      erc20Tokens: erc20Tokens == freezed
          ? _value.erc20Tokens
          : erc20Tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>?,
      isFetchTransferEvents: isFetchTransferEvents == freezed
          ? _value.isFetchTransferEvents
          : isFetchTransferEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      isListenToTransferEvents: isListenToTransferEvents == freezed
          ? _value.isListenToTransferEvents
          : isListenToTransferEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingTokensJobs: isProcessingTokensJobs == freezed
          ? _value.isProcessingTokensJobs
          : isProcessingTokensJobs // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchTokensBalances: isFetchTokensBalances == freezed
          ? _value.isFetchTokensBalances
          : isFetchTokensBalances // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingSwapActions: isProcessingSwapActions == freezed
          ? _value.isProcessingSwapActions
          : isProcessingSwapActions // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchTokensLatestPrice: isFetchTokensLatestPrice == freezed
          ? _value.isFetchTokensLatestPrice
          : isFetchTokensLatestPrice // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchNewTokens: isFetchNewTokens == freezed
          ? _value.isFetchNewTokens
          : isFetchNewTokens // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ProWalletState extends _ProWalletState with DiagnosticableTreeMixin {
  _$_ProWalletState(
      {@JsonKey(fromJson: balanceFromJson) this.etherBalance = null,
      @JsonKey(fromJson: erc20TokensFromJson) this.erc20Tokens = const {},
      @JsonKey(ignore: true) this.isFetchTransferEvents = false,
      @JsonKey(ignore: true) this.isListenToTransferEvents = false,
      @JsonKey(ignore: true) this.isProcessingTokensJobs = false,
      @JsonKey(ignore: true) this.isFetchTokensBalances = false,
      @JsonKey(ignore: true) this.isProcessingSwapActions = false,
      @JsonKey(ignore: true) this.isFetchTokensLatestPrice = false,
      @JsonKey(ignore: true) this.isFetchNewTokens = false})
      : super._();

  factory _$_ProWalletState.fromJson(Map<String, dynamic> json) =>
      _$_$_ProWalletStateFromJson(json);

  @override
  @JsonKey(fromJson: balanceFromJson)
  final BigInt etherBalance;
  @override
  @JsonKey(fromJson: erc20TokensFromJson)
  final Map<String, Token>? erc20Tokens;
  @override
  @JsonKey(ignore: true)
  final bool isFetchTransferEvents;
  @override
  @JsonKey(ignore: true)
  final bool isListenToTransferEvents;
  @override
  @JsonKey(ignore: true)
  final bool isProcessingTokensJobs;
  @override
  @JsonKey(ignore: true)
  final bool isFetchTokensBalances;
  @override
  @JsonKey(ignore: true)
  final bool isProcessingSwapActions;
  @override
  @JsonKey(ignore: true)
  final bool isFetchTokensLatestPrice;
  @override
  @JsonKey(ignore: true)
  final bool isFetchNewTokens;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProWalletState(etherBalance: $etherBalance, erc20Tokens: $erc20Tokens, isFetchTransferEvents: $isFetchTransferEvents, isListenToTransferEvents: $isListenToTransferEvents, isProcessingTokensJobs: $isProcessingTokensJobs, isFetchTokensBalances: $isFetchTokensBalances, isProcessingSwapActions: $isProcessingSwapActions, isFetchTokensLatestPrice: $isFetchTokensLatestPrice, isFetchNewTokens: $isFetchNewTokens)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProWalletState'))
      ..add(DiagnosticsProperty('etherBalance', etherBalance))
      ..add(DiagnosticsProperty('erc20Tokens', erc20Tokens))
      ..add(DiagnosticsProperty('isFetchTransferEvents', isFetchTransferEvents))
      ..add(DiagnosticsProperty(
          'isListenToTransferEvents', isListenToTransferEvents))
      ..add(
          DiagnosticsProperty('isProcessingTokensJobs', isProcessingTokensJobs))
      ..add(DiagnosticsProperty('isFetchTokensBalances', isFetchTokensBalances))
      ..add(DiagnosticsProperty(
          'isProcessingSwapActions', isProcessingSwapActions))
      ..add(DiagnosticsProperty(
          'isFetchTokensLatestPrice', isFetchTokensLatestPrice))
      ..add(DiagnosticsProperty('isFetchNewTokens', isFetchNewTokens));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProWalletState &&
            (identical(other.etherBalance, etherBalance) ||
                const DeepCollectionEquality()
                    .equals(other.etherBalance, etherBalance)) &&
            (identical(other.erc20Tokens, erc20Tokens) ||
                const DeepCollectionEquality()
                    .equals(other.erc20Tokens, erc20Tokens)) &&
            (identical(other.isFetchTransferEvents, isFetchTransferEvents) ||
                const DeepCollectionEquality().equals(
                    other.isFetchTransferEvents, isFetchTransferEvents)) &&
            (identical(
                    other.isListenToTransferEvents, isListenToTransferEvents) ||
                const DeepCollectionEquality().equals(
                    other.isListenToTransferEvents,
                    isListenToTransferEvents)) &&
            (identical(other.isProcessingTokensJobs, isProcessingTokensJobs) ||
                const DeepCollectionEquality().equals(
                    other.isProcessingTokensJobs, isProcessingTokensJobs)) &&
            (identical(other.isFetchTokensBalances, isFetchTokensBalances) ||
                const DeepCollectionEquality().equals(
                    other.isFetchTokensBalances, isFetchTokensBalances)) &&
            (identical(
                    other.isProcessingSwapActions, isProcessingSwapActions) ||
                const DeepCollectionEquality().equals(
                    other.isProcessingSwapActions, isProcessingSwapActions)) &&
            (identical(
                    other.isFetchTokensLatestPrice, isFetchTokensLatestPrice) ||
                const DeepCollectionEquality().equals(
                    other.isFetchTokensLatestPrice,
                    isFetchTokensLatestPrice)) &&
            (identical(other.isFetchNewTokens, isFetchNewTokens) ||
                const DeepCollectionEquality()
                    .equals(other.isFetchNewTokens, isFetchNewTokens)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(etherBalance) ^
      const DeepCollectionEquality().hash(erc20Tokens) ^
      const DeepCollectionEquality().hash(isFetchTransferEvents) ^
      const DeepCollectionEquality().hash(isListenToTransferEvents) ^
      const DeepCollectionEquality().hash(isProcessingTokensJobs) ^
      const DeepCollectionEquality().hash(isFetchTokensBalances) ^
      const DeepCollectionEquality().hash(isProcessingSwapActions) ^
      const DeepCollectionEquality().hash(isFetchTokensLatestPrice) ^
      const DeepCollectionEquality().hash(isFetchNewTokens);

  @JsonKey(ignore: true)
  @override
  _$ProWalletStateCopyWith<_ProWalletState> get copyWith =>
      __$ProWalletStateCopyWithImpl<_ProWalletState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProWalletStateToJson(this);
  }
}

abstract class _ProWalletState extends ProWalletState {
  factory _ProWalletState(
      {@JsonKey(fromJson: balanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token>? erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLatestPrice,
      @JsonKey(ignore: true) bool isFetchNewTokens}) = _$_ProWalletState;
  _ProWalletState._() : super._();

  factory _ProWalletState.fromJson(Map<String, dynamic> json) =
      _$_ProWalletState.fromJson;

  @override
  @JsonKey(fromJson: balanceFromJson)
  BigInt get etherBalance => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: erc20TokensFromJson)
  Map<String, Token>? get erc20Tokens => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isFetchTransferEvents => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isListenToTransferEvents => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isProcessingTokensJobs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isFetchTokensBalances => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isProcessingSwapActions => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isFetchTokensLatestPrice => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  bool get isFetchNewTokens => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProWalletStateCopyWith<_ProWalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
