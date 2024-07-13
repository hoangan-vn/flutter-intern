import 'package:flutter/material.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';

class DailyQuizSection extends StatelessWidget {
  const DailyQuizSection(
      {super.key,
      required this.quiz,
      required this.isAnswer,
      this.isCorrect = false,
      this.correctPercent = 50,
      required this.onTapAnswer});
  final DailyQuiz quiz;
  final bool isAnswer;
  final Function(String) onTapAnswer;
  final bool isCorrect;
  final int correctPercent;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextStyle.hintTextStyle.copyWith(color: AppColors.primary),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m20),
        padding: const EdgeInsets.all(AppPadding.p15),
        decoration: BoxDecoration(
            boxShadow: AppDecorations.shadow,
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderTitleOfSection(context),
            isAnswer
                ? _renderResultSection(context)
                : _renderQuestionSection(context),
          ],
        ),
      ),
    );
  }

  Widget _renderTitleOfSection(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.question_answer_rounded,
          color: AppColors.primary,
          size: AppSize.s20,
        ),
        Text(S.of(context).testYourKnowledge),
      ],
    );
  }

  Widget _renderResultSection(BuildContext context) {
    return Column(
      children: [
        _renderIcon(),
        _renderComment(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p15),
        _renderPercentCorrect(context),
      ],
    );
  }

  Widget _renderQuestionSection(BuildContext context) {
    return Column(
      children: [
        _renderQuestion(),
        _renderListAnswers(),
      ],
    );
  }

  Widget _renderQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p15),
      child: Text(
        quiz.question,
        style: AppTextStyle.titleTextStyle
            .copyWith(color: AppColors.black, fontSize: AppFontSize.f20),
      ),
    );
  }

  Widget _renderListAnswers() {
    return Column(
      children: [
        for (int index = 0; index < quiz.answers.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p10),
            child: XFillButton(
                onPressed: () => onTapAnswer(quiz.answers[index]),
                bgColor: AppColors.white3,
                aligmentRowLabel: MainAxisAlignment.start,
                label: _renderAnswer(index)),
          )
      ],
    );
  }

  Widget _renderAnswer(int index) {
    return Expanded(
      child: Text(
        "${String.fromCharCodes([65 + index])}. ${quiz.answers[index]}",
        style: AppTextStyle.labelStyle.copyWith(fontSize: AppFontSize.f13),
      ),
    );
  }

  Widget _renderIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p15),
      child: isCorrect
          ? Assets.images.images.icCorrect.image(color: AppColors.green)
          : Assets.images.images.icWrong.image(),
    );
  }

  Widget _renderComment(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(
            fontFamily: FontFamily.abel,
            fontSize: AppFontSize.f20,
            color: isCorrect ? AppColors.green : AppColors.red,
            fontWeight: FontWeight.bold),
        child: isCorrect
            ? Text(S.of(context).amazing)
            : Text(S.of(context).dontWorry));
  }

  Widget _renderPercentCorrect(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _renderCorrectWidget(context),
        _renderWrongWidget(context),
      ],
    );
  }

  Widget _renderCorrectWidget(BuildContext context) {
    return correctPercent == 0
        ? const SizedBox.shrink()
        : Flexible(
            flex: correctPercent,
            child: Container(
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: 100 - correctPercent == 0
                      ? BorderRadius.circular(AppRadius.r10)
                      : const BorderRadius.only(
                          topLeft: Radius.circular(AppRadius.r10),
                          bottomLeft: Radius.circular(AppRadius.r10)),
                ),
                child: correctPercent < 20
                    ? const SizedBox.shrink()
                    : _renderPercentText(context, correctPercent)),
          );
  }

  Widget _renderWrongWidget(BuildContext context) {
    return 100 - correctPercent == 0
        ? const SizedBox.shrink()
        : Flexible(
            flex: 100 - correctPercent,
            child: Container(
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: correctPercent == 0
                      ? BorderRadius.circular(AppRadius.r10)
                      : const BorderRadius.only(
                          topRight: Radius.circular(AppRadius.r10),
                          bottomRight: Radius.circular(AppRadius.r10)),
                ),
                child: 100 - correctPercent < 20
                    ? const SizedBox.shrink()
                    : _renderPercentText(context, 100 - correctPercent)),
          );
  }

  Widget _renderPercentText(BuildContext context, int percent) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontFamily: FontFamily.abel, fontSize: AppFontSize.f20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(percent.toString()), Text(S.of(context).percent)],
      ),
    );
  }
}
