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
      {@JsonKey(ignore: true) Web3 web3,
      @JsonKey(fromJson: etherBalanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents = false,
      @JsonKey(ignore: true) bool isListenToTransferEvents = false,
      @JsonKey(ignore: true) bool isProcessingTokensJobs = false,
      @JsonKey(ignore: true) bool isFetchTokensBalances = false,
      @JsonKey(ignore: true) bool isProcessingSwapActions = false,
      @JsonKey(ignore: true) bool isFetchTokensLastestPrice = false,
      @JsonKey(ignore: true) bool isFetchNewTokens = false}) {
    return _ProWalletState(
      web3: web3,
      etherBalance: etherBalance,
      erc20Tokens: erc20Tokens,
      isFetchTransferEvents: isFetchTransferEvents,
      isListenToTransferEvents: isListenToTransferEvents,
      isProcessingTokensJobs: isProcessingTokensJobs,
      isFetchTokensBalances: isFetchTokensBalances,
      isProcessingSwapActions: isProcessingSwapActions,
      isFetchTokensLastestPrice: isFetchTokensLastestPrice,
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
  @JsonKey(ignore: true)
  Web3 get web3;
  @JsonKey(fromJson: etherBalanceFromJson)
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
  bool get isFetchTokensLastestPrice;
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
      {@JsonKey(ignore: true) Web3 web3,
      @JsonKey(fromJson: etherBalanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLastestPrice,
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
    Object web3 = freezed,
    Object etherBalance = freezed,
    Object erc20Tokens = freezed,
    Object isFetchTransferEvents = freezed,
    Object isListenToTransferEvents = freezed,
    Object isProcessingTokensJobs = freezed,
    Object isFetchTokensBalances = freezed,
    Object isProcessingSwapActions = freezed,
    Object isFetchTokensLastestPrice = freezed,
    Object isFetchNewTokens = freezed,
  }) {
    return _then(_value.copyWith(
      web3: web3 == freezed ? _value.web3 : web3 as Web3,
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
      isFetchTokensLastestPrice: isFetchTokensLastestPrice == freezed
          ? _value.isFetchTokensLastestPrice
          : isFetchTokensLastestPrice as bool,
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
      {@JsonKey(ignore: true) Web3 web3,
      @JsonKey(fromJson: etherBalanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLastestPrice,
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
    Object web3 = freezed,
    Object etherBalance = freezed,
    Object erc20Tokens = freezed,
    Object isFetchTransferEvents = freezed,
    Object isListenToTransferEvents = freezed,
    Object isProcessingTokensJobs = freezed,
    Object isFetchTokensBalances = freezed,
    Object isProcessingSwapActions = freezed,
    Object isFetchTokensLastestPrice = freezed,
    Object isFetchNewTokens = freezed,
  }) {
    return _then(_ProWalletState(
      web3: web3 == freezed ? _value.web3 : web3 as Web3,
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
      isFetchTokensLastestPrice: isFetchTokensLastestPrice == freezed
          ? _value.isFetchTokensLastestPrice
          : isFetchTokensLastestPrice as bool,
      isFetchNewTokens: isFetchNewTokens == freezed
          ? _value.isFetchNewTokens
          : isFetchNewTokens as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ProWalletState implements _ProWalletState {
  _$_ProWalletState(
      {@JsonKey(ignore: true) this.web3,
      @JsonKey(fromJson: etherBalanceFromJson) this.etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) this.erc20Tokens,
      @JsonKey(ignore: true) this.isFetchTransferEvents = false,
      @JsonKey(ignore: true) this.isListenToTransferEvents = false,
      @JsonKey(ignore: true) this.isProcessingTokensJobs = false,
      @JsonKey(ignore: true) this.isFetchTokensBalances = false,
      @JsonKey(ignore: true) this.isProcessingSwapActions = false,
      @JsonKey(ignore: true) this.isFetchTokensLastestPrice = false,
      @JsonKey(ignore: true) this.isFetchNewTokens = false})
      : assert(isFetchTransferEvents != null),
        assert(isListenToTransferEvents != null),
        assert(isProcessingTokensJobs != null),
        assert(isFetchTokensBalances != null),
        assert(isProcessingSwapActions != null),
        assert(isFetchTokensLastestPrice != null),
        assert(isFetchNewTokens != null);

  factory _$_ProWalletState.fromJson(Map<String, dynamic> json) =>
      _$_$_ProWalletStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final Web3 web3;
  @override
  @JsonKey(fromJson: etherBalanceFromJson)
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
  final bool isFetchTokensLastestPrice;
  @override
  @JsonKey(ignore: true)
  final bool isFetchNewTokens;

  @override
  String toString() {
    return 'ProWalletState(web3: $web3, etherBalance: $etherBalance, erc20Tokens: $erc20Tokens, isFetchTransferEvents: $isFetchTransferEvents, isListenToTransferEvents: $isListenToTransferEvents, isProcessingTokensJobs: $isProcessingTokensJobs, isFetchTokensBalances: $isFetchTokensBalances, isProcessingSwapActions: $isProcessingSwapActions, isFetchTokensLastestPrice: $isFetchTokensLastestPrice, isFetchNewTokens: $isFetchNewTokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProWalletState &&
            (identical(other.web3, web3) ||
                const DeepCollectionEquality().equals(other.web3, web3)) &&
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
            (identical(other.isFetchTokensLastestPrice,
                    isFetchTokensLastestPrice) ||
                const DeepCollectionEquality().equals(
                    other.isFetchTokensLastestPrice,
                    isFetchTokensLastestPrice)) &&
            (identical(other.isFetchNewTokens, isFetchNewTokens) ||
                const DeepCollectionEquality()
                    .equals(other.isFetchNewTokens, isFetchNewTokens)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(web3) ^
      const DeepCollectionEquality().hash(etherBalance) ^
      const DeepCollectionEquality().hash(erc20Tokens) ^
      const DeepCollectionEquality().hash(isFetchTransferEvents) ^
      const DeepCollectionEquality().hash(isListenToTransferEvents) ^
      const DeepCollectionEquality().hash(isProcessingTokensJobs) ^
      const DeepCollectionEquality().hash(isFetchTokensBalances) ^
      const DeepCollectionEquality().hash(isProcessingSwapActions) ^
      const DeepCollectionEquality().hash(isFetchTokensLastestPrice) ^
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

abstract class _ProWalletState implements ProWalletState {
  factory _ProWalletState(
      {@JsonKey(ignore: true) Web3 web3,
      @JsonKey(fromJson: etherBalanceFromJson) BigInt etherBalance,
      @JsonKey(fromJson: erc20TokensFromJson) Map<String, Token> erc20Tokens,
      @JsonKey(ignore: true) bool isFetchTransferEvents,
      @JsonKey(ignore: true) bool isListenToTransferEvents,
      @JsonKey(ignore: true) bool isProcessingTokensJobs,
      @JsonKey(ignore: true) bool isFetchTokensBalances,
      @JsonKey(ignore: true) bool isProcessingSwapActions,
      @JsonKey(ignore: true) bool isFetchTokensLastestPrice,
      @JsonKey(ignore: true) bool isFetchNewTokens}) = _$_ProWalletState;

  factory _ProWalletState.fromJson(Map<String, dynamic> json) =
      _$_ProWalletState.fromJson;

  @override
  @JsonKey(ignore: true)
  Web3 get web3;
  @override
  @JsonKey(fromJson: etherBalanceFromJson)
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
  bool get isFetchTokensLastestPrice;
  @override
  @JsonKey(ignore: true)
  bool get isFetchNewTokens;
  @override
  @JsonKey(ignore: true)
  _$ProWalletStateCopyWith<_ProWalletState> get copyWith;
}
