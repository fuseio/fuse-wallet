// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return _AppState.fromJson(json);
}

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

// ignore: unused_element
  _AppState call(
      {@UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @ProWalletStateConverter() ProWalletState proWalletState}) {
    return _AppState(
      userState: userState,
      cashWalletState: cashWalletState,
      proWalletState: proWalletState,
    );
  }

// ignore: unused_element
  AppState fromJson(Map<String, Object> json) {
    return AppState.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  @UserStateConverter()
  UserState get userState;
  @CashWalletStateConverter()
  CashWalletState get cashWalletState;
  @ProWalletStateConverter()
  ProWalletState get proWalletState;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call(
      {@UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @ProWalletStateConverter() ProWalletState proWalletState});

  $UserStateCopyWith<$Res> get userState;
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  $ProWalletStateCopyWith<$Res> get proWalletState;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object userState = freezed,
    Object cashWalletState = freezed,
    Object proWalletState = freezed,
  }) {
    return _then(_value.copyWith(
      userState:
          userState == freezed ? _value.userState : userState as UserState,
      cashWalletState: cashWalletState == freezed
          ? _value.cashWalletState
          : cashWalletState as CashWalletState,
      proWalletState: proWalletState == freezed
          ? _value.proWalletState
          : proWalletState as ProWalletState,
    ));
  }

  @override
  $UserStateCopyWith<$Res> get userState {
    if (_value.userState == null) {
      return null;
    }
    return $UserStateCopyWith<$Res>(_value.userState, (value) {
      return _then(_value.copyWith(userState: value));
    });
  }

  @override
  $CashWalletStateCopyWith<$Res> get cashWalletState {
    if (_value.cashWalletState == null) {
      return null;
    }
    return $CashWalletStateCopyWith<$Res>(_value.cashWalletState, (value) {
      return _then(_value.copyWith(cashWalletState: value));
    });
  }

  @override
  $ProWalletStateCopyWith<$Res> get proWalletState {
    if (_value.proWalletState == null) {
      return null;
    }
    return $ProWalletStateCopyWith<$Res>(_value.proWalletState, (value) {
      return _then(_value.copyWith(proWalletState: value));
    });
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @ProWalletStateConverter() ProWalletState proWalletState});

  @override
  $UserStateCopyWith<$Res> get userState;
  @override
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  @override
  $ProWalletStateCopyWith<$Res> get proWalletState;
}

/// @nodoc
class __$AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(_AppState _value, $Res Function(_AppState) _then)
      : super(_value, (v) => _then(v as _AppState));

  @override
  _AppState get _value => super._value as _AppState;

  @override
  $Res call({
    Object userState = freezed,
    Object cashWalletState = freezed,
    Object proWalletState = freezed,
  }) {
    return _then(_AppState(
      userState:
          userState == freezed ? _value.userState : userState as UserState,
      cashWalletState: cashWalletState == freezed
          ? _value.cashWalletState
          : cashWalletState as CashWalletState,
      proWalletState: proWalletState == freezed
          ? _value.proWalletState
          : proWalletState as ProWalletState,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AppState extends _AppState {
  _$_AppState(
      {@UserStateConverter() this.userState,
      @CashWalletStateConverter() this.cashWalletState,
      @ProWalletStateConverter() this.proWalletState})
      : super._();

  factory _$_AppState.fromJson(Map<String, dynamic> json) =>
      _$_$_AppStateFromJson(json);

  @override
  @UserStateConverter()
  final UserState userState;
  @override
  @CashWalletStateConverter()
  final CashWalletState cashWalletState;
  @override
  @ProWalletStateConverter()
  final ProWalletState proWalletState;

  @override
  String toString() {
    return 'AppState(userState: $userState, cashWalletState: $cashWalletState, proWalletState: $proWalletState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.userState, userState) ||
                const DeepCollectionEquality()
                    .equals(other.userState, userState)) &&
            (identical(other.cashWalletState, cashWalletState) ||
                const DeepCollectionEquality()
                    .equals(other.cashWalletState, cashWalletState)) &&
            (identical(other.proWalletState, proWalletState) ||
                const DeepCollectionEquality()
                    .equals(other.proWalletState, proWalletState)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userState) ^
      const DeepCollectionEquality().hash(cashWalletState) ^
      const DeepCollectionEquality().hash(proWalletState);

  @JsonKey(ignore: true)
  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AppStateToJson(this);
  }
}

abstract class _AppState extends AppState {
  _AppState._() : super._();
  factory _AppState(
      {@UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @ProWalletStateConverter() ProWalletState proWalletState}) = _$_AppState;

  factory _AppState.fromJson(Map<String, dynamic> json) = _$_AppState.fromJson;

  @override
  @UserStateConverter()
  UserState get userState;
  @override
  @CashWalletStateConverter()
  CashWalletState get cashWalletState;
  @override
  @ProWalletStateConverter()
  ProWalletState get proWalletState;
  @override
  @JsonKey(ignore: true)
  _$AppStateCopyWith<_AppState> get copyWith;
}
