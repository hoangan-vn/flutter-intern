import 'package:safebump/src/network/model/quiz/question.dart';

enum QuestionStatus { init, fetching, fail, success, finish, changed }

class QuestionState {
  QuestionState(
      {this.score = 0,
      this.questionNumber = 1,
      this.status = QuestionStatus.init,
      required this.listQuestion,
      required this.titleQuiz,
      required this.userAnswers});

  final int score;
  final String titleQuiz;
  final int questionNumber;
  final QuestionStatus status;
  final List<MQuestion> listQuestion;
  final List<String> userAnswers;
  QuestionState copyWith(
      {int? score,
      int? questionNumber,
      QuestionStatus? status,
      String? titleQuiz,
      List<MQuestion>? listQuestion,
      List<String>? userAnswers}) {
    return QuestionState(
        score: score ?? this.score,
        questionNumber: questionNumber ?? this.questionNumber,
        status: status ?? this.status,
        titleQuiz: titleQuiz ?? this.titleQuiz,
        listQuestion: listQuestion ?? this.listQuestion,
        userAnswers: userAnswers ?? this.userAnswers);
  }

  @override
  String toString() {
    return 'QuestionState{score=$score, titleQuiz=$titleQuiz, questionNumber=$questionNumber, status=$status, listQuestion=$listQuestion, userAnswers=$userAnswers}';
  }
}
