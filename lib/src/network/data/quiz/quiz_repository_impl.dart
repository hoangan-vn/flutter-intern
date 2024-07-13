import 'package:safebump/src/network/data/quiz/quiz_reference.dart';
import 'package:safebump/src/network/data/quiz/quiz_repository.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/quiz/quiz.dart';

class QuizRepositoryImpl extends QuizRepository {
  final quizRef = QuizReference();

  @override
  Future<MResult<List<MQuiz>>> getAllQuiz() {
    return quizRef.getAllQuiz();
  }
}
