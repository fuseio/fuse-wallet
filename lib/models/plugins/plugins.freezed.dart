// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'plugins.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Plugins _$PluginsFromJson(Map<String, dynamic> json) {
  return _Plugins.fromJson(json);
}

/// @nodoc
class _$PluginsTearOff {
  const _$PluginsTearOff();

  _Plugins call(
      {@JsonKey(includeIfNull: false)
          RampInstantPlugin? rampInstant = null,
      @JsonKey(includeIfNull: false)
          MoonpayPlugin? moonpay = null,
      @JsonKey(includeIfNull: false)
          TransakPlugin? transak = null,
      @JsonKey(includeIfNull: false)
          WalletBannerPlugin? walletBanner = null,
      @JsonKey(includeIfNull: false)
      @JoinBonusPluginConverter()
          JoinBonusPlugin? joinBonus = null,
      @JsonKey(includeIfNull: false)
      @BackupBonusPluginConverter()
          BackupBonusPlugin? backupBonus = null,
      @JsonKey(includeIfNull: false)
      @InviteBonusPluginConverter()
          InviteBonusPlugin? inviteBonus = null}) {
    return _Plugins(
      rampInstant: rampInstant,
      moonpay: moonpay,
      transak: transak,
      walletBanner: walletBanner,
      joinBonus: joinBonus,
      backupBonus: backupBonus,
      inviteBonus: inviteBonus,
    );
  }

  Plugins fromJson(Map<String, Object> json) {
    return Plugins.fromJson(json);
  }
}

/// @nodoc
const $Plugins = _$PluginsTearOff();

/// @nodoc
mixin _$Plugins {
  @JsonKey(includeIfNull: false)
  RampInstantPlugin? get rampInstant => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  MoonpayPlugin? get moonpay => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  TransakPlugin? get transak => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  WalletBannerPlugin? get walletBanner => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  @JoinBonusPluginConverter()
  JoinBonusPlugin? get joinBonus => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  @BackupBonusPluginConverter()
  BackupBonusPlugin? get backupBonus => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  @InviteBonusPluginConverter()
  InviteBonusPlugin? get inviteBonus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PluginsCopyWith<Plugins> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PluginsCopyWith<$Res> {
  factory $PluginsCopyWith(Plugins value, $Res Function(Plugins) then) =
      _$PluginsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(includeIfNull: false)
          RampInstantPlugin? rampInstant,
      @JsonKey(includeIfNull: false)
          MoonpayPlugin? moonpay,
      @JsonKey(includeIfNull: false)
          TransakPlugin? transak,
      @JsonKey(includeIfNull: false)
          WalletBannerPlugin? walletBanner,
      @JsonKey(includeIfNull: false)
      @JoinBonusPluginConverter()
          JoinBonusPlugin? joinBonus,
      @JsonKey(includeIfNull: false)
      @BackupBonusPluginConverter()
          BackupBonusPlugin? backupBonus,
      @JsonKey(includeIfNull: false)
      @InviteBonusPluginConverter()
          InviteBonusPlugin? inviteBonus});

  $RampInstantPluginCopyWith<$Res>? get rampInstant;
  $MoonpayPluginCopyWith<$Res>? get moonpay;
  $TransakPluginCopyWith<$Res>? get transak;
  $WalletBannerPluginCopyWith<$Res>? get walletBanner;
  $JoinBonusPluginCopyWith<$Res>? get joinBonus;
  $BackupBonusPluginCopyWith<$Res>? get backupBonus;
  $InviteBonusPluginCopyWith<$Res>? get inviteBonus;
}

/// @nodoc
class _$PluginsCopyWithImpl<$Res> implements $PluginsCopyWith<$Res> {
  _$PluginsCopyWithImpl(this._value, this._then);

  final Plugins _value;
  // ignore: unused_field
  final $Res Function(Plugins) _then;

  @override
  $Res call({
    Object? rampInstant = freezed,
    Object? moonpay = freezed,
    Object? transak = freezed,
    Object? walletBanner = freezed,
    Object? joinBonus = freezed,
    Object? backupBonus = freezed,
    Object? inviteBonus = freezed,
  }) {
    return _then(_value.copyWith(
      rampInstant: rampInstant == freezed
          ? _value.rampInstant
          : rampInstant // ignore: cast_nullable_to_non_nullable
              as RampInstantPlugin?,
      moonpay: moonpay == freezed
          ? _value.moonpay
          : moonpay // ignore: cast_nullable_to_non_nullable
              as MoonpayPlugin?,
      transak: transak == freezed
          ? _value.transak
          : transak // ignore: cast_nullable_to_non_nullable
              as TransakPlugin?,
      walletBanner: walletBanner == freezed
          ? _value.walletBanner
          : walletBanner // ignore: cast_nullable_to_non_nullable
              as WalletBannerPlugin?,
      joinBonus: joinBonus == freezed
          ? _value.joinBonus
          : joinBonus // ignore: cast_nullable_to_non_nullable
              as JoinBonusPlugin?,
      backupBonus: backupBonus == freezed
          ? _value.backupBonus
          : backupBonus // ignore: cast_nullable_to_non_nullable
              as BackupBonusPlugin?,
      inviteBonus: inviteBonus == freezed
          ? _value.inviteBonus
          : inviteBonus // ignore: cast_nullable_to_non_nullable
              as InviteBonusPlugin?,
    ));
  }

  @override
  $RampInstantPluginCopyWith<$Res>? get rampInstant {
    if (_value.rampInstant == null) {
      return null;
    }

    return $RampInstantPluginCopyWith<$Res>(_value.rampInstant!, (value) {
      return _then(_value.copyWith(rampInstant: value));
    });
  }

  @override
  $MoonpayPluginCopyWith<$Res>? get moonpay {
    if (_value.moonpay == null) {
      return null;
    }

    return $MoonpayPluginCopyWith<$Res>(_value.moonpay!, (value) {
      return _then(_value.copyWith(moonpay: value));
    });
  }

  @override
  $TransakPluginCopyWith<$Res>? get transak {
    if (_value.transak == null) {
      return null;
    }

    return $TransakPluginCopyWith<$Res>(_value.transak!, (value) {
      return _then(_value.copyWith(transak: value));
    });
  }

  @override
  $WalletBannerPluginCopyWith<$Res>? get walletBanner {
    if (_value.walletBanner == null) {
      return null;
    }

    return $WalletBannerPluginCopyWith<$Res>(_value.walletBanner!, (value) {
      return _then(_value.copyWith(walletBanner: value));
    });
  }

  @override
  $JoinBonusPluginCopyWith<$Res>? get joinBonus {
    if (_value.joinBonus == null) {
      return null;
    }

    return $JoinBonusPluginCopyWith<$Res>(_value.joinBonus!, (value) {
      return _then(_value.copyWith(joinBonus: value));
    });
  }

  @override
  $BackupBonusPluginCopyWith<$Res>? get backupBonus {
    if (_value.backupBonus == null) {
      return null;
    }

    return $BackupBonusPluginCopyWith<$Res>(_value.backupBonus!, (value) {
      return _then(_value.copyWith(backupBonus: value));
    });
  }

  @override
  $InviteBonusPluginCopyWith<$Res>? get inviteBonus {
    if (_value.inviteBonus == null) {
      return null;
    }

    return $InviteBonusPluginCopyWith<$Res>(_value.inviteBonus!, (value) {
      return _then(_value.copyWith(inviteBonus: value));
    });
  }
}

/// @nodoc
abstract class _$PluginsCopyWith<$Res> implements $PluginsCopyWith<$Res> {
  factory _$PluginsCopyWith(_Plugins value, $Res Function(_Plugins) then) =
      __$PluginsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(includeIfNull: false)
          RampInstantPlugin? rampInstant,
      @JsonKey(includeIfNull: false)
          MoonpayPlugin? moonpay,
      @JsonKey(includeIfNull: false)
          TransakPlugin? transak,
      @JsonKey(includeIfNull: false)
          WalletBannerPlugin? walletBanner,
      @JsonKey(includeIfNull: false)
      @JoinBonusPluginConverter()
          JoinBonusPlugin? joinBonus,
      @JsonKey(includeIfNull: false)
      @BackupBonusPluginConverter()
          BackupBonusPlugin? backupBonus,
      @JsonKey(includeIfNull: false)
      @InviteBonusPluginConverter()
          InviteBonusPlugin? inviteBonus});

  @override
  $RampInstantPluginCopyWith<$Res>? get rampInstant;
  @override
  $MoonpayPluginCopyWith<$Res>? get moonpay;
  @override
  $TransakPluginCopyWith<$Res>? get transak;
  @override
  $WalletBannerPluginCopyWith<$Res>? get walletBanner;
  @override
  $JoinBonusPluginCopyWith<$Res>? get joinBonus;
  @override
  $BackupBonusPluginCopyWith<$Res>? get backupBonus;
  @override
  $InviteBonusPluginCopyWith<$Res>? get inviteBonus;
}

/// @nodoc
class __$PluginsCopyWithImpl<$Res> extends _$PluginsCopyWithImpl<$Res>
    implements _$PluginsCopyWith<$Res> {
  __$PluginsCopyWithImpl(_Plugins _value, $Res Function(_Plugins) _then)
      : super(_value, (v) => _then(v as _Plugins));

  @override
  _Plugins get _value => super._value as _Plugins;

  @override
  $Res call({
    Object? rampInstant = freezed,
    Object? moonpay = freezed,
    Object? transak = freezed,
    Object? walletBanner = freezed,
    Object? joinBonus = freezed,
    Object? backupBonus = freezed,
    Object? inviteBonus = freezed,
  }) {
    return _then(_Plugins(
      rampInstant: rampInstant == freezed
          ? _value.rampInstant
          : rampInstant // ignore: cast_nullable_to_non_nullable
              as RampInstantPlugin?,
      moonpay: moonpay == freezed
          ? _value.moonpay
          : moonpay // ignore: cast_nullable_to_non_nullable
              as MoonpayPlugin?,
      transak: transak == freezed
          ? _value.transak
          : transak // ignore: cast_nullable_to_non_nullable
              as TransakPlugin?,
      walletBanner: walletBanner == freezed
          ? _value.walletBanner
          : walletBanner // ignore: cast_nullable_to_non_nullable
              as WalletBannerPlugin?,
      joinBonus: joinBonus == freezed
          ? _value.joinBonus
          : joinBonus // ignore: cast_nullable_to_non_nullable
              as JoinBonusPlugin?,
      backupBonus: backupBonus == freezed
          ? _value.backupBonus
          : backupBonus // ignore: cast_nullable_to_non_nullable
              as BackupBonusPlugin?,
      inviteBonus: inviteBonus == freezed
          ? _value.inviteBonus
          : inviteBonus // ignore: cast_nullable_to_non_nullable
              as InviteBonusPlugin?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_Plugins extends _Plugins with DiagnosticableTreeMixin {
  _$_Plugins(
      {@JsonKey(includeIfNull: false)
          this.rampInstant = null,
      @JsonKey(includeIfNull: false)
          this.moonpay = null,
      @JsonKey(includeIfNull: false)
          this.transak = null,
      @JsonKey(includeIfNull: false)
          this.walletBanner = null,
      @JsonKey(includeIfNull: false)
      @JoinBonusPluginConverter()
          this.joinBonus = null,
      @JsonKey(includeIfNull: false)
      @BackupBonusPluginConverter()
          this.backupBonus = null,
      @JsonKey(includeIfNull: false)
      @InviteBonusPluginConverter()
          this.inviteBonus = null})
      : super._();

  factory _$_Plugins.fromJson(Map<String, dynamic> json) =>
      _$_$_PluginsFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final RampInstantPlugin? rampInstant;
  @override
  @JsonKey(includeIfNull: false)
  final MoonpayPlugin? moonpay;
  @override
  @JsonKey(includeIfNull: false)
  final TransakPlugin? transak;
  @override
  @JsonKey(includeIfNull: false)
  final WalletBannerPlugin? walletBanner;
  @override
  @JsonKey(includeIfNull: false)
  @JoinBonusPluginConverter()
  final JoinBonusPlugin? joinBonus;
  @override
  @JsonKey(includeIfNull: false)
  @BackupBonusPluginConverter()
  final BackupBonusPlugin? backupBonus;
  @override
  @JsonKey(includeIfNull: false)
  @InviteBonusPluginConverter()
  final InviteBonusPlugin? inviteBonus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Plugins(rampInstant: $rampInstant, moonpay: $moonpay, transak: $transak, walletBanner: $walletBanner, joinBonus: $joinBonus, backupBonus: $backupBonus, inviteBonus: $inviteBonus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Plugins'))
      ..add(DiagnosticsProperty('rampInstant', rampInstant))
      ..add(DiagnosticsProperty('moonpay', moonpay))
      ..add(DiagnosticsProperty('transak', transak))
      ..add(DiagnosticsProperty('walletBanner', walletBanner))
      ..add(DiagnosticsProperty('joinBonus', joinBonus))
      ..add(DiagnosticsProperty('backupBonus', backupBonus))
      ..add(DiagnosticsProperty('inviteBonus', inviteBonus));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Plugins &&
            (identical(other.rampInstant, rampInstant) ||
                const DeepCollectionEquality()
                    .equals(other.rampInstant, rampInstant)) &&
            (identical(other.moonpay, moonpay) ||
                const DeepCollectionEquality()
                    .equals(other.moonpay, moonpay)) &&
            (identical(other.transak, transak) ||
                const DeepCollectionEquality()
                    .equals(other.transak, transak)) &&
            (identical(other.walletBanner, walletBanner) ||
                const DeepCollectionEquality()
                    .equals(other.walletBanner, walletBanner)) &&
            (identical(other.joinBonus, joinBonus) ||
                const DeepCollectionEquality()
                    .equals(other.joinBonus, joinBonus)) &&
            (identical(other.backupBonus, backupBonus) ||
                const DeepCollectionEquality()
                    .equals(other.backupBonus, backupBonus)) &&
            (identical(other.inviteBonus, inviteBonus) ||
                const DeepCollectionEquality()
                    .equals(other.inviteBonus, inviteBonus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(rampInstant) ^
      const DeepCollectionEquality().hash(moonpay) ^
      const DeepCollectionEquality().hash(transak) ^
      const DeepCollectionEquality().hash(walletBanner) ^
      const DeepCollectionEquality().hash(joinBonus) ^
      const DeepCollectionEquality().hash(backupBonus) ^
      const DeepCollectionEquality().hash(inviteBonus);

  @JsonKey(ignore: true)
  @override
  _$PluginsCopyWith<_Plugins> get copyWith =>
      __$PluginsCopyWithImpl<_Plugins>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PluginsToJson(this);
  }
}

abstract class _Plugins extends Plugins {
  factory _Plugins(
      {@JsonKey(includeIfNull: false)
          RampInstantPlugin? rampInstant,
      @JsonKey(includeIfNull: false)
          MoonpayPlugin? moonpay,
      @JsonKey(includeIfNull: false)
          TransakPlugin? transak,
      @JsonKey(includeIfNull: false)
          WalletBannerPlugin? walletBanner,
      @JsonKey(includeIfNull: false)
      @JoinBonusPluginConverter()
          JoinBonusPlugin? joinBonus,
      @JsonKey(includeIfNull: false)
      @BackupBonusPluginConverter()
          BackupBonusPlugin? backupBonus,
      @JsonKey(includeIfNull: false)
      @InviteBonusPluginConverter()
          InviteBonusPlugin? inviteBonus}) = _$_Plugins;
  _Plugins._() : super._();

  factory _Plugins.fromJson(Map<String, dynamic> json) = _$_Plugins.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  RampInstantPlugin? get rampInstant => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  MoonpayPlugin? get moonpay => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  TransakPlugin? get transak => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  WalletBannerPlugin? get walletBanner => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  @JoinBonusPluginConverter()
  JoinBonusPlugin? get joinBonus => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  @BackupBonusPluginConverter()
  BackupBonusPlugin? get backupBonus => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  @InviteBonusPluginConverter()
  InviteBonusPlugin? get inviteBonus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PluginsCopyWith<_Plugins> get copyWith =>
      throw _privateConstructorUsedError;
}
