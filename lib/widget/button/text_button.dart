import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/value.dart';

class XTextButton extends StatelessWidget {
  const XTextButton(
      {super.key, required this.label, this.callback, this.padding});
  final String label;
  final void Function()? callback;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(padding),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r4)))),
      child: Text(
        label,
        style: const TextStyle(
            fontFamily: FontFamily.inter, fontSize: AppFontSize.f13),
      ),
    );
  }
}
