// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MQuiz _$MQuizFromJson(Map<String, dynamic> json) => MQuiz(
      title: json['title'] as String,
      id: json['id'] as String,
      detail: json['detail'] as String,
      numberQuestion: json['numberQuestion'] as int,
    );

Map<String, dynamic> _$MQuizToJson(MQuiz instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'detail': instance.detail,
      'numberQuestion': instance.numberQuestion,
    };
