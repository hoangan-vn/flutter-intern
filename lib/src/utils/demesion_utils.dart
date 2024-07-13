
import 'package:safebump/src/feature/edit_profile/widget/item/base_ruler.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';

class DimensionUtils {
  static RulerValue createRulerValue(
      MeasurementUnitType unitType, RulerType rulerType) {
    switch (rulerType) {
      case RulerType.height:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return RulerValue(beginValue: 24, endValue: 96);
          case MeasurementUnitType.metric:
            return RulerValue(beginValue: 70, endValue: 250);
        }
      case RulerType.weight:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return RulerValue(beginValue: 0, endValue: 5500);
          case MeasurementUnitType.metric:
            return RulerValue(beginValue: 0, endValue: 2500);
        }
    }
  }

  // If other weight rulers in other screens is updated in the future,
  // remove this function and modify the createRulerValue function
  static RulerValue createAddManualWeightValue(MeasurementUnitType unitType) {
    switch (unitType) {
      case MeasurementUnitType.imperial:
        return RulerValue(beginValue: 110, endValue: 5500);
      case MeasurementUnitType.metric:
        return RulerValue(beginValue: 50, endValue: 2500);
    }
  }
}
