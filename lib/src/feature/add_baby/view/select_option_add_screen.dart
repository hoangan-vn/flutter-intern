import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';

class SelectBabyOptionScreen extends StatelessWidget {
  const SelectBabyOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppPadding.p30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _renderCancelButton(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _renderHiMom(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p15),
                _renderQuestionText(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p45),
                _renderYesButton(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p15),
                _renderNoButton(context),
              ],
            ))
          ],
        ),
      )),
    );
  }

  Widget _renderYesButton(BuildContext context) {
    return XFillButton(
      onPressed: () => AppCoordinator.showAddBabyScreen(),
      label: Text(
        S.of(context).yes,
        style: const TextStyle(
            fontFamily: FontFamily.abel,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f20,
            color: AppColors.white),
      ),
      borderRadius: AppRadius.r30,
    );
  }

  Widget _renderNoButton(BuildContext context) {
    return XFillButton(
      onPressed: () => AppCoordinator.showAddPregnancyBabyScreen(),
      label: Text(S.of(context).no,
          style: const TextStyle(
              fontFamily: FontFamily.abel,
              fontWeight: FontWeight.w500,
              fontSize: AppFontSize.f20,
              color: AppColors.black)),
      borderRadius: AppRadius.r30,
      bgColor: AppColors.grey6,
    );
  }

  Widget _renderQuestionText(BuildContext context) {
    return Text(
      S.of(context).hasYourBabyBeenBorn,
      style: const TextStyle(
          fontFamily: FontFamily.inter, fontSize: AppFontSize.f16),
    );
  }

  Widget _renderHiMom(BuildContext context) {
    return Text(
      S.of(context).hiMom,
      style: const TextStyle(
          fontFamily: FontFamily.inter,
          fontWeight: FontWeight.w700,
          fontSize: AppFontSize.f30),
    );
  }

  Widget _renderCancelButton() {
    return IconButton(
        alignment: Alignment.centerRight,
        onPressed: () => AppCoordinator.pop(),
        icon: const Icon(
          Icons.clear,
          color: AppColors.black,
          size: AppSize.s30,
        ));
  }
}
