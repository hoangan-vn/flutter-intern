import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_utils.dart';

class XLabelButton<T> extends StatelessWidget {
  const XLabelButton({
    super.key,
    this.label,
    this.labelStyle,
    this.hintStyle,
    this.value,
    required this.onTapped,
    required this.hint,
    this.icon,
  });
  final String? label;
  final String hint;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Function() onTapped;
  final T? value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderLabel(),
        _renderField(),
      ],
    );
  }

  Widget _renderLabel() {
    return StringUtils.isNullOrEmpty(label)
        ? const SizedBox.shrink()
        : Text(label!, style: labelStyle ?? AppTextStyle.labelStyle);
  }

  Widget _renderField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r8),
          border: Border.all(
            color: AppColors.hintTextColor,
            width: 0.5,
          )),
      child: GestureDetector(
        onTap: () => onTapped(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _renderValue(),
            _renderIcon(),
          ],
        ),
      ),
    );
  }

  Widget _renderValue() {
    return Text(
      value == null ? hint : value.toString(),
      style: value == null
          ? hintStyle
          : AppTextStyle.hintTextStyle.copyWith(color: AppColors.black),
      overflow: TextOverflow.clip,
    );
  }

  Widget _renderIcon() {
    return Icon(
      icon,
      color: AppColors.grey5,
    );
  }
}
