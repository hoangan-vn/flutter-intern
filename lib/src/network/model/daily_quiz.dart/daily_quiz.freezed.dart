// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyQuiz _$DailyQuizFromJson(Map<String, dynamic> json) {
  return _DailyQuiz.fromJson(json);
}

/// @nodoc
mixin _$DailyQuiz {
  String get id => throw _privateConstructorUsedError;
  int get totalAnswer => throw _privateConstructorUsedError;
  int get numberUserCorrect => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyQuizCopyWith<DailyQuiz> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyQuizCopyWith<$Res> {
  factory $DailyQuizCopyWith(DailyQuiz value, $Res Function(DailyQuiz) then) =
      _$DailyQuizCopyWithImpl<$Res, DailyQuiz>;
  @useResult
  $Res call(
      {String id,
      int totalAnswer,
      int numberUserCorrect,
      String question,
      List<String> answers,
      String correctAnswer});
}

/// @nodoc
class _$DailyQuizCopyWithImpl<$Res, $Val extends DailyQuiz>
    implements $DailyQuizCopyWith<$Res> {
  _$DailyQuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? totalAnswer = null,
    Object? numberUserCorrect = null,
    Object? question = null,
    Object? answers = null,
    Object? correctAnswer = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      totalAnswer: null == totalAnswer
          ? _value.totalAnswer
          : totalAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      numberUserCorrect: null == numberUserCorrect
          ? _value.numberUserCorrect
          : numberUserCorrect // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyQuizImplCopyWith<$Res>
    implements $DailyQuizCopyWith<$Res> {
  factory _$$DailyQuizImplCopyWith(
          _$DailyQuizImpl value, $Res Function(_$DailyQuizImpl) then) =
      __$$DailyQuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int totalAnswer,
      int numberUserCorrect,
      String question,
      List<String> answers,
      String correctAnswer});
}

/// @nodoc
class __$$DailyQuizImplCopyWithImpl<$Res>
    extends _$DailyQuizCopyWithImpl<$Res, _$DailyQuizImpl>
    implements _$$DailyQuizImplCopyWith<$Res> {
  __$$DailyQuizImplCopyWithImpl(
      _$DailyQuizImpl _value, $Res Function(_$DailyQuizImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? totalAnswer = null,
    Object? numberUserCorrect = null,
    Object? question = null,
    Object? answers = null,
    Object? correctAnswer = null,
  }) {
    return _then(_$DailyQuizImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      totalAnswer: null == totalAnswer
          ? _value.totalAnswer
          : totalAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      numberUserCorrect: null == numberUserCorrect
          ? _value.numberUserCorrect
          : numberUserCorrect // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyQuizImpl extends _DailyQuiz {
  const _$DailyQuizImpl(
      {required this.id,
      required this.totalAnswer,
      required this.numberUserCorrect,
      required this.question,
      required final List<String> answers,
      required this.correctAnswer})
      : _answers = answers,
        super._();

  factory _$DailyQuizImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyQuizImplFromJson(json);

  @override
  final String id;
  @override
  final int totalAnswer;
  @override
  final int numberUserCorrect;
  @override
  final String question;
  final List<String> _answers;
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final String correctAnswer;

  @override
  String toString() {
    return 'DailyQuiz(id: $id, totalAnswer: $totalAnswer, numberUserCorrect: $numberUserCorrect, question: $question, answers: $answers, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyQuizImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.totalAnswer, totalAnswer) ||
                other.totalAnswer == totalAnswer) &&
            (identical(other.numberUserCorrect, numberUserCorrect) ||
                other.numberUserCorrect == numberUserCorrect) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      totalAnswer,
      numberUserCorrect,
      question,
      const DeepCollectionEquality().hash(_answers),
      correctAnswer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyQuizImplCopyWith<_$DailyQuizImpl> get copyWith =>
      __$$DailyQuizImplCopyWithImpl<_$DailyQuizImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyQuizImplToJson(
      this,
    );
  }
}

abstract class _DailyQuiz extends DailyQuiz {
  const factory _DailyQuiz(
      {required final String id,
      required final int totalAnswer,
      required final int numberUserCorrect,
      required final String question,
      required final List<String> answers,
      required final String correctAnswer}) = _$DailyQuizImpl;
  const _DailyQuiz._() : super._();

  factory _DailyQuiz.fromJson(Map<String, dynamic> json) =
      _$DailyQuizImpl.fromJson;

  @override
  String get id;
  @override
  int get totalAnswer;
  @override
  int get numberUserCorrect;
  @override
  String get question;
  @override
  List<String> get answers;
  @override
  String get correctAnswer;
  @override
  @JsonKey(ignore: true)
  _$$DailyQuizImplCopyWith<_$DailyQuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
