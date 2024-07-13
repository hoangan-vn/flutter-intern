import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';

class XUnitSegmentWithTitle extends StatelessWidget {
  final String? title;
  final MeasurementUnitType? unitType;
  final String? metricText;
  final String? imperialText;
  final void Function(MeasurementUnitType?) onTap;
  const XUnitSegmentWithTitle(
      {Key? key,
      required this.unitType,
      required this.title,
      this.metricText,
      this.imperialText,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            fontFamily: FontFamily.abel,
            color: AppColors.grey,
            fontSize: AppFontSize.f16,
          ),
        ),
        SizedBox(
          width: 180,
          child: XUnitsSegment(
            metricText: metricText,
            imperialText: imperialText,
            isLoading: false,
            unitType: unitType,
            onTap: (MeasurementUnitType? value) {
              onTap(value!);
            },
            unselectedTextColor: AppColors.grey3,
          ),
        ),
      ],
    );
  }
}
