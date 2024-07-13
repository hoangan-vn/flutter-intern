import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_quiz.freezed.dart';
part 'daily_quiz.g.dart';

@freezed
class DailyQuiz with _$DailyQuiz {
  const DailyQuiz._();
  const factory DailyQuiz({
    required String id,
    required int totalAnswer,
    required int numberUserCorrect,
    required String question,
    required List<String> answers,
    required String correctAnswer,
  }) = _DailyQuiz;

  factory DailyQuiz.empty() {
    return const DailyQuiz(
        id: '',
        totalAnswer: 0,
        numberUserCorrect: 0,
        question: '',
        answers: [],
        correctAnswer: '');
  }

  factory DailyQuiz.fromJson(Map<String, Object?> json) =>
      _$DailyQuizFromJson(json);
}
