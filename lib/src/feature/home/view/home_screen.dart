import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/config/constant/app_constant.dart';
import 'package:safebump/src/feature/account/bloc/account_bloc.dart';
import 'package:safebump/src/feature/account/bloc/account_state.dart';
import 'package:safebump/src/feature/home/logic/home_bloc.dart';
import 'package:safebump/src/feature/home/logic/home_state.dart';
import 'package:safebump/src/feature/home/widget/daily_quiz/daily_quiz_section.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/datetime_utils.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/button/circle_button.dart';
import 'package:safebump/widget/button/fill_button.dart';
import 'package:safebump/widget/list_view/day_of_week_list_view.dart';
import 'package:safebump/widget/separator/solid_separator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().initData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: AppColors.white4,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: BlocSelector<HomeBloc, HomeState, bool>(
            selector: (state) {
              return state.hasBaby;
            },
            builder: (context, hasBaby) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderAppbar(context),
                  _renderHelloUser(context),
                  hasBaby ? _renderListWeek(context) : const SizedBox.shrink(),
                  hasBaby
                      ? _renderBabySection(context)
                      : _renderEmptyBaby(context),
                  _renderDailyQuizSection(context),
                  _renderExtensionSection(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _renderAppbar(BuildContext context) {
    return XAppBarDashboard(
      leading: Assets.images.images.logo.image(height: AppSize.s30),
      action: _renderNotyIcon(),
      title: S.of(context).home,
    );
  }

  Widget _renderNotyIcon() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications_active_outlined,
          size: AppSize.s20,
        ));
  }

  Widget _renderHelloUser(BuildContext context) {
    return BlocSelector<AccountBloc, AccountState, MUser?>(
      selector: (state) {
        return state.account;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppPadding.p10),
          child: Text(
            "${S.of(context).hello} ${state?.name}",
            style: const TextStyle(
                fontFamily: FontFamily.productSans,
                fontSize: AppFontSize.f12,
                color: AppColors.hintTextColor),
          ),
        );
      },
    );
  }

  Widget _renderListWeek(BuildContext context) {
    final today = DateTime.now();
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedDate.compareTo(current.selectedDate) != 0 ||
          previous.weekCounter != current.weekCounter,
      builder: (context, state) {
        return XDayOfWeekListView(
          week: state.weekCounter,
          listDayOfWeek: DateTimeUtils.createWeekOfToday(
              DateTimeUtils.convertToStartedDay(today)),
          today: DateTimeUtils.convertToStartedDay(today),
          selectedDay: state.selectedDate,
          onTappedDay: (date) =>
              context.read<HomeBloc>().onChangedSelectedDate(date),
        );
      },
    );
  }

  Widget _renderBabySection(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontFamily: FontFamily.abel,
          fontSize: AppFontSize.f14,
          color: AppColors.hintTextColor),
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.babyFact != current.babyFact ||
            previous.height != current.height ||
            previous.weight != current.weight ||
            previous.selectedDate.compareTo(current.selectedDate) != 0,
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m20),
            padding: const EdgeInsets.all(AppPadding.p15),
            decoration: BoxDecoration(
                boxShadow: AppDecorations.shadow,
                borderRadius: BorderRadius.circular(AppRadius.r10),
                color: AppColors.white),
            child: Column(
              children: [
                _renderBabyFact(context, state.babyFact),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderBabyInfor(
                  context,
                  height: state.height,
                  weight: state.weight,
                  daysLeft: state.selectedDate
                      .difference(state.baby?.date ?? DateTime.now())
                      .inDays
                      .abs(),
                ),
                XPaddingUtils.verticalPadding(height: AppPadding.p8),
                const XSolidSeparator(
                  color: AppColors.grey5,
                  height: 0.5,
                ),
                XPaddingUtils.verticalPadding(height: AppPadding.p8),
                _renderBabyTrackerButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _renderBabyFact(BuildContext context, String? content) {
    return Row(children: [
      _renderBabyIcon(),
      XPaddingUtils.horizontalPadding(width: AppPadding.p20),
      _renderBabyFactContent(context, content)
    ]);
  }

  Widget _renderBabyIcon() {
    return Container(
      width: AppSize.s60,
      height: AppSize.s60,
      decoration: BoxDecoration(
          color: AppColors.subPrimary,
          borderRadius: BorderRadius.circular(AppRadius.r30)),
      child: const Center(
        child: Icon(
          Icons.child_care_outlined,
          color: AppColors.primary,
          size: AppSize.s30,
        ),
      ),
    );
  }

  Widget _renderBabyFactContent(BuildContext context, String? content) {
    return Expanded(child: Text(content ?? ""));
  }

  Widget _renderBabyInfor(BuildContext context,
      {double? height, double? weight, int? daysLeft}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _renderInforData(context,
            titleInfor: S.of(context).babyHeight,
            dataInfor: height ?? 0.0,
            unit: S.of(context).cm),
        _renderInforData(context,
            titleInfor: S.of(context).babyWeight,
            dataInfor: weight ?? 0.0,
            unit: S.of(context).gr),
        _renderInforData(context,
            titleInfor: S.of(context).daysLeft,
            dataInfor: daysLeft ?? 0.0,
            unit: S.of(context).days),
      ],
    );
  }

  Widget _renderInforData(BuildContext context,
      {required String titleInfor,
      required dynamic dataInfor,
      required String unit}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          titleInfor,
          style: const TextStyle(fontSize: AppFontSize.f12),
        ),
        Text(
          StringUtils.createDataWithUnit(
              data: dataInfor.toString(), unit: unit),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _renderExtensionSection(BuildContext context) {
    return SizedBox(
      height: 360,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppPadding.p10,
            crossAxisSpacing: AppPadding.p10),
        itemBuilder: (context, index) => _renderExtensionButton(
          context,
          label: AppConstant.getListExtensionData(context)[index].label,
          icon: AppConstant.getListExtensionData(context)[index].icon,
          routeName: AppConstant.getListExtensionData(context)[index].routeName,
        ),
        itemCount: AppConstant.getListExtensionData(context).length,
      ),
    );
  }

  Widget _renderExtensionButton(BuildContext context,
      {required String label,
      required IconData icon,
      required String routeName}) {
    return GestureDetector(
      onTap: () => AppCoordinator.showExtensionScreen(routeName),
      child: Container(
        height: AppSize.s123,
        decoration: BoxDecoration(
          boxShadow: AppDecorations.shadow,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              size: AppSize.s30,
              color: AppColors.primary,
            ),
            XPaddingUtils.verticalPadding(height: AppPadding.p10),
            Text(
              label,
              style: const TextStyle(fontFamily: FontFamily.abel),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderEmptyBaby(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontFamily: FontFamily.abel,
          fontSize: AppFontSize.f14,
          color: AppColors.hintTextColor),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m20),
        padding: const EdgeInsets.all(AppPadding.p15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            boxShadow: AppDecorations.shadow,
            color: AppColors.white),
        child: Row(
          children: [
            _renderAddBabyButton(),
            XPaddingUtils.horizontalPadding(width: AppPadding.p10),
            _renderAddBabyText(context),
          ],
        ),
      ),
    );
  }

  Widget _renderAddBabyButton() {
    return XCircleButton(
      onTapped: () {
        AppCoordinator.showOptionsAddBaby().then((value) {
          if (value) {
            context.read<HomeBloc>().initData(context);
          }
        });
      },
      color: AppColors.subPrimary,
      iconColor: AppColors.primary,
      buttonSize: AppSize.s48,
    );
  }

  Widget _renderAddBabyText(BuildContext context) {
    return Expanded(child: Text(S.of(context).pleaseAddYourBaby));
  }

  Widget _renderDailyQuizSection(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isAnswerDailyQuiz != current.isAnswerDailyQuiz ||
          previous.quiz != current.quiz ||
          previous.isAnswerCorrect != current.isAnswerCorrect ||
          previous.correctPercent != current.correctPercent,
      builder: (context, state) {
        return DailyQuizSection(
          quiz: state.quiz ?? DailyQuiz.empty(),
          isAnswer: state.isAnswerDailyQuiz,
          correctPercent: state.correctPercent,
          isCorrect: state.isAnswerCorrect,
          onTapAnswer: (userAnswer) {
            context.read<HomeBloc>().onTapAnswerButton(userAnswer);
          },
        );
      },
    );
  }

  Widget _renderBabyTrackerButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        XFillButton(
          borderRadius: AppRadius.r30,
          onPressed: () => AppCoordinator.showBabyTrackerScreen(
              (context.read<HomeBloc>().state.weekNumber ?? 2).toString()),
          label: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              S.of(context).pregnancyTracker,
              style: AppTextStyle.buttonTextStylePrimary
                  .copyWith(fontSize: AppFontSize.f13),
            ),
            XPaddingUtils.horizontalPadding(width: AppPadding.p5),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.white,
              size: AppSize.s16,
            )
          ]),
        ),
      ],
    );
  }
}
