import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_utils.dart';

class XDropdownButton<T> extends StatelessWidget {
  const XDropdownButton(
      {super.key,
      this.label,
      this.labelStyle = const TextStyle(
          fontSize: AppFontSize.f16, fontFamily: FontFamily.productSans),
      required this.items,
      this.value,
      required this.onChanged,
      this.hint});
  final String? label;
  final Widget? hint;
  final TextStyle labelStyle;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StringUtils.isNullOrEmpty(label)
            ? const SizedBox.shrink()
            : Text(label!, style: labelStyle),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  border:
                      Border.all(color: AppColors.hintTextColor, width: 0.5)),
              child: DropdownButton(
                items: items,
                style: labelStyle,
                value: value,
                hint: hint,
                dropdownColor: AppColors.white3,
                isExpanded: true,
                borderRadius: BorderRadius.circular(AppRadius.r10),
                underline: const SizedBox.shrink(),
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                onChanged: (value) => onChanged.call(value),
              ),
            ))
      ],
    );
  }
}
