import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';

class XBottomButtons extends StatelessWidget {
  const XBottomButtons(
      {super.key,
      required this.positiveButtonText,
      required this.cancelButtonText,
      required this.onTappedPositive,
      required this.onTappedCancel,
      this.positiveButtonColor,
      this.isLoading = false,
      this.cancelButtonColor});
  final String positiveButtonText;
  final String cancelButtonText;
  final Function onTappedPositive;
  final Function onTappedCancel;
  final Color? positiveButtonColor;
  final Color? cancelButtonColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.grey5))),
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _renderCancelButton(),
          XPaddingUtils.horizontalPadding(width: AppPadding.p20),
          _renderSaveButton(),
        ],
      ),
    );
  }

  Widget _renderCancelButton() {
    return Expanded(
      child: XFillButton(
          onPressed: () => onTappedCancel.call(),
          bgColor: cancelButtonColor ?? AppColors.grey6,
          borderRadius: AppRadius.r30,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Text(
              cancelButtonText,
              style: const TextStyle(
                  fontFamily: FontFamily.inter,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.f16,
                  color: AppColors.black),
            ),
          )),
    );
  }

  Widget _renderSaveButton() {
    return Expanded(
      child: XFillButton(
          onPressed: () => onTappedPositive.call(),
          bgColor: positiveButtonColor ?? AppColors.primary,
          borderRadius: AppRadius.r30,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: isLoading
                ? const SizedBox(
                    width: AppSize.s20,
                    height: AppSize.s20,
                    child: CircularProgressIndicator(color: AppColors.white))
                : Text(
                    positiveButtonText,
                    style: const TextStyle(
                        fontFamily: FontFamily.inter,
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSize.f16,
                        color: AppColors.white),
                  ),
          )),
    );
  }
}
