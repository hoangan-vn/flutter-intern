import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';

enum MeasurementUnitType {
  imperial,
  metric;

  String getText() {
    switch (this) {
      case MeasurementUnitType.imperial:
        return 'imperial';
      case MeasurementUnitType.metric:
        return 'metric';
    }
  }

  static MeasurementUnitType getType(String type) {
    switch (type) {
      case 'imperial':
        return MeasurementUnitType.imperial;
      case 'metric':
      default:
        return MeasurementUnitType.metric;
    }
  }
}

enum RulerType { height, weight }

class XUnitsSegment extends StatelessWidget {
  final MeasurementUnitType? unitType;
  final void Function(MeasurementUnitType?) onTap;
  final String? metricText;
  final String? imperialText;
  final Color? unselectedTextColor;
  final bool isLoading;
  const XUnitsSegment({
    Key? key,
    this.metricText,
    this.imperialText,
    required this.unitType,
    required this.onTap,
    this.unselectedTextColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<MeasurementUnitType>(
      backgroundColor: AppColors.grey6,
      thumbColor: AppColors.white,
      groupValue: unitType,
      padding: const EdgeInsets.all(AppPadding.p6),
      children: <MeasurementUnitType, Widget>{
        MeasurementUnitType.imperial: SizedBox(
          height: AppSize.s36,
          child: Center(
            child: isLoading && unitType == MeasurementUnitType.imperial
                ? const SizedBox(
                    width: AppSize.s20,
                    height: AppSize.s20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Text(
                    imperialText ?? S.of(context).imperial,
                    style: TextStyle(
                        fontFamily: FontFamily.inter,
                        fontSize: AppFontSize.f16,
                        color: unitType == MeasurementUnitType.imperial
                            ? AppColors.primary
                            : unselectedTextColor ?? AppColors.grey2),
                  ),
          ),
        ),
        MeasurementUnitType.metric: SizedBox(
          height: AppSize.s36,
          child: Center(
            child: isLoading && unitType == MeasurementUnitType.metric
                ? const SizedBox(
                    width: AppSize.s20,
                    height: AppSize.s20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Text(
                    metricText ?? S.of(context).metric,
                    style: TextStyle(
                        fontFamily: FontFamily.inter,
                        fontSize: AppFontSize.f16,
                        color: unitType == MeasurementUnitType.metric
                            ? AppColors.primary
                            : unselectedTextColor ?? AppColors.grey2),
                  ),
          ),
        ),
      },
      onValueChanged: onTap,
    );
  }
}
