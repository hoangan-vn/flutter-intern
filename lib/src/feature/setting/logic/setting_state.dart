import 'package:safebump/src/config/enum/language_enum.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';

class SettingsState {
  SettingsState({
    this.measurementUnitType = MeasurementUnitType.metric,
    this.language = LanguageEnum.english,
  });

  final MeasurementUnitType measurementUnitType;
  final LanguageEnum language;

  SettingsState copyWith(
      {MeasurementUnitType? measurementUnitType, LanguageEnum? language}) {
    return SettingsState(
        measurementUnitType: measurementUnitType ?? this.measurementUnitType,
        language: language ?? this.language);
  }
}
