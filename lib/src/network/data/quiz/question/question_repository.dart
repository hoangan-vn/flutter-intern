import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/quiz/question.dart';

abstract class QuestionRepository {
  Future<MResult<List<MQuestion>>> getAllQuestion();
}
