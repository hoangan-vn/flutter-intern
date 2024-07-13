// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MBaby _$MBabyFromJson(Map<String, dynamic> json) {
  return _MBaby.fromJson(json);
}

/// @nodoc
mixin _$MBaby {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  double? get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MBabyCopyWith<MBaby> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MBabyCopyWith<$Res> {
  factory $MBabyCopyWith(MBaby value, $Res Function(MBaby) then) =
      _$MBabyCopyWithImpl<$Res, MBaby>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? avatar,
      String? type,
      String? gender,
      DateTime? date,
      double? weight,
      double? height});
}

/// @nodoc
class _$MBabyCopyWithImpl<$Res, $Val extends MBaby>
    implements $MBabyCopyWith<$Res> {
  _$MBabyCopyWithImpl(this._value, this._then);

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
    Object? type = freezed,
    Object? gender = freezed,
    Object? date = freezed,
    Object? weight = freezed,
    Object? height = freezed,
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MBabyImplCopyWith<$Res> implements $MBabyCopyWith<$Res> {
  factory _$$MBabyImplCopyWith(
          _$MBabyImpl value, $Res Function(_$MBabyImpl) then) =
      __$$MBabyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? avatar,
      String? type,
      String? gender,
      DateTime? date,
      double? weight,
      double? height});
}

/// @nodoc
class __$$MBabyImplCopyWithImpl<$Res>
    extends _$MBabyCopyWithImpl<$Res, _$MBabyImpl>
    implements _$$MBabyImplCopyWith<$Res> {
  __$$MBabyImplCopyWithImpl(
      _$MBabyImpl _value, $Res Function(_$MBabyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? type = freezed,
    Object? gender = freezed,
    Object? date = freezed,
    Object? weight = freezed,
    Object? height = freezed,
  }) {
    return _then(_$MBabyImpl(
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MBabyImpl extends _MBaby {
  const _$MBabyImpl(
      {required this.id,
      this.name,
      this.avatar,
      this.type,
      this.gender,
      this.date,
      this.weight,
      this.height})
      : super._();

  factory _$MBabyImpl.fromJson(Map<String, dynamic> json) =>
      _$$MBabyImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? avatar;
  @override
  final String? type;
  @override
  final String? gender;
  @override
  final DateTime? date;
  @override
  final double? weight;
  @override
  final double? height;

  @override
  String toString() {
    return 'MBaby(id: $id, name: $name, avatar: $avatar, type: $type, gender: $gender, date: $date, weight: $weight, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MBabyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, avatar, type, gender, date, weight, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MBabyImplCopyWith<_$MBabyImpl> get copyWith =>
      __$$MBabyImplCopyWithImpl<_$MBabyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MBabyImplToJson(
      this,
    );
  }
}

abstract class _MBaby extends MBaby {
  const factory _MBaby(
      {required final String id,
      final String? name,
      final String? avatar,
      final String? type,
      final String? gender,
      final DateTime? date,
      final double? weight,
      final double? height}) = _$MBabyImpl;
  const _MBaby._() : super._();

  factory _MBaby.fromJson(Map<String, dynamic> json) = _$MBabyImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get avatar;
  @override
  String? get type;
  @override
  String? get gender;
  @override
  DateTime? get date;
  @override
  double? get weight;
  @override
  double? get height;
  @override
  @JsonKey(ignore: true)
  _$$MBabyImplCopyWith<_$MBabyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
