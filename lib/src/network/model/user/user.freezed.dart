// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MUser _$MUserFromJson(Map<String, dynamic> json) {
  return _MUser.fromJson(json);
}

/// @nodoc
mixin _$MUser {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  MeasurementUnitType? get measurementUnit =>
      throw _privateConstructorUsedError;
  double? get height => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MUserCopyWith<MUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MUserCopyWith<$Res> {
  factory $MUserCopyWith(MUser value, $Res Function(MUser) then) =
      _$MUserCopyWithImpl<$Res, MUser>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? avatar,
      String? email,
      DateTime? dateOfBirth,
      Gender? gender,
      MeasurementUnitType? measurementUnit,
      double? height,
      double? weight});
}

/// @nodoc
class _$MUserCopyWithImpl<$Res, $Val extends MUser>
    implements $MUserCopyWith<$Res> {
  _$MUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? email = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? measurementUnit = freezed,
    Object? height = freezed,
    Object? weight = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      measurementUnit: freezed == measurementUnit
          ? _value.measurementUnit
          : measurementUnit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitType?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MUserImplCopyWith<$Res> implements $MUserCopyWith<$Res> {
  factory _$$MUserImplCopyWith(
          _$MUserImpl value, $Res Function(_$MUserImpl) then) =
      __$$MUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? avatar,
      String? email,
      DateTime? dateOfBirth,
      Gender? gender,
      MeasurementUnitType? measurementUnit,
      double? height,
      double? weight});
}

/// @nodoc
class __$$MUserImplCopyWithImpl<$Res>
    extends _$MUserCopyWithImpl<$Res, _$MUserImpl>
    implements _$$MUserImplCopyWith<$Res> {
  __$$MUserImplCopyWithImpl(
      _$MUserImpl _value, $Res Function(_$MUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? email = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? measurementUnit = freezed,
    Object? height = freezed,
    Object? weight = freezed,
  }) {
    return _then(_$MUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      measurementUnit: freezed == measurementUnit
          ? _value.measurementUnit
          : measurementUnit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitType?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MUserImpl extends _MUser {
  const _$MUserImpl(
      {required this.id,
      this.name,
      this.avatar,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.measurementUnit,
      this.height,
      this.weight})
      : super._();

  factory _$MUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$MUserImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? avatar;
  @override
  final String? email;
  @override
  final DateTime? dateOfBirth;
  @override
  final Gender? gender;
  @override
  final MeasurementUnitType? measurementUnit;
  @override
  final double? height;
  @override
  final double? weight;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MUserImplCopyWith<_$MUserImpl> get copyWith =>
      __$$MUserImplCopyWithImpl<_$MUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MUserImplToJson(
      this,
    );
  }
}

abstract class _MUser extends MUser {
  const factory _MUser(
      {required final String id,
      final String? name,
      final String? avatar,
      final String? email,
      final DateTime? dateOfBirth,
      final Gender? gender,
      final MeasurementUnitType? measurementUnit,
      final double? height,
      final double? weight}) = _$MUserImpl;
  const _MUser._() : super._();

  factory _MUser.fromJson(Map<String, dynamic> json) = _$MUserImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get avatar;
  @override
  String? get email;
  @override
  DateTime? get dateOfBirth;
  @override
  Gender? get gender;
  @override
  MeasurementUnitType? get measurementUnit;
  @override
  double? get height;
  @override
  double? get weight;
  @override
  @JsonKey(ignore: true)
  _$$MUserImplCopyWith<_$MUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
