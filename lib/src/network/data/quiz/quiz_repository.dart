import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/quiz/quiz.dart';

abstract class QuizRepository {
  Future<MResult<List<MQuiz>>> getAllQuiz();
}
