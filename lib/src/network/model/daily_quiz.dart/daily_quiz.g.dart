// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyQuizImpl _$$DailyQuizImplFromJson(Map<String, dynamic> json) =>
    _$DailyQuizImpl(
      id: json['id'] as String,
      totalAnswer: json['totalAnswer'] as int,
      numberUserCorrect: json['numberUserCorrect'] as int,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$$DailyQuizImplToJson(_$DailyQuizImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalAnswer': instance.totalAnswer,
      'numberUserCorrect': instance.numberUserCorrect,
      'question': instance.question,
      'answers': instance.answers,
      'correctAnswer': instance.correctAnswer,
    };
