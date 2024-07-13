import 'package:safebump/src/network/data/quiz/question/question_reference.dart';
import 'package:safebump/src/network/data/quiz/question/question_repository.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/quiz/question.dart';

class QuestionRepositoryImpl extends QuestionRepository {
  final quizRef = QuestionReference();

  @override
  Future<MResult<List<MQuestion>>> getAllQuestion() {
    return quizRef.getAllQuestions();
  }
}
