// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MCalendar _$MCalendarFromJson(Map<String, dynamic> json) {
  return _MCalendar.fromJson(json);
}

/// @nodoc
mixin _$MCalendar {
  List<MNote> get notes => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MCalendarCopyWith<MCalendar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCalendarCopyWith<$Res> {
  factory $MCalendarCopyWith(MCalendar value, $Res Function(MCalendar) then) =
      _$MCalendarCopyWithImpl<$Res, MCalendar>;
  @useResult
  $Res call({List<MNote> notes, String date});
}

/// @nodoc
class _$MCalendarCopyWithImpl<$Res, $Val extends MCalendar>
    implements $MCalendarCopyWith<$Res> {
  _$MCalendarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<MNote>,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCalendarImplCopyWith<$Res>
    implements $MCalendarCopyWith<$Res> {
  factory _$$MCalendarImplCopyWith(
          _$MCalendarImpl value, $Res Function(_$MCalendarImpl) then) =
      __$$MCalendarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MNote> notes, String date});
}

/// @nodoc
class __$$MCalendarImplCopyWithImpl<$Res>
    extends _$MCalendarCopyWithImpl<$Res, _$MCalendarImpl>
    implements _$$MCalendarImplCopyWith<$Res> {
  __$$MCalendarImplCopyWithImpl(
      _$MCalendarImpl _value, $Res Function(_$MCalendarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? date = null,
  }) {
    return _then(_$MCalendarImpl(
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<MNote>,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCalendarImpl extends _MCalendar {
  const _$MCalendarImpl({required final List<MNote> notes, required this.date})
      : _notes = notes,
        super._();

  factory _$MCalendarImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCalendarImplFromJson(json);

  final List<MNote> _notes;
  @override
  List<MNote> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  final String date;

  @override
  String toString() {
    return 'MCalendar(notes: $notes, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCalendarImpl &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_notes), date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCalendarImplCopyWith<_$MCalendarImpl> get copyWith =>
      __$$MCalendarImplCopyWithImpl<_$MCalendarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCalendarImplToJson(
      this,
    );
  }
}

abstract class _MCalendar extends MCalendar {
  const factory _MCalendar(
      {required final List<MNote> notes,
      required final String date}) = _$MCalendarImpl;
  const _MCalendar._() : super._();

  factory _MCalendar.fromJson(Map<String, dynamic> json) =
      _$MCalendarImpl.fromJson;

  @override
  List<MNote> get notes;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$MCalendarImplCopyWith<_$MCalendarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
