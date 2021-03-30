// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'business.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Business _$BusinessFromJson(Map<String, dynamic> json) {
  return _Business.fromJson(json);
}

/// @nodoc
class _$BusinessTearOff {
  const _$BusinessTearOff();

// ignore: unused_element
  _Business call(
      {BusinessMetadata metadata,
      String account = '',
      String id = '',
      String name = ''}) {
    return _Business(
      metadata: metadata,
      account: account,
      id: id,
      name: name,
    );
  }

// ignore: unused_element
  Business fromJson(Map<String, Object> json) {
    return Business.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Business = _$BusinessTearOff();

/// @nodoc
mixin _$Business {
  BusinessMetadata get metadata;
  String get account;
  String get id;
  String get name;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $BusinessCopyWith<Business> get copyWith;
}

/// @nodoc
abstract class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) then) =
      _$BusinessCopyWithImpl<$Res>;
  $Res call(
      {BusinessMetadata metadata, String account, String id, String name});

  $BusinessMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$BusinessCopyWithImpl<$Res> implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._value, this._then);

  final Business _value;
  // ignore: unused_field
  final $Res Function(Business) _then;

  @override
  $Res call({
    Object metadata = freezed,
    Object account = freezed,
    Object id = freezed,
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      metadata:
          metadata == freezed ? _value.metadata : metadata as BusinessMetadata,
      account: account == freezed ? _value.account : account as String,
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
    ));
  }

  @override
  $BusinessMetadataCopyWith<$Res> get metadata {
    if (_value.metadata == null) {
      return null;
    }
    return $BusinessMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value));
    });
  }
}

/// @nodoc
abstract class _$BusinessCopyWith<$Res> implements $BusinessCopyWith<$Res> {
  factory _$BusinessCopyWith(_Business value, $Res Function(_Business) then) =
      __$BusinessCopyWithImpl<$Res>;
  @override
  $Res call(
      {BusinessMetadata metadata, String account, String id, String name});

  @override
  $BusinessMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$BusinessCopyWithImpl<$Res> extends _$BusinessCopyWithImpl<$Res>
    implements _$BusinessCopyWith<$Res> {
  __$BusinessCopyWithImpl(_Business _value, $Res Function(_Business) _then)
      : super(_value, (v) => _then(v as _Business));

  @override
  _Business get _value => super._value as _Business;

  @override
  $Res call({
    Object metadata = freezed,
    Object account = freezed,
    Object id = freezed,
    Object name = freezed,
  }) {
    return _then(_Business(
      metadata:
          metadata == freezed ? _value.metadata : metadata as BusinessMetadata,
      account: account == freezed ? _value.account : account as String,
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Business implements _Business {
  _$_Business({this.metadata, this.account = '', this.id = '', this.name = ''})
      : assert(account != null),
        assert(id != null),
        assert(name != null);

  factory _$_Business.fromJson(Map<String, dynamic> json) =>
      _$_$_BusinessFromJson(json);

  @override
  final BusinessMetadata metadata;
  @JsonKey(defaultValue: '')
  @override
  final String account;
  @JsonKey(defaultValue: '')
  @override
  final String id;
  @JsonKey(defaultValue: '')
  @override
  final String name;

  @override
  String toString() {
    return 'Business(metadata: $metadata, account: $account, id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Business &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)) &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(metadata) ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$BusinessCopyWith<_Business> get copyWith =>
      __$BusinessCopyWithImpl<_Business>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusinessToJson(this);
  }
}

abstract class _Business implements Business {
  factory _Business(
      {BusinessMetadata metadata,
      String account,
      String id,
      String name}) = _$_Business;

  factory _Business.fromJson(Map<String, dynamic> json) = _$_Business.fromJson;

  @override
  BusinessMetadata get metadata;
  @override
  String get account;
  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$BusinessCopyWith<_Business> get copyWith;
}
