import 'package:flutter/material.dart';
import 'package:safebump/src/feature/edit_profile/widget/item/ruler.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/demesion_utils.dart';
import 'package:safebump/src/utils/measurement_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';

class XRulerBottomSheet extends StatefulWidget {
  const XRulerBottomSheet({
    Key? key,
    required this.value,
    required this.rulerType,
    required this.measurementUnitType,
  }) : super(key: key);
  final double value;
  final RulerType rulerType;
  final MeasurementUnitType measurementUnitType;

  @override
  State<XRulerBottomSheet> createState() => _XRulerBottomSheetState();
}

class _XRulerBottomSheetState extends State<XRulerBottomSheet> {
  int _currentValue = 0;
  @override
  void initState() {
    super.initState();
    var value = 0;
    if (widget.rulerType == RulerType.weight) {
      value = widget.measurementUnitType == MeasurementUnitType.metric
          ? widget.value.toKilogram().round()
          : widget.value.round();
    } else {
      value = widget.measurementUnitType == MeasurementUnitType.metric
          ? widget.value.toCentimeter().round()
          : widget.value.round();
    }
    _currentValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: AppMargin.m24),
                  child: RulerCT(
                    rulerType: widget.rulerType,
                    unitType: widget.measurementUnitType,
                    key: UniqueKey(),
                    initValue: _currentValue,
                    rulerValue: DimensionUtils.createRulerValue(
                        widget.measurementUnitType, widget.rulerType),
                    onValueChange: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  )),
              Container(
                padding: const EdgeInsets.only(
                  left: AppPadding.p16,
                  right: AppPadding.p16,
                  bottom: AppPadding.p16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r8),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: AppColors.primary))),
                        child: Text(S.of(context).cancel,
                            style: AppTextStyle.buttonTextStylePrimary
                                .copyWith(color: AppColors.primary)),
                        onPressed: () {
                          AppCoordinator.pop();
                        },
                      ),
                    ),
                    const SizedBox(width: AppSize.s16),
                    Expanded(
                      child: XFillButton(
                        label: Text(
                          S.of(context).done,
                          style: AppTextStyle.buttonTextStylePrimary,
                        ),
                        onPressed: () {
                          AppCoordinator.pop(_currentValue);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
