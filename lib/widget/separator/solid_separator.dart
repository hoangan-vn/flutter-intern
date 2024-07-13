import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';

class XSolidSeparator extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;

  const XSolidSeparator({
    Key? key,
    this.height = 1,
    this.width = double.infinity,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color ?? AppColors.grey6,
    );
  }
}
