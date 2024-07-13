import 'package:flutter/widgets.dart';
import 'package:safebump/src/localization/localization_utils.dart';

enum BabyType {
  baby,
  fetus;

  BabyType getBabyTypeEnum(String type) {
    switch (type) {
      case 'baby':
        return BabyType.baby;
      case 'fetus':
      default:
        return BabyType.fetus;
    }
  }

  String getBabyTypeText() {
    switch (this) {
      case BabyType.baby:
        return 'baby';
      case BabyType.fetus:
        return 'fetus';
    }
  }
}

enum Gender {
  male,
  female;

  Gender getBabyGenderEnum(String type) {
    switch (type) {
      case 'Male':
        return Gender.male;
      case 'Female':
      default:
        return Gender.female;
    }
  }

  String getBabyGenderText(BuildContext context) {
    switch (this) {
      case Gender.male:
        return S.of(context).male;
      case Gender.female:
        return S.of(context).female;
    }
  }
}
