import 'package:flutter/material.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';

class XTextsTwoStyle extends StatelessWidget {
  const XTextsTwoStyle({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstStyle,
    required this.secondStyle,
  });
  final String firstText;
  final String secondText;
  final TextStyle firstStyle;
  final TextStyle secondStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _renderFirstText(),
        XPaddingUtils.horizontalPadding(width: AppPadding.p8),
        _renderSecondText(),
      ],
    );
  }

  Widget _renderFirstText() {
    return Text(
      firstText,
      overflow: TextOverflow.fade,
      style: firstStyle,
    );
  }

  Widget _renderSecondText() {
    return Text(
      secondText,
      overflow: TextOverflow.fade,
      style: secondStyle,
    );
  }
}
