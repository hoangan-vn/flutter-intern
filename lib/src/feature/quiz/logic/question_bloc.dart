import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/quiz/logic/question_state.dart';
import 'package:safebump/src/network/data/quiz/question/question_repository.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/utils/utils.dart';

class QuestionBloc extends Cubit<QuestionState> {
  QuestionBloc(String title)
      : super(QuestionState(
            listQuestion: List.empty(growable: true),
            titleQuiz: title,
            userAnswers: List.empty(growable: true)));

  Future<void> inital() async {
    _createLoadingScreen();
    await _getAllQuestionFromFirebase();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: QuestionStatus.fetching));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _getAllQuestionFromFirebase() async {
    try {
      final result = await GetIt.I.get<QuestionRepository>().getAllQuestion();
      if (isNullOrEmpty(result.data)) {
        emit(state.copyWith(status: QuestionStatus.fail));
        _hideLoadingScreen();
        return;
      }
      emit(state.copyWith(
        listQuestion: result.data,
        userAnswers: List.filled(result.data!.length, ''),
        status: QuestionStatus.success,
      ));
      _hideLoadingScreen();
    } catch (e) {
      xLog.e(e);
      _hideLoadingScreen();
      emit(state.copyWith(status: QuestionStatus.fail));
    }
  }

  void onTapAnswer(
      {required String userChoosenAnswer, required int questionNumber}) {
    emit(state.copyWith(status: QuestionStatus.changed));
    _setUserAnswer(userChoosenAnswer, questionNumber);
    emit(state.copyWith(status: QuestionStatus.success));
  }

  void _setUserAnswer(String userChoosenAnswer, int quesNumber) {
    List<String> listAnswer = state.userAnswers;
    listAnswer[quesNumber] = userChoosenAnswer;
    emit(state.copyWith(userAnswers: listAnswer));
  }

  onPreviousQuestion() {
    emit(state.copyWith(questionNumber: state.questionNumber - 1));
  }

  void onNextQuestion() {
    emit(state.copyWith(questionNumber: state.questionNumber + 1));
  }

  void finishQuiz(BuildContext context) {
    _calculateScore();
  }

  void _calculateScore() {
    int score = 0;
    for (int i = 0; i < state.listQuestion.length; i++) {
      if (state.listQuestion[i].correctAnswer.compareTo(state.userAnswers[i]) ==
          0) {
        score++;
      }
    }
    emit(state.copyWith(score: score));
  }

  Future<void> resetQuiz() async {
    AppCoordinator.pop();
    emit(
      state.copyWith(
          questionNumber: 1,
          listQuestion: List.empty(growable: true),
          userAnswers: List.empty(growable: true),
          status: QuestionStatus.init),
    );
    await inital();
  }
}
