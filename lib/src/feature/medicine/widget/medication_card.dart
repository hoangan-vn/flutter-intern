import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';

class XMedicationCard extends StatelessWidget {
  const XMedicationCard(
      {super.key,
      required this.medicationName,
      required this.medicationUnit,
      required this.onEditMedication,
      required this.onDeleteMedication});
  final String medicationName;
  final String medicationUnit;
  final Function onEditMedication;
  final Function onDeleteMedication;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        Material(
          elevation: 1,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(AppRadius.r10),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            onTap: () => onEditMedication(),
            child: Ink(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p5, horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r10),
                color: AppColors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _renderMedicationImage(),
                  XPaddingUtils.horizontalPadding(width: AppPadding.p12),
                  Expanded(
                    child: _renderMedicationInfo(),
                  ),
                  IconButton(
                      onPressed: () => onDeleteMedication(),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: AppColors.red,
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderMedicationImage() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        color: AppColors.subPrimary,
      ),
      child: const Icon(
        Icons.medication_rounded,
        color: AppColors.black,
        size: AppSize.s36,
      ),
    );
  }

  Widget _renderMedicationInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          medicationName,
          style: AppTextStyle.labelStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p5),
        Text(
          medicationUnit,
          style: AppTextStyle.hintTextStyle.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
