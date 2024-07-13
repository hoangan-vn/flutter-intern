import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/dialogs/alert_wrapper.dart';
import 'package:safebump/src/dialogs/widget/alert_dialog.dart';
import 'package:safebump/src/feature/quiz/logic/question_bloc.dart';
import 'package:safebump/src/feature/quiz/logic/question_state.dart';
import 'package:safebump/src/feature/quiz/widget/question_page.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/button/fill_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    context.read<QuestionBloc>().inital();
    _controller = PageController();
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
          _renderQuestion(context),
          _renderButton(context),
        ],
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      buildWhen: (previous, current) => previous.titleQuiz != current.titleQuiz,
      builder: (context, state) {
        return XAppBarDashboard(
          title: state.titleQuiz,
          leading: IconButton(
            onPressed: () {
              AppCoordinator.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        );
      },
    );
  }

  Widget _renderQuestion(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          switch (state.status) {
            case QuestionStatus.fail:
              return _renderFailFetchQuestion();
            case QuestionStatus.success:
            case QuestionStatus.changed:
              return _renderQuestionPage(state);
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    ));
  }

  Widget _renderFailFetchQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svg.emptyIllustratiom.svg(),
          Text(
            S.of(context).someThingWentWrong,
            style: const TextStyle(
                fontFamily: FontFamily.abel,
                fontSize: AppFontSize.f20,
                color: AppColors.black),
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p16),
          XFillButton(
              onPressed: () => AppCoordinator.pop(),
              label: Text(
                S.of(context).back,
                style: const TextStyle(
                  fontFamily: FontFamily.productSans,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.f20,
                  color: AppColors.white,
                ),
              )),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderQuestionPage(QuestionState state) {
    return PageView.builder(
        itemCount: state.listQuestion.length,
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => XQuestionPage(
              question: state.listQuestion[index],
              userAnswer: state.userAnswers[index],
              onTapAnswer: (answer) {
                context.read<QuestionBloc>().onTapAnswer(
                    userChoosenAnswer: answer, questionNumber: index);
              },
              numberQuestion: index + 1,
              totalQuestion: state.listQuestion.length,
            ));
  }

  Widget _renderButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p30),
      child: BlocBuilder<QuestionBloc, QuestionState>(
        buildWhen: (previous, current) =>
            previous.userAnswers != current.userAnswers ||
            previous.questionNumber != current.questionNumber ||
            previous.status != current.status,
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderPreviousQuestion(state),
              XPaddingUtils.horizontalPadding(width: AppFontSize.f16),
              _renderNextQuestion(state)
            ],
          );
        },
      ),
    );
  }

  Widget _renderPreviousQuestion(QuestionState state) {
    if (state.questionNumber == 1) {
      return const SizedBox.shrink();
    }
    return Expanded(
      child: XFillButton(
          onPressed: () {
            _controller.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.linear);
            context.read<QuestionBloc>().onPreviousQuestion();
          },
          bgColor: AppColors.white,
          border: const BorderSide(),
          label: Text(
            S.of(context).previous,
            style: AppTextStyle.buttonTextStylePrimary
                .copyWith(color: AppColors.black),
          )),
    );
  }

  Widget _renderNextQuestion(QuestionState state) {
    return Expanded(
      child: XFillButton(
          onPressed: () {
            if (state.questionNumber == state.listQuestion.length) {
              context.read<QuestionBloc>().finishQuiz(context);
              _showResultPopup(context);
            } else {
              _controller.nextPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.linear);
              context.read<QuestionBloc>().onNextQuestion();
            }
          },
          bgColor: state.userAnswers.isEmpty ||
                  StringUtils.isNullOrEmpty(
                      state.userAnswers[state.questionNumber - 1])
              ? AppColors.hintTextColor
              : AppColors.primary,
          label: Text(
            state.questionNumber == state.listQuestion.length
                ? S.of(context).finish
                : S.of(context).next,
            style: AppTextStyle.buttonTextStylePrimary,
          )),
    );
  }

  void _showResultPopup(BuildContext context) {
    final state = context.read<QuestionBloc>().state;
    XAlert.showCustomAlert(
        title: _renderTitle(context),
        body: _renderResultScore(context, state),
        actions: [
          XAlertButton(
              child: XFillButton(
            onPressed: () => context.read<QuestionBloc>().resetQuiz(),
            label: Text(
              S.of(context).doTheTestAgain,
              style: const TextStyle(
                  fontFamily: FontFamily.productSans,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
          )),
          XAlertButton(
              child: XFillButton(
            onPressed: () {
              AppCoordinator.pop();
              AppCoordinator.pop();
            },
            bgColor: AppColors.grey6,
            label: Text(
              S.of(context).maybeLater,
              style: const TextStyle(
                  fontFamily: FontFamily.productSans,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
            ),
          )),
        ]);
  }

  Widget _renderTitle(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.images.images.icCorrect.image(),
        XPaddingUtils.verticalPadding(height: AppPadding.p15),
        Text(
          S.of(context).testComplete,
          style: const TextStyle(
              fontFamily: FontFamily.abel,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: AppFontSize.f20),
        )
      ],
    );
  }

  Widget _renderResultScore(BuildContext context, QuestionState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          S.of(context).yourResult,
          style: const TextStyle(
            fontFamily: FontFamily.abel,
            color: AppColors.grey,
          ),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        Text(
          "${state.score} / ${state.listQuestion.length}",
          style: const TextStyle(
              fontFamily: FontFamily.inter,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: AppFontSize.f20),
        )
      ],
    );
  }
}
