// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MQuestion _$MQuestionFromJson(Map<String, dynamic> json) => MQuestion(
      question: json['question'] as String,
      id: json['id'] as String,
      firstAnswer: json['firstAnswer'] as String,
      secondAnswer: json['secondAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$MQuestionToJson(MQuestion instance) => <String, dynamic>{
      'question': instance.question,
      'id': instance.id,
      'firstAnswer': instance.firstAnswer,
      'secondAnswer': instance.secondAnswer,
      'correctAnswer': instance.correctAnswer,
    };
