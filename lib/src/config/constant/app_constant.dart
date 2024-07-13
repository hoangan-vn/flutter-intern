import 'package:flutter/material.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/config/enum/medication_enum.dart';
import 'package:safebump/src/network/model/baby_fact_model.dart';
import 'package:safebump/src/network/model/extension_model.dart';
import 'package:safebump/src/network/model/on_boarding_model.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/route_name.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/datetime_utils.dart';

class AppConstant {
  static List<OnBoardingModel> getListDataOfOnBoarding(BuildContext context) =>
      <OnBoardingModel>[
        OnBoardingModel(
            fistTitle: S.of(context).safe,
            secondTitle: S.of(context).bump,
            image: Assets.images.images.welcomeSafebump.path,
            content: S.of(context).welcomeToSafeBump),
        OnBoardingModel(
            fistTitle: S.of(context).tracking,
            secondTitle: S.of(context).tools,
            image: Assets.images.images.provideTracking.path,
            content: S.of(context).theAppWillProvideTracking),
        OnBoardingModel(
            fistTitle: S.of(context).educational,
            secondTitle: S.of(context).resources,
            image: Assets.images.images.proviceEducational.path,
            content: S.of(context).theAppWillProvideEducational),
        OnBoardingModel(
            fistTitle: S.of(context).community,
            secondTitle: S.of(context).support,
            image: Assets.images.images.provideCommunity.path,
            content: S.of(context).theAppWillProvideACommunity),
        OnBoardingModel(
            fistTitle: S.of(context).appointment,
            secondTitle: S.of(context).scheduler,
            image: Assets.images.images.scheduleManager.path,
            content: S.of(context).theAppWillAllowUser),
      ];

  static List<ExtensionModel> getListExtensionData(BuildContext context) => [
        ExtensionModel(
            label: S.of(context).medicines,
            routeName: AppRouteNames.medication.name,
            icon: Icons.medical_information),
        ExtensionModel(
            label: S.of(context).quiz,
            routeName: AppRouteNames.quiz.name,
            icon: Icons.quiz),
        ExtensionModel(
            label: S.of(context).articles,
            routeName: AppRouteNames.articles.name,
            icon: Icons.article),
        ExtensionModel(
            label: S.of(context).videos,
            routeName: AppRouteNames.videos.name,
            icon: Icons.video_collection_rounded),
      ];

  static Map<DateTime, BabyFactModel> getBabyFactsData() {
    final pergnancyDate =
        DateTimeUtils.convertToStartedDay(UserPrefs.I.getPergnancyDay());
    Map<DateTime, BabyFactModel> babyFacts = {};
    for (int week = 1; week <= 42; week++) {
      for (int dayInWeek = 1; dayInWeek <= 7; dayInWeek++) {
        if (week < 8) {
          babyFacts.addEntries({
            pergnancyDate.subtract(
                    Duration(days: 295 - ((week - 1) * 7 + dayInWeek))):
                BabyFactModel(
              fact: S.text.yourFetalInformationCannot,
              height: 0,
              weight: 0,
              daysLeft: 295 - ((week - 1) * 7 + dayInWeek),
            ),
          }.entries);
          continue;
        }
        babyFacts.addEntries({
          pergnancyDate
                  .subtract(Duration(days: 295 - ((week - 1) * 7 + dayInWeek))):
              BabyFactModel(
            fact: S.text.yourBabySizeofpear,
            height: dayInWeek * week,
            weight: dayInWeek * week,
            daysLeft: 295 - ((week - 1) * 7 + dayInWeek),
          )
        }.entries);
      }
    }
    return babyFacts;
  }

  static List<DropdownMenuItem<Gender>> getListGender(BuildContext context) => [
        DropdownMenuItem(
          value: Gender.male,
          child: Text(
            Gender.male.getBabyGenderText(context),
          ),
        ),
        DropdownMenuItem(
          value: Gender.female,
          child: Text(
            Gender.female.getBabyGenderText(context),
          ),
        ),
      ];

  static final List<DoseType> medicationUnitList = [
    DoseType.spoon,
    DoseType.cap,
    DoseType.drop,
    DoseType.application,
    DoseType.patch,
    DoseType.spray,
    DoseType.puff,
    DoseType.suppository,
    DoseType.pill,
    DoseType.packet,
    DoseType.injection,
    DoseType.gram,
    DoseType.miligram,
    DoseType.mililiter,
    DoseType.unit,
    DoseType.piece,
  ];
}
