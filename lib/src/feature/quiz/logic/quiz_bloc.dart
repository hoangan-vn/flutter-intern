import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/quiz/logic/quiz_state.dart';
import 'package:safebump/src/network/data/quiz/question/question_repository.dart';
import 'package:safebump/src/network/data/quiz/question/question_repository_impl.dart';
import 'package:safebump/src/network/data/quiz/quiz_repository.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/utils.dart';

class QuizBloc extends Cubit<QuizState> {
  QuizBloc() : super(QuizState());

  Future<void> inital(BuildContext context) async {
    _createLoadingScreen();
    await _getAllQuizFromFirebase(context);
    _hideLoadingScreen();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: QuizStatus.loading));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _getAllQuizFromFirebase(BuildContext context) async {
    try {
      final result = await GetIt.I.get<QuizRepository>().getAllQuiz();
      if (result.data == null) {
        emit(state.copyWith(status: QuizStatus.fail));
        return;
      }
      emit(state.copyWith(quizs: result.data, status: QuizStatus.success));
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: QuizStatus.fail));
    }
  }

  Future<void> onTapQuiz(BuildContext context,
      {required String id, required String title}) async {
    await UserPrefs.I.setSelectedQuizId(id);
    await _resetQuestionSingleton();
    AppCoordinator.showQuestionQuizScreen(title);
  }

  Future<void> _resetQuestionSingleton() async {
    try {
      await GetIt.I.resetLazySingleton<QuestionRepository>();
    } catch (e) {
      xLog.e(e);
      GetIt.I.registerLazySingleton<QuestionRepository>(
          (() => QuestionRepositoryImpl()));
    }
  }
}
