import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/baby_tracker/logic/baby_tracker_bloc.dart';
import 'package:safebump/src/feature/baby_tracker/logic/baby_tracker_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';

class PregnancyTrackerScreen extends StatefulWidget {
  const PregnancyTrackerScreen({super.key});

  @override
  State<PregnancyTrackerScreen> createState() => _PregnancyTrackerScreenState();
}

class _PregnancyTrackerScreenState extends State<PregnancyTrackerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PregnancyTrackerBloc>().inital();
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
          _renderListWeek(),
          _renderBodyScreen()
        ],
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBarDashboard(
      title: S.of(context).pregnancyTracker,
      leading: IconButton(
        onPressed: () {
          AppCoordinator.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _renderListWeek() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: AppMargin.m10),
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 40,
          itemBuilder: (context, index) => _renderWeekButton(index + 1)),
    );
  }

  Widget _renderWeekButton(int index) {
    return GestureDetector(
      onTap: () => context.read<PregnancyTrackerBloc>().onChangeWeek(index),
      child: BlocSelector<PregnancyTrackerBloc, PregnancyTrackerState, int>(
        selector: (state) {
          return state.selectedWeek;
        },
        builder: (context, week) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p10, vertical: AppPadding.p5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r30),
              border: Border.all(color: AppColors.primary, width: 0.75),
              color: week == index ? AppColors.primary : AppColors.white,
            ),
            child: Center(
              child: Text(
                '${S.of(context).week} $index',
                style: AppTextStyle.titleTextStyle.copyWith(
                    fontSize: AppFontSize.f14,
                    color: week == index ? AppColors.white : AppColors.primary),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _renderBodyScreen() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderImage(),
          _renderYourBabyText(),
          _renderYourBodyText(),
          _renderThingsToRememberText(),
        ],
      ),
    ));
  }

  Widget _renderImage() {
    return BlocBuilder<PregnancyTrackerBloc, PregnancyTrackerState>(
      buildWhen: (previous, current) =>
          previous.babyInforImage != current.babyInforImage,
      builder: (context, state) {
        return state.babyInforImage == null ||
                state.babyInforImage == Uint8List(0)
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r16),
                  child: Image.memory(
                    state.babyInforImage!,
                    fit: BoxFit.contain,
                  ),
                ),
              );
      },
    );
  }

  Widget _renderYourBabyText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p20),
      child: BlocBuilder<PregnancyTrackerBloc, PregnancyTrackerState>(
        buildWhen: (previous, current) =>
            previous.babyInfor != current.babyInfor,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _renderTitle(
                  title: S.of(context).yourBaby,
                  icon: Icons.baby_changing_station_rounded),
              ..._renderContent(context
                  .read<PregnancyTrackerBloc>()
                  .splitContentToParagraph(state.babyInfor?.data['yourBaby'])),
            ],
          );
        },
      ),
    );
  }

  Widget _renderTitle({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: AppSize.s24,
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p8),
        Text(
          title,
          style: AppTextStyle.titleTextStyle.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }

  List<Widget> _renderContent(List<String> content) {
    List<Widget> listContent = [];
    for (String text in content) {
      listContent.add(Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8, vertical: AppPadding.p5),
        child: Text(
          text,
          style: AppTextStyle.contentTexStyle,
        ),
      ));
    }
    return listContent;
  }

  Widget _renderYourBodyText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p20),
      child: BlocBuilder<PregnancyTrackerBloc, PregnancyTrackerState>(
        buildWhen: (previous, current) =>
            previous.babyInfor != current.babyInfor,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderTitle(
                  title: S.of(context).yourBody, icon: Icons.boy_rounded),
              ..._renderContent(context
                  .read<PregnancyTrackerBloc>()
                  .splitContentToParagraph(state.babyInfor?.data['yourBody'])),
            ],
          );
        },
      ),
    );
  }

  Widget _renderThingsToRememberText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p20),
      child: BlocBuilder<PregnancyTrackerBloc, PregnancyTrackerState>(
        buildWhen: (previous, current) =>
            previous.babyInfor != current.babyInfor,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _renderTitle(
                  title: S.of(context).thingsToRemember,
                  icon: Icons.remember_me),
              ..._renderContent(context
                  .read<PregnancyTrackerBloc>()
                  .splitContentToParagraph(
                      state.babyInfor?.data['thingsToRemember'])),
            ],
          );
        },
      ),
    );
  }
}
