import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';

class XCircleButton extends StatelessWidget {
  const XCircleButton(
      {super.key,
      this.buttonLabelBottom,
      required this.onTapped,
      this.icon = Icons.add_circle_outline_rounded,
      this.buttonSize = AppSize.s100,
      this.iconColor = AppColors.grey2,
      this.color = AppColors.grey6});
  final String? buttonLabelBottom;
  final Function onTapped;
  final IconData icon;
  final double buttonSize;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return _renderAddImage(context);
  }

  Widget _renderAddImage(BuildContext context) {
    return Column(
      children: [
        _renderAddButton(),
        XPaddingUtils.verticalPadding(height: AppPadding.p8),
        _renderButtonDes(context)
      ],
    );
  }

  Widget _renderAddButton() {
    return Material(
      borderRadius: BorderRadius.circular(buttonSize / 2),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onTapped(),
        child: Ink(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonSize / 2),
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _renderButtonDes(BuildContext context) {
    return StringUtils.isNullOrEmpty(buttonLabelBottom)
        ? const SizedBox.shrink()
        : Text(
            buttonLabelBottom!,
            style: const TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: AppFontSize.f12,
                color: AppColors.grey2),
          );
  }
}
