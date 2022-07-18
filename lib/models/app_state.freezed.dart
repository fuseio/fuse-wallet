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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return _AppState.fromJson(json);
}

/// @nodoc
mixin _$AppState {
  @NftsStateConverter()
  NftsState get nftsState => throw _privateConstructorUsedError;
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
      {@NftsStateConverter() NftsState nftsState,
      @UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @SwapStateConverter() SwapState swapState});

  $NftsStateCopyWith<$Res> get nftsState;
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
    Object? nftsState = freezed,
    Object? userState = freezed,
    Object? cashWalletState = freezed,
    Object? swapState = freezed,
  }) {
    return _then(_value.copyWith(
      nftsState: nftsState == freezed
          ? _value.nftsState
          : nftsState // ignore: cast_nullable_to_non_nullable
              as NftsState,
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
  $NftsStateCopyWith<$Res> get nftsState {
    return $NftsStateCopyWith<$Res>(_value.nftsState, (value) {
      return _then(_value.copyWith(nftsState: value));
    });
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
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@NftsStateConverter() NftsState nftsState,
      @UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @SwapStateConverter() SwapState swapState});

  @override
  $NftsStateCopyWith<$Res> get nftsState;
  @override
  $UserStateCopyWith<$Res> get userState;
  @override
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  @override
  $SwapStateCopyWith<$Res> get swapState;
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, (v) => _then(v as _$_AppState));

  @override
  _$_AppState get _value => super._value as _$_AppState;

  @override
  $Res call({
    Object? nftsState = freezed,
    Object? userState = freezed,
    Object? cashWalletState = freezed,
    Object? swapState = freezed,
  }) {
    return _then(_$_AppState(
      nftsState: nftsState == freezed
          ? _value.nftsState
          : nftsState // ignore: cast_nullable_to_non_nullable
              as NftsState,
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
      {@NftsStateConverter() required this.nftsState,
      @UserStateConverter() required this.userState,
      @CashWalletStateConverter() required this.cashWalletState,
      @SwapStateConverter() required this.swapState})
      : super._();

  factory _$_AppState.fromJson(Map<String, dynamic> json) =>
      _$$_AppStateFromJson(json);

  @override
  @NftsStateConverter()
  final NftsState nftsState;
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
    return 'AppState(nftsState: $nftsState, userState: $userState, cashWalletState: $cashWalletState, swapState: $swapState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('nftsState', nftsState))
      ..add(DiagnosticsProperty('userState', userState))
      ..add(DiagnosticsProperty('cashWalletState', cashWalletState))
      ..add(DiagnosticsProperty('swapState', swapState));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            const DeepCollectionEquality().equals(other.nftsState, nftsState) &&
            const DeepCollectionEquality().equals(other.userState, userState) &&
            const DeepCollectionEquality()
                .equals(other.cashWalletState, cashWalletState) &&
            const DeepCollectionEquality().equals(other.swapState, swapState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nftsState),
      const DeepCollectionEquality().hash(userState),
      const DeepCollectionEquality().hash(cashWalletState),
      const DeepCollectionEquality().hash(swapState));

  @JsonKey(ignore: true)
  @override
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppStateToJson(
      this,
    );
  }
}

abstract class _AppState extends AppState {
  factory _AppState(
      {@NftsStateConverter()
          required final NftsState nftsState,
      @UserStateConverter()
          required final UserState userState,
      @CashWalletStateConverter()
          required final CashWalletState cashWalletState,
      @SwapStateConverter()
          required final SwapState swapState}) = _$_AppState;
  _AppState._() : super._();

  factory _AppState.fromJson(Map<String, dynamic> json) = _$_AppState.fromJson;

  @override
  @NftsStateConverter()
  NftsState get nftsState;
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
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
