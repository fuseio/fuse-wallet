// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'business.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return _Business.fromJson(json);
}

/// @nodoc
class _$BusinessTearOff {
  const _$BusinessTearOff();

  _Business call(
      {required BusinessMetadata metadata,
      String account = '',
      String id = '',
      int area = 0,
      String name = ''}) {
    return _Business(
      metadata: metadata,
      account: account,
      id: id,
      area: area,
      name: name,
    );
  }

  Business fromJson(Map<String, Object?> json) {
    return Business.fromJson(json);
  }
}

/// @nodoc
const $Business = _$BusinessTearOff();

/// @nodoc
mixin _$Business {
  BusinessMetadata get metadata => throw _privateConstructorUsedError;
  String get account => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int get area => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusinessCopyWith<Business> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) then) =
      _$BusinessCopyWithImpl<$Res>;
  $Res call(
      {BusinessMetadata metadata,
      String account,
      String id,
      int area,
      String name});

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
    Object? metadata = freezed,
    Object? account = freezed,
    Object? id = freezed,
    Object? area = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as BusinessMetadata,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      area: area == freezed
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $BusinessMetadataCopyWith<$Res> get metadata {
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
      {BusinessMetadata metadata,
      String account,
      String id,
      int area,
      String name});

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
    Object? metadata = freezed,
    Object? account = freezed,
    Object? id = freezed,
    Object? area = freezed,
    Object? name = freezed,
  }) {
    return _then(_Business(
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as BusinessMetadata,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      area: area == freezed
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_Business with DiagnosticableTreeMixin implements _Business {
  _$_Business(
      {required this.metadata,
      this.account = '',
      this.id = '',
      this.area = 0,
      this.name = ''});

  factory _$_Business.fromJson(Map<String, dynamic> json) =>
      _$$_BusinessFromJson(json);

  @override
  final BusinessMetadata metadata;
  @JsonKey(defaultValue: '')
  @override
  final String account;
  @JsonKey(defaultValue: '')
  @override
  final String id;
  @JsonKey(defaultValue: 0)
  @override
  final int area;
  @JsonKey(defaultValue: '')
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Business(metadata: $metadata, account: $account, id: $id, area: $area, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Business'))
      ..add(DiagnosticsProperty('metadata', metadata))
      ..add(DiagnosticsProperty('account', account))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('area', area))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Business &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, metadata, account, id, area, name);

  @JsonKey(ignore: true)
  @override
  _$BusinessCopyWith<_Business> get copyWith =>
      __$BusinessCopyWithImpl<_Business>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BusinessToJson(this);
  }
}

abstract class _Business implements Business {
  factory _Business(
      {required BusinessMetadata metadata,
      String account,
      String id,
      int area,
      String name}) = _$_Business;

  factory _Business.fromJson(Map<String, dynamic> json) = _$_Business.fromJson;

  @override
  BusinessMetadata get metadata;
  @override
  String get account;
  @override
  String get id;
  @override
  int get area;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$BusinessCopyWith<_Business> get copyWith =>
      throw _privateConstructorUsedError;
}
