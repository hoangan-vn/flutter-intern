import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';

abstract class DailyQuizRepository {
  // Get new daily quiz
  Future<MResult<DailyQuiz>> getNewDailyQuiz();

  // Sync answer to server
  Future<MResult<DailyQuiz>> saveUsersAnswer(DailyQuiz quiz);

  // Create a daily quiz (Admin only)
  Future<MResult<bool>> createNewDailyQuiz(DailyQuiz quiz);

  // remove a quiz (Admin only)
  Future<MResult> removeDailyQuiz(String quizId);
}
