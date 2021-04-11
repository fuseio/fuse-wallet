// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'plugins.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Plugins _$PluginsFromJson(Map<String, dynamic> json) {
  return _Plugins.fromJson(json);
}

/// @nodoc
class _$PluginsTearOff {
  const _$PluginsTearOff();

// ignore: unused_element
  _Plugins call(
      {@nullable
      @JsonKey(includeIfNull: false)
          RampInstantPlugin rampInstant,
      @nullable
      @JsonKey(includeIfNull: false)
          MoonpayPlugin moonpay,
      @nullable
      @JsonKey(includeIfNull: false)
          TransakPlugin transak,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
          WalletBannerPlugin walletBanner,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
          JoinBonusPlugin joinBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
          BackupBonusPlugin backupBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
          InviteBonusPlugin inviteBonus}) {
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

// ignore: unused_element
  Plugins fromJson(Map<String, Object> json) {
    return Plugins.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Plugins = _$PluginsTearOff();

/// @nodoc
mixin _$Plugins {
  @nullable
  @JsonKey(includeIfNull: false)
  RampInstantPlugin get rampInstant;
  @nullable
  @JsonKey(includeIfNull: false)
  MoonpayPlugin get moonpay;
  @nullable
  @JsonKey(includeIfNull: false)
  TransakPlugin get transak;
  @nullable
  @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
  WalletBannerPlugin get walletBanner;
  @nullable
  @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
  JoinBonusPlugin get joinBonus;
  @nullable
  @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
  BackupBonusPlugin get backupBonus;
  @nullable
  @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
  InviteBonusPlugin get inviteBonus;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $PluginsCopyWith<Plugins> get copyWith;
}

/// @nodoc
abstract class $PluginsCopyWith<$Res> {
  factory $PluginsCopyWith(Plugins value, $Res Function(Plugins) then) =
      _$PluginsCopyWithImpl<$Res>;
  $Res call(
      {@nullable
      @JsonKey(includeIfNull: false)
          RampInstantPlugin rampInstant,
      @nullable
      @JsonKey(includeIfNull: false)
          MoonpayPlugin moonpay,
      @nullable
      @JsonKey(includeIfNull: false)
          TransakPlugin transak,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
          WalletBannerPlugin walletBanner,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
          JoinBonusPlugin joinBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
          BackupBonusPlugin backupBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
          InviteBonusPlugin inviteBonus});

  $RampInstantPluginCopyWith<$Res> get rampInstant;
  $MoonpayPluginCopyWith<$Res> get moonpay;
  $TransakPluginCopyWith<$Res> get transak;
  $WalletBannerPluginCopyWith<$Res> get walletBanner;
  $JoinBonusPluginCopyWith<$Res> get joinBonus;
  $BackupBonusPluginCopyWith<$Res> get backupBonus;
  $InviteBonusPluginCopyWith<$Res> get inviteBonus;
}

/// @nodoc
class _$PluginsCopyWithImpl<$Res> implements $PluginsCopyWith<$Res> {
  _$PluginsCopyWithImpl(this._value, this._then);

  final Plugins _value;
  // ignore: unused_field
  final $Res Function(Plugins) _then;

  @override
  $Res call({
    Object rampInstant = freezed,
    Object moonpay = freezed,
    Object transak = freezed,
    Object walletBanner = freezed,
    Object joinBonus = freezed,
    Object backupBonus = freezed,
    Object inviteBonus = freezed,
  }) {
    return _then(_value.copyWith(
      rampInstant: rampInstant == freezed
          ? _value.rampInstant
          : rampInstant as RampInstantPlugin,
      moonpay: moonpay == freezed ? _value.moonpay : moonpay as MoonpayPlugin,
      transak: transak == freezed ? _value.transak : transak as TransakPlugin,
      walletBanner: walletBanner == freezed
          ? _value.walletBanner
          : walletBanner as WalletBannerPlugin,
      joinBonus: joinBonus == freezed
          ? _value.joinBonus
          : joinBonus as JoinBonusPlugin,
      backupBonus: backupBonus == freezed
          ? _value.backupBonus
          : backupBonus as BackupBonusPlugin,
      inviteBonus: inviteBonus == freezed
          ? _value.inviteBonus
          : inviteBonus as InviteBonusPlugin,
    ));
  }

  @override
  $RampInstantPluginCopyWith<$Res> get rampInstant {
    if (_value.rampInstant == null) {
      return null;
    }
    return $RampInstantPluginCopyWith<$Res>(_value.rampInstant, (value) {
      return _then(_value.copyWith(rampInstant: value));
    });
  }

  @override
  $MoonpayPluginCopyWith<$Res> get moonpay {
    if (_value.moonpay == null) {
      return null;
    }
    return $MoonpayPluginCopyWith<$Res>(_value.moonpay, (value) {
      return _then(_value.copyWith(moonpay: value));
    });
  }

  @override
  $TransakPluginCopyWith<$Res> get transak {
    if (_value.transak == null) {
      return null;
    }
    return $TransakPluginCopyWith<$Res>(_value.transak, (value) {
      return _then(_value.copyWith(transak: value));
    });
  }

  @override
  $WalletBannerPluginCopyWith<$Res> get walletBanner {
    if (_value.walletBanner == null) {
      return null;
    }
    return $WalletBannerPluginCopyWith<$Res>(_value.walletBanner, (value) {
      return _then(_value.copyWith(walletBanner: value));
    });
  }

  @override
  $JoinBonusPluginCopyWith<$Res> get joinBonus {
    if (_value.joinBonus == null) {
      return null;
    }
    return $JoinBonusPluginCopyWith<$Res>(_value.joinBonus, (value) {
      return _then(_value.copyWith(joinBonus: value));
    });
  }

  @override
  $BackupBonusPluginCopyWith<$Res> get backupBonus {
    if (_value.backupBonus == null) {
      return null;
    }
    return $BackupBonusPluginCopyWith<$Res>(_value.backupBonus, (value) {
      return _then(_value.copyWith(backupBonus: value));
    });
  }

  @override
  $InviteBonusPluginCopyWith<$Res> get inviteBonus {
    if (_value.inviteBonus == null) {
      return null;
    }
    return $InviteBonusPluginCopyWith<$Res>(_value.inviteBonus, (value) {
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
      {@nullable
      @JsonKey(includeIfNull: false)
          RampInstantPlugin rampInstant,
      @nullable
      @JsonKey(includeIfNull: false)
          MoonpayPlugin moonpay,
      @nullable
      @JsonKey(includeIfNull: false)
          TransakPlugin transak,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
          WalletBannerPlugin walletBanner,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
          JoinBonusPlugin joinBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
          BackupBonusPlugin backupBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
          InviteBonusPlugin inviteBonus});

  @override
  $RampInstantPluginCopyWith<$Res> get rampInstant;
  @override
  $MoonpayPluginCopyWith<$Res> get moonpay;
  @override
  $TransakPluginCopyWith<$Res> get transak;
  @override
  $WalletBannerPluginCopyWith<$Res> get walletBanner;
  @override
  $JoinBonusPluginCopyWith<$Res> get joinBonus;
  @override
  $BackupBonusPluginCopyWith<$Res> get backupBonus;
  @override
  $InviteBonusPluginCopyWith<$Res> get inviteBonus;
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
    Object rampInstant = freezed,
    Object moonpay = freezed,
    Object transak = freezed,
    Object walletBanner = freezed,
    Object joinBonus = freezed,
    Object backupBonus = freezed,
    Object inviteBonus = freezed,
  }) {
    return _then(_Plugins(
      rampInstant: rampInstant == freezed
          ? _value.rampInstant
          : rampInstant as RampInstantPlugin,
      moonpay: moonpay == freezed ? _value.moonpay : moonpay as MoonpayPlugin,
      transak: transak == freezed ? _value.transak : transak as TransakPlugin,
      walletBanner: walletBanner == freezed
          ? _value.walletBanner
          : walletBanner as WalletBannerPlugin,
      joinBonus: joinBonus == freezed
          ? _value.joinBonus
          : joinBonus as JoinBonusPlugin,
      backupBonus: backupBonus == freezed
          ? _value.backupBonus
          : backupBonus as BackupBonusPlugin,
      inviteBonus: inviteBonus == freezed
          ? _value.inviteBonus
          : inviteBonus as InviteBonusPlugin,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Plugins extends _Plugins {
  _$_Plugins(
      {@nullable
      @JsonKey(includeIfNull: false)
          this.rampInstant,
      @nullable
      @JsonKey(includeIfNull: false)
          this.moonpay,
      @nullable
      @JsonKey(includeIfNull: false)
          this.transak,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
          this.walletBanner,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
          this.joinBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
          this.backupBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
          this.inviteBonus})
      : super._();

  factory _$_Plugins.fromJson(Map<String, dynamic> json) =>
      _$_$_PluginsFromJson(json);

  @override
  @nullable
  @JsonKey(includeIfNull: false)
  final RampInstantPlugin rampInstant;
  @override
  @nullable
  @JsonKey(includeIfNull: false)
  final MoonpayPlugin moonpay;
  @override
  @nullable
  @JsonKey(includeIfNull: false)
  final TransakPlugin transak;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
  final WalletBannerPlugin walletBanner;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
  final JoinBonusPlugin joinBonus;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
  final BackupBonusPlugin backupBonus;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
  final InviteBonusPlugin inviteBonus;

  @override
  String toString() {
    return 'Plugins(rampInstant: $rampInstant, moonpay: $moonpay, transak: $transak, walletBanner: $walletBanner, joinBonus: $joinBonus, backupBonus: $backupBonus, inviteBonus: $inviteBonus)';
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
  _Plugins._() : super._();
  factory _Plugins(
      {@nullable
      @JsonKey(includeIfNull: false)
          RampInstantPlugin rampInstant,
      @nullable
      @JsonKey(includeIfNull: false)
          MoonpayPlugin moonpay,
      @nullable
      @JsonKey(includeIfNull: false)
          TransakPlugin transak,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
          WalletBannerPlugin walletBanner,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
          JoinBonusPlugin joinBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
          BackupBonusPlugin backupBonus,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
          InviteBonusPlugin inviteBonus}) = _$_Plugins;

  factory _Plugins.fromJson(Map<String, dynamic> json) = _$_Plugins.fromJson;

  @override
  @nullable
  @JsonKey(includeIfNull: false)
  RampInstantPlugin get rampInstant;
  @override
  @nullable
  @JsonKey(includeIfNull: false)
  MoonpayPlugin get moonpay;
  @override
  @nullable
  @JsonKey(includeIfNull: false)
  TransakPlugin get transak;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: walletBannerFromJson)
  WalletBannerPlugin get walletBanner;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: joinBonusPluginFromJson)
  JoinBonusPlugin get joinBonus;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: backupBonusPluginFromJson)
  BackupBonusPlugin get backupBonus;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: inviteBonusPluginFromJson)
  InviteBonusPlugin get inviteBonus;
  @override
  @JsonKey(ignore: true)
  _$PluginsCopyWith<_Plugins> get copyWith;
}
