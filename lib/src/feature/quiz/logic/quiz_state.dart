import 'package:safebump/src/network/model/quiz/quiz.dart';

enum QuizStatus { init, loading, success, fail }

class QuizState {
  QuizState({this.status = QuizStatus.init, this.quizs});

  final QuizStatus status;
  final List<MQuiz>? quizs;
  QuizState copyWith({QuizStatus? status, List<MQuiz>? quizs}) {
    return QuizState(
      status: status ?? this.status,
      quizs: quizs ?? this.quizs,
    );
  }
}
