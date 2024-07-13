// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MVideo _$MVideoFromJson(Map<String, dynamic> json) {
  return _MVideo.fromJson(json);
}

/// @nodoc
mixin _$MVideo {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MVideoCopyWith<MVideo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MVideoCopyWith<$Res> {
  factory $MVideoCopyWith(MVideo value, $Res Function(MVideo) then) =
      _$MVideoCopyWithImpl<$Res, MVideo>;
  @useResult
  $Res call({String id, String title, String content});
}

/// @nodoc
class _$MVideoCopyWithImpl<$Res, $Val extends MVideo>
    implements $MVideoCopyWith<$Res> {
  _$MVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MVideoImplCopyWith<$Res> implements $MVideoCopyWith<$Res> {
  factory _$$MVideoImplCopyWith(
          _$MVideoImpl value, $Res Function(_$MVideoImpl) then) =
      __$$MVideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String content});
}

/// @nodoc
class __$$MVideoImplCopyWithImpl<$Res>
    extends _$MVideoCopyWithImpl<$Res, _$MVideoImpl>
    implements _$$MVideoImplCopyWith<$Res> {
  __$$MVideoImplCopyWithImpl(
      _$MVideoImpl _value, $Res Function(_$MVideoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_$MVideoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MVideoImpl extends _MVideo {
  const _$MVideoImpl(
      {required this.id, required this.title, required this.content})
      : super._();

  factory _$MVideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MVideoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;

  @override
  String toString() {
    return 'MVideo(id: $id, title: $title, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MVideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MVideoImplCopyWith<_$MVideoImpl> get copyWith =>
      __$$MVideoImplCopyWithImpl<_$MVideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MVideoImplToJson(
      this,
    );
  }
}

abstract class _MVideo extends MVideo {
  const factory _MVideo(
      {required final String id,
      required final String title,
      required final String content}) = _$MVideoImpl;
  const _MVideo._() : super._();

  factory _MVideo.fromJson(Map<String, dynamic> json) = _$MVideoImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$MVideoImplCopyWith<_$MVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
