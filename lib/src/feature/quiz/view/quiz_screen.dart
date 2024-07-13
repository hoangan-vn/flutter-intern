import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/feature/quiz/logic/quiz_bloc.dart';
import 'package:safebump/src/feature/quiz/logic/quiz_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/quiz/quiz.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>().inital(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white3,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderAppBar(context),
          _renderListQuiz(context),
        ],
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBarDashboard(
      title: S.of(context).pregnancyPreparation,
      leading: IconButton(
        onPressed: () {
          AppCoordinator.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _renderListQuiz(BuildContext context) {
    return Expanded(
        child: BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) =>
          previous.status != current.status || previous.quizs != current.quizs,
      builder: (context, state) {
        return isNullOrEmpty(state.quizs)
            ? const SizedBox.shrink()
            : ListView.builder(
                itemCount: state.quizs!.length,
                itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: AppMargin.m10, horizontal: AppMargin.m16),
                      child: _renderQuizSection(context, state.quizs![index]),
                    ));
      },
    ));
  }

  Widget _renderQuizSection(BuildContext context, MQuiz mQuiz) {
    return Material(
      borderRadius: BorderRadius.circular(AppRadius.r10),
      clipBehavior: Clip.hardEdge,
      shadowColor: AppColors.black,
      elevation: 1,
      child: InkWell(
        onTap: () {
          context
              .read<QuizBloc>()
              .onTapQuiz(context, id: mQuiz.id, title: mQuiz.title);
        },
        child: Ink(
          padding: const EdgeInsets.all(AppPadding.p15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: AppColors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderImageQuiz(),
              XPaddingUtils.horizontalPadding(width: AppPadding.p10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderTitle(mQuiz.title),
                    XPaddingUtils.verticalPadding(height: AppPadding.p10),
                    _renderDescription(mQuiz.detail),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderTitle(String title) {
    return Text(title,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f16));
  }

  Widget _renderDescription(String summarize) {
    return Text(
      summarize,
      style: const TextStyle(
          fontFamily: FontFamily.abel,
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.f12,
          color: AppColors.hintTextColor),
    );
  }

  Widget _renderImageQuiz() {
    return Assets.images.images.logo.image(width: AppSize.s40);
  }
}
