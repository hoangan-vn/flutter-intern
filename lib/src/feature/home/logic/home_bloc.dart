import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/feature/home/logic/home_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/baby_infor_fact/baby_infor_fact_local_repo.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo.dart';
import 'package:safebump/src/network/data/daily_quiz/daily_quiz_repository.dart';
import 'package:safebump/src/network/model/baby/baby.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/datetime_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc()
      : super(HomeState(
            selectedDate: DateTimeUtils.convertToStartedDay(DateTime.now())));

  void initData(BuildContext context) {
    _hasBabyInfor();
    _checkDailyQuiz();
  }

  void onChangedSelectedDate(DateTime date) {
    emit(state.copyWith(selectedDate: DateTimeUtils.convertToStartedDay(date)));
  }

  Future<void> _hasBabyInfor() async {
    final babyLocalRepo = GetIt.I.get<BabyInforLocalRepo>();
    final babyLocal = await babyLocalRepo.getAllDetails().get();
    if (babyLocal.isEmpty) {
      emit(state.copyWith(hasBaby: false));
      return;
    }
    _setBabyInfor(babyLocal.first);
    emit(state.copyWith(hasBaby: true));
  }

  void _setBabyInfor(BabyInforEntityData babyLocal) {
    emit(state.copyWith(
        baby: MBaby(
      id: babyLocal.id,
      name: babyLocal.name,
      type: babyLocal.type,
      date: babyLocal.date,
      gender: babyLocal.gender,
      weight: babyLocal.weight,
      height: babyLocal.height,
    )));
    _getWeekCounter();
  }

  void _getWeekCounter() {
    String weekCounter;
    int weekNumber = DateTimeUtils.calculateWeekNumberOfPregnancy(
      state.baby!.date!.subtract(const Duration(days: 280)),
    );
    weekNumber = weekNumber == 0 ? 1 : weekNumber;

    switch (weekNumber % 10) {
      case 1:
        weekCounter = "${weekNumber}st ";
      case 2:
        weekCounter = "${weekNumber}nd ";
      case 3:
        weekCounter = "${weekNumber}rd ";
      default:
        weekCounter = "${weekNumber}th ";
    }
    emit(state.copyWith(weekCounter: weekCounter, weekNumber: weekNumber));
    _getBabyFact(weekNumber);
  }

  Future<void> _checkDailyQuiz() async {
    if (_isAnwserDailyQuiz()) return;
    try {
      final result = await GetIt.I.get<DailyQuizRepository>().getNewDailyQuiz();
      if (result.data == null) {
        emit(state.copyWith(quiz: DailyQuiz.empty()));
        return;
      }
      emit(state.copyWith(quiz: result.data));
    } catch (e) {
      emit(state.copyWith(quiz: DailyQuiz.empty()));
      xLog.e(e);
    }
  }

  bool _isAnwserDailyQuiz() {
    final isAnswer = UserPrefs.I.getDoDailyQuiz();
    _checkIsUserCorrect();
    _getPercentCorrectAnswer();
    emit(state.copyWith(isAnswerDailyQuiz: isAnswer));
    return isAnswer;
  }

  void _checkIsUserCorrect() {
    emit(state.copyWith(isAnswerCorrect: UserPrefs.I.getIsUserCorrect()));
  }

  void _getPercentCorrectAnswer() {
    emit(state.copyWith(
        correctPercent: UserPrefs.I.getPercentCorrectDailyQuiz()));
  }

  void onTapAnswerButton(String userAnswer) {
    if (state.quiz == null) return;
    emit(state.copyWith(isAnswerDailyQuiz: true));
    DailyQuiz quiz =
        state.quiz!.copyWith(totalAnswer: state.quiz!.totalAnswer + 1);
    if (userAnswer == state.quiz!.correctAnswer) {
      _setUserIsCorrect(true);
      emit(state.copyWith(
          quiz: quiz.copyWith(numberUserCorrect: quiz.numberUserCorrect + 1)));
      _caculateCorrectPercent();
      _syncAnswerToServer(state.quiz!);
      _updateUserSharePref();
      return;
    }
    _setUserIsCorrect(false);
    emit(state.copyWith(quiz: quiz));
    _syncAnswerToServer(state.quiz!);
    _caculateCorrectPercent();
    _updateUserSharePref();
  }

  void _setUserIsCorrect(bool isCorrect) {
    emit(state.copyWith(isAnswerCorrect: isCorrect));
  }

  void _caculateCorrectPercent() {
    final correctPercent =
        (state.quiz!.numberUserCorrect / state.quiz!.totalAnswer) * 100;
    emit(state.copyWith(correctPercent: correctPercent.toInt()));
  }

  void _syncAnswerToServer(DailyQuiz quiz) async {
    try {
      await GetIt.I.get<DailyQuizRepository>().saveUsersAnswer(quiz);
    } catch (e) {
      xLog.e(e);
    }
  }

  void _updateUserSharePref() {
    UserPrefs.I.setDoDailyQuiz(true);
    UserPrefs.I.setIsUserCorrect(state.isAnswerCorrect);
    UserPrefs.I.setPercentCorrectDailyQuiz(state.correctPercent);
  }

  Future<void> _getBabyFact(int weekNumber) async {
    try {
      final babyFactInWeek = await GetIt.I
          .get<BabyInforFactLocalRepo>()
          .getDetailFollowWeek(week: weekNumber)
          .get();
      if (isNullOrEmpty(babyFactInWeek)) return;
      emit(state.copyWith(
          babyFact: babyFactInWeek.first.fact,
          height: babyFactInWeek.first.height,
          weight: babyFactInWeek.first.weight));
    } catch (e) {
      xLog.e(e);
    }
  }
}
