// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'pro_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ProWalletState _$ProWalletStateFromJson(Map<String, dynamic> json) {
  return _ProWalletState.fromJson(json);
}

/// @nodoc
class _$ProWalletStateTearOff {
  const _$ProWalletStateTearOff();

// ignore: unused_element
  _ProWalletState call(
      {@JsonKey(fromJson: balanceFromJson)
          BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson)
          Map<String, Token> erc20Tokens = const {},
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

// ignore: unused_element
  ProWalletState fromJson(Map<String, Object> json) {
    return ProWalletState.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ProWalletState = _$ProWalletStateTearOff();

/// @nodoc
mixin _$ProWalletState {
  @JsonKey(fromJson: balanceFromJson)
  BigInt get etherBalance;
  @JsonKey(fromJson: erc20TokensFromJson)
  Map<String, Token> get erc20Tokens;
  @JsonKey(ignore: true)
  bool get isFetchTransferEvents;
  @JsonKey(ignore: true)
  bool get isListenToTransferEvents;
  @JsonKey(ignore: true)
  bool get isProcessingTokensJobs;
  @JsonKey(ignore: true)
  bool get isFetchTokensBalances;
  @JsonKey(ignore: true)
  bool get isProcessingSwapActions;
  @JsonKey(ignore: true)
  bool get isFetchTokensLatestPrice;
  @JsonKey(ignore: true)
  bool get isFetchNewTokens;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ProWalletStateCopyWith<ProWalletState> get copyWith;
}

/// @nodoc
abstract class $ProWalletStateCopyWith<$Res> {
  factory $ProWalletStateCopyWith(
          ProWalletState value, $Res Function(ProWalletState) then) =
      _$ProWalletStateCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: balanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
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
    Object etherBalance = freezed,
    Object erc20Tokens = freezed,
    Object isFetchTransferEvents = freezed,
    Object isListenToTransferEvents = freezed,
    Object isProcessingTokensJobs = freezed,
    Object isFetchTokensBalances = freezed,
    Object isProcessingSwapActions = freezed,
    Object isFetchTokensLatestPrice = freezed,
    Object isFetchNewTokens = freezed,
  }) {
    return _then(_value.copyWith(
      etherBalance: etherBalance == freezed
          ? _value.etherBalance
          : etherBalance as BigInt,
      erc20Tokens: erc20Tokens == freezed
          ? _value.erc20Tokens
          : erc20Tokens as Map<String, Token>,
      isFetchTransferEvents: isFetchTransferEvents == freezed
          ? _value.isFetchTransferEvents
          : isFetchTransferEvents as bool,
      isListenToTransferEvents: isListenToTransferEvents == freezed
          ? _value.isListenToTransferEvents
          : isListenToTransferEvents as bool,
      isProcessingTokensJobs: isProcessingTokensJobs == freezed
          ? _value.isProcessingTokensJobs
          : isProcessingTokensJobs as bool,
      isFetchTokensBalances: isFetchTokensBalances == freezed
          ? _value.isFetchTokensBalances
          : isFetchTokensBalances as bool,
      isProcessingSwapActions: isProcessingSwapActions == freezed
          ? _value.isProcessingSwapActions
          : isProcessingSwapActions as bool,
      isFetchTokensLatestPrice: isFetchTokensLatestPrice == freezed
          ? _value.isFetchTokensLatestPrice
          : isFetchTokensLatestPrice as bool,
      isFetchNewTokens: isFetchNewTokens == freezed
          ? _value.isFetchNewTokens
          : isFetchNewTokens as bool,
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
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
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
    Object etherBalance = freezed,
    Object erc20Tokens = freezed,
    Object isFetchTransferEvents = freezed,
    Object isListenToTransferEvents = freezed,
    Object isProcessingTokensJobs = freezed,
    Object isFetchTokensBalances = freezed,
    Object isProcessingSwapActions = freezed,
    Object isFetchTokensLatestPrice = freezed,
    Object isFetchNewTokens = freezed,
  }) {
    return _then(_ProWalletState(
      etherBalance: etherBalance == freezed
          ? _value.etherBalance
          : etherBalance as BigInt,
      erc20Tokens: erc20Tokens == freezed
          ? _value.erc20Tokens
          : erc20Tokens as Map<String, Token>,
      isFetchTransferEvents: isFetchTransferEvents == freezed
          ? _value.isFetchTransferEvents
          : isFetchTransferEvents as bool,
      isListenToTransferEvents: isListenToTransferEvents == freezed
          ? _value.isListenToTransferEvents
          : isListenToTransferEvents as bool,
      isProcessingTokensJobs: isProcessingTokensJobs == freezed
          ? _value.isProcessingTokensJobs
          : isProcessingTokensJobs as bool,
      isFetchTokensBalances: isFetchTokensBalances == freezed
          ? _value.isFetchTokensBalances
          : isFetchTokensBalances as bool,
      isProcessingSwapActions: isProcessingSwapActions == freezed
          ? _value.isProcessingSwapActions
          : isProcessingSwapActions as bool,
      isFetchTokensLatestPrice: isFetchTokensLatestPrice == freezed
          ? _value.isFetchTokensLatestPrice
          : isFetchTokensLatestPrice as bool,
      isFetchNewTokens: isFetchNewTokens == freezed
          ? _value.isFetchNewTokens
          : isFetchNewTokens as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ProWalletState extends _ProWalletState {
  _$_ProWalletState(
      {@JsonKey(fromJson: balanceFromJson) this.etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) this.erc20Tokens = const {},
      @JsonKey(ignore: true) this.isFetchTransferEvents = false,
      @JsonKey(ignore: true) this.isListenToTransferEvents = false,
      @JsonKey(ignore: true) this.isProcessingTokensJobs = false,
      @JsonKey(ignore: true) this.isFetchTokensBalances = false,
      @JsonKey(ignore: true) this.isProcessingSwapActions = false,
      @JsonKey(ignore: true) this.isFetchTokensLatestPrice = false,
      @JsonKey(ignore: true) this.isFetchNewTokens = false})
      : assert(erc20Tokens != null),
        assert(isFetchTransferEvents != null),
        assert(isListenToTransferEvents != null),
        assert(isProcessingTokensJobs != null),
        assert(isFetchTokensBalances != null),
        assert(isProcessingSwapActions != null),
        assert(isFetchTokensLatestPrice != null),
        assert(isFetchNewTokens != null),
        super._();

  factory _$_ProWalletState.fromJson(Map<String, dynamic> json) =>
      _$_$_ProWalletStateFromJson(json);

  @override
  @JsonKey(fromJson: balanceFromJson)
  final BigInt etherBalance;
  @override
  @JsonKey(fromJson: erc20TokensFromJson)
  final Map<String, Token> erc20Tokens;
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
  String toString() {
    return 'ProWalletState(etherBalance: $etherBalance, erc20Tokens: $erc20Tokens, isFetchTransferEvents: $isFetchTransferEvents, isListenToTransferEvents: $isListenToTransferEvents, isProcessingTokensJobs: $isProcessingTokensJobs, isFetchTokensBalances: $isFetchTokensBalances, isProcessingSwapActions: $isProcessingSwapActions, isFetchTokensLatestPrice: $isFetchTokensLatestPrice, isFetchNewTokens: $isFetchNewTokens)';
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
  _ProWalletState._() : super._();
  factory _ProWalletState(
      {@JsonKey(fromJson: balanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLatestPrice,
      @JsonKey(ignore: true) bool isFetchNewTokens}) = _$_ProWalletState;

  factory _ProWalletState.fromJson(Map<String, dynamic> json) =
      _$_ProWalletState.fromJson;

  @override
  @JsonKey(fromJson: balanceFromJson)
  BigInt get etherBalance;
  @override
  @JsonKey(fromJson: erc20TokensFromJson)
  Map<String, Token> get erc20Tokens;
  @override
  @JsonKey(ignore: true)
  bool get isFetchTransferEvents;
  @override
  @JsonKey(ignore: true)
  bool get isListenToTransferEvents;
  @override
  @JsonKey(ignore: true)
  bool get isProcessingTokensJobs;
  @override
  @JsonKey(ignore: true)
  bool get isFetchTokensBalances;
  @override
  @JsonKey(ignore: true)
  bool get isProcessingSwapActions;
  @override
  @JsonKey(ignore: true)
  bool get isFetchTokensLatestPrice;
  @override
  @JsonKey(ignore: true)
  bool get isFetchNewTokens;
  @override
  @JsonKey(ignore: true)
  _$ProWalletStateCopyWith<_ProWalletState> get copyWith;
}
