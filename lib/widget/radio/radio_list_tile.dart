import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';

class XRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  const XRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onChanged(value);
      },
      child: SizedBox(
        height: AppSize.s40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _customRadioButton,
            XPaddingUtils.horizontalPadding(width: AppPadding.p12),
            Text(
              label,
              style: value == groupValue
                  ? AppTextStyle.labelStyle
                      .copyWith(fontWeight: FontWeight.bold)
                  : AppTextStyle.contentTexStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    return Container(
      width: AppSize.s16,
      height: AppSize.s16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        border: Border.all(
          color: AppColors.primary,
          width: value == groupValue ? AppSize.s4 : AppSize.s1,
        ),
      ),
    );
  }
}
