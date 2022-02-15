// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return _AppState.fromJson(json);
}

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

  _AppState call(
      {@UserStateConverter() required UserState userState,
      @CashWalletStateConverter() required CashWalletState cashWalletState,
      @SwapStateConverter() required SwapState swapState}) {
    return _AppState(
      userState: userState,
      cashWalletState: cashWalletState,
      swapState: swapState,
    );
  }

  AppState fromJson(Map<String, Object?> json) {
    return AppState.fromJson(json);
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  @UserStateConverter()
  UserState get userState => throw _privateConstructorUsedError;
  @CashWalletStateConverter()
  CashWalletState get cashWalletState => throw _privateConstructorUsedError;
  @SwapStateConverter()
  SwapState get swapState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call(
      {@UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @SwapStateConverter() SwapState swapState});

  $UserStateCopyWith<$Res> get userState;
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  $SwapStateCopyWith<$Res> get swapState;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object? userState = freezed,
    Object? cashWalletState = freezed,
    Object? swapState = freezed,
  }) {
    return _then(_value.copyWith(
      userState: userState == freezed
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserState,
      cashWalletState: cashWalletState == freezed
          ? _value.cashWalletState
          : cashWalletState // ignore: cast_nullable_to_non_nullable
              as CashWalletState,
      swapState: swapState == freezed
          ? _value.swapState
          : swapState // ignore: cast_nullable_to_non_nullable
              as SwapState,
    ));
  }

  @override
  $UserStateCopyWith<$Res> get userState {
    return $UserStateCopyWith<$Res>(_value.userState, (value) {
      return _then(_value.copyWith(userState: value));
    });
  }

  @override
  $CashWalletStateCopyWith<$Res> get cashWalletState {
    return $CashWalletStateCopyWith<$Res>(_value.cashWalletState, (value) {
      return _then(_value.copyWith(cashWalletState: value));
    });
  }

  @override
  $SwapStateCopyWith<$Res> get swapState {
    return $SwapStateCopyWith<$Res>(_value.swapState, (value) {
      return _then(_value.copyWith(swapState: value));
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
      @SwapStateConverter() SwapState swapState});

  @override
  $UserStateCopyWith<$Res> get userState;
  @override
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  @override
  $SwapStateCopyWith<$Res> get swapState;
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
    Object? userState = freezed,
    Object? cashWalletState = freezed,
    Object? swapState = freezed,
  }) {
    return _then(_AppState(
      userState: userState == freezed
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserState,
      cashWalletState: cashWalletState == freezed
          ? _value.cashWalletState
          : cashWalletState // ignore: cast_nullable_to_non_nullable
              as CashWalletState,
      swapState: swapState == freezed
          ? _value.swapState
          : swapState // ignore: cast_nullable_to_non_nullable
              as SwapState,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_AppState extends _AppState with DiagnosticableTreeMixin {
  _$_AppState(
      {@UserStateConverter() required this.userState,
      @CashWalletStateConverter() required this.cashWalletState,
      @SwapStateConverter() required this.swapState})
      : super._();

  factory _$_AppState.fromJson(Map<String, dynamic> json) =>
      _$$_AppStateFromJson(json);

  @override
  @UserStateConverter()
  final UserState userState;
  @override
  @CashWalletStateConverter()
  final CashWalletState cashWalletState;
  @override
  @SwapStateConverter()
  final SwapState swapState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(userState: $userState, cashWalletState: $cashWalletState, swapState: $swapState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('userState', userState))
      ..add(DiagnosticsProperty('cashWalletState', cashWalletState))
      ..add(DiagnosticsProperty('swapState', swapState));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppState &&
            const DeepCollectionEquality().equals(other.userState, userState) &&
            const DeepCollectionEquality()
                .equals(other.cashWalletState, cashWalletState) &&
            const DeepCollectionEquality().equals(other.swapState, swapState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userState),
      const DeepCollectionEquality().hash(cashWalletState),
      const DeepCollectionEquality().hash(swapState));

  @JsonKey(ignore: true)
  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppStateToJson(this);
  }
}

abstract class _AppState extends AppState {
  factory _AppState(
      {@UserStateConverter() required UserState userState,
      @CashWalletStateConverter() required CashWalletState cashWalletState,
      @SwapStateConverter() required SwapState swapState}) = _$_AppState;
  _AppState._() : super._();

  factory _AppState.fromJson(Map<String, dynamic> json) = _$_AppState.fromJson;

  @override
  @UserStateConverter()
  UserState get userState;
  @override
  @CashWalletStateConverter()
  CashWalletState get cashWalletState;
  @override
  @SwapStateConverter()
  SwapState get swapState;
  @override
  @JsonKey(ignore: true)
  _$AppStateCopyWith<_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
