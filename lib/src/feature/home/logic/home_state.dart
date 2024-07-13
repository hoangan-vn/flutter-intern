import 'package:equatable/equatable.dart';
import 'package:safebump/src/network/model/baby/baby.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';

class HomeState with EquatableMixin {
  final DateTime selectedDate;
  final double? height;
  final double? weight;
  final String? babyFact;
  final bool hasBaby;
  final MBaby? baby;
  final String? weekCounter;
  final int? weekNumber;
  final bool isAnswerDailyQuiz;
  final DailyQuiz? quiz;
  final bool isAnswerCorrect;
  final int correctPercent;

  HomeState(
      {required this.selectedDate,
      this.height,
      this.weight,
      this.baby,
      this.babyFact,
      this.weekNumber,
      this.isAnswerDailyQuiz = false,
      this.quiz,
      this.weekCounter,
      this.correctPercent = 0,
      this.isAnswerCorrect = false,
      this.hasBaby = false});

  HomeState copyWith(
      {DateTime? selectedDate,
      double? height,
      double? weight,
      MBaby? baby,
      String? babyFact,
      String? weekCounter,
      bool? isAnswerDailyQuiz,
      bool? isAnswerCorrect,
      int? weekNumber,
      DailyQuiz? quiz,
      int? correctPercent,
      bool? hasBaby}) {
    return HomeState(
      selectedDate: selectedDate ?? this.selectedDate,
      hasBaby: hasBaby ?? this.hasBaby,
      baby: baby ?? this.baby,
      weekCounter: weekCounter ?? this.weekCounter,
      isAnswerDailyQuiz: isAnswerDailyQuiz ?? this.isAnswerDailyQuiz,
      quiz: quiz ?? this.quiz,
      weekNumber: weekNumber ?? this.weekNumber,
      correctPercent: correctPercent ?? this.correctPercent,
      isAnswerCorrect: isAnswerCorrect ?? this.isAnswerCorrect,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      babyFact: babyFact ?? this.babyFact,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
        height,
        weight,
        hasBaby,
        baby,
        babyFact,
        weekCounter,
        isAnswerDailyQuiz,
        quiz,
        isAnswerCorrect,
        correctPercent
      ];
}
