import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';

class XCardItemWithIcon extends StatelessWidget {
  final String text;
  final Function? onTap;
  final bool firstItem;
  final bool lastItem;
  final IconData? iconPath;
  final EdgeInsetsGeometry? paddingItem;
  final double? borderRadius;
  final Color? backgroundColor;
  const XCardItemWithIcon(
      {Key? key,
      required this.text,
      this.onTap,
      this.firstItem = false,
      this.lastItem = false,
      this.iconPath,
      this.paddingItem,
      this.borderRadius = AppRadius.r10,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: firstItem ? Radius.circular(borderRadius!) : Radius.zero,
          topRight: firstItem ? Radius.circular(borderRadius!) : Radius.zero,
          bottomLeft: lastItem ? Radius.circular(borderRadius!) : Radius.zero,
          bottomRight: lastItem ? Radius.circular(borderRadius!) : Radius.zero,
        ),
        onTap: () {
          onTap != null ? onTap!() : null;
        },
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: firstItem ? Radius.circular(borderRadius!) : Radius.zero,
              topRight:
                  firstItem ? Radius.circular(borderRadius!) : Radius.zero,
              bottomLeft:
                  lastItem ? Radius.circular(borderRadius!) : Radius.zero,
              bottomRight:
                  lastItem ? Radius.circular(borderRadius!) : Radius.zero,
            ),
          ),
          child: Padding(
            padding: paddingItem ?? const EdgeInsets.all(AppPadding.p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_renderText(), _renderSuffixIcon()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderSuffixIcon() {
    return Row(
      children: [
        const SizedBox(width: AppMargin.m16),
        iconPath != null
            ? Icon(
                iconPath!,
                size: AppSize.s16,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderText() {
    return Text(text,
        style:
            AppTextStyle.contentTexStyleBold.copyWith(color: AppColors.black2));
  }
}
