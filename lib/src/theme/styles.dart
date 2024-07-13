import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';

class AppTextStyle {
  static TextStyle labelStyle = const TextStyle(
      fontSize: AppFontSize.f14,
      fontFamily: FontFamily.inter,
      color: AppColors.black);

  static TextStyle hintTextStyle = const TextStyle(
      fontSize: AppFontSize.f12,
      fontFamily: FontFamily.inter,
      color: AppColors.grey4);

  static TextStyle buttonTextStylePrimary = const TextStyle(
      fontSize: AppFontSize.f16,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.productSans);

  static TextStyle titleTextStyle = const TextStyle(
      fontFamily: FontFamily.productSans,
      fontSize: AppFontSize.f24,
      fontWeight: FontWeight.bold);

  static TextStyle contentTexStyleBold = const TextStyle(
      fontFamily: FontFamily.abel,
      fontWeight: FontWeight.bold,
      color: AppColors.hintTextColor);

  static TextStyle contentTexStyle = const TextStyle(
      fontFamily: FontFamily.abel, color: AppColors.hintTextColor);
}
