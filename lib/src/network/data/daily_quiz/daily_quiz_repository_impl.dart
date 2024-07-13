import 'dart:math';

import 'package:safebump/src/network/data/daily_quiz/daily_quiz_reference.dart';
import 'package:safebump/src/network/data/daily_quiz/daily_quiz_repository.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';

class DailyQuizRepositoryImpl extends DailyQuizRepository {
  final dailyQuizRef = DailyQuizReference();
  @override
  Future<MResult<DailyQuiz>> getNewDailyQuiz() async {
    try {
      final listQuiz = await dailyQuizRef.getAllQuiz();
      if (listQuiz.data == null) return MResult.success(DailyQuiz.empty());
      final random = Random();
      return MResult.success(
          listQuiz.data![random.nextInt(listQuiz.data!.length)]);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<DailyQuiz>> saveUsersAnswer(DailyQuiz quiz) {
    return dailyQuizRef.getOrAddQuiz(quiz);
  }

  @override
  Future<MResult<bool>> createNewDailyQuiz(DailyQuiz quiz) {
    throw Exception();
  }

  @override
  Future<MResult> removeDailyQuiz(String quizId) {
    throw Exception();
  }
}
