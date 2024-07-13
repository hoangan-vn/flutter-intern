import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';

class XAppBarDashboard extends StatelessWidget {
  const XAppBarDashboard(
      {super.key,
      required this.title,
      this.titleStyle = const TextStyle(
          fontFamily: FontFamily.productSans,
          fontSize: AppFontSize.f16,
          color: AppColors.black),
      this.leading,
      this.action});

  final String title;
  final TextStyle titleStyle;
  final Widget? leading;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null)
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft, child: leading!)),
              if (action != null)
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight, child: action!)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p53),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
