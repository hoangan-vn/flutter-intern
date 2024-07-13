import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_utils.dart';

class XTextFieldWithLabel extends StatelessWidget {
  const XTextFieldWithLabel({
    super.key,
    this.label,
    this.labelStyle,
    required this.hintText,
    this.hintStyle,
    this.errorText,
    this.initText,
    this.isObscureText = false,
    this.errorStyle,
    this.prefix,
    this.suffix,
    this.radius = AppRadius.r10,
    this.borderColor = AppColors.hintTextColor,
    required this.onChanged,
    this.keyboardType,
    this.isEnable = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction,
  });
  final String? label;
  final TextStyle? labelStyle;
  final String hintText;
  final String? initText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final Widget? prefix;
  final Widget? suffix;
  final double radius;
  final Color borderColor;
  final bool isObscureText;
  final TextInputType? keyboardType;
  final bool isEnable;
  final void Function(String) onChanged;
  final int maxLines;
  final int minLines;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StringUtils.isNullOrEmpty(label)
            ? const SizedBox.shrink()
            : Text(label!, style: labelStyle ?? AppTextStyle.labelStyle),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          child: TextField(
            enabled: isEnable,
            style: AppTextStyle.hintTextStyle.copyWith(color: AppColors.black),
            maxLines: maxLines,
            minLines: minLines,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: (value) => onChanged(value),
            obscureText: isObscureText,
            controller: StringUtils.isNullOrEmpty(initText)
                ? null
                : TextEditingController.fromValue(
                    TextEditingValue(text: initText!)),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(radius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 0.5),
                  borderRadius: BorderRadius.circular(radius),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(radius),
                ),
                prefixIcon: prefix,
                suffixIcon: suffix,
                hintText: hintText,
                hintStyle: hintStyle ?? AppTextStyle.hintTextStyle,
                errorText: errorText,
                errorStyle: errorStyle ??
                    AppTextStyle.hintTextStyle.copyWith(color: AppColors.red),
                focusColor: AppColors.primary,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p10)),
          ),
        )
      ],
    );
  }
}
