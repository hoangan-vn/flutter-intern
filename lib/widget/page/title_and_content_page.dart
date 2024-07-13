import 'package:flutter/material.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/widget/text/text_with_multi_style.dart';

class XTitleAndContentPage extends StatelessWidget {
  const XTitleAndContentPage(
      {super.key,
      required this.firstTitle,
      required this.secondTitle,
      required this.firstStyle,
      required this.secondStyle,
      required this.content,
      this.hasImage = false,
      this.image});
  final String firstTitle;
  final String secondTitle;
  final TextStyle firstStyle;
  final TextStyle secondStyle;
  final Widget content;
  final bool hasImage;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _renderTitle(),
          if (hasImage) _renderImage(),
          _renderContent(),
        ],
      ),
    );
  }

  Widget _renderTitle() {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: AppMargin.m100),
        child: XTextsTwoStyle(
            firstText: firstTitle,
            secondText: secondTitle,
            firstStyle: firstStyle,
            secondStyle: secondStyle),
      ),
    );
  }

  Widget _renderImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p59),
      child: Image.asset(image!),
    );
  }

  Widget _renderContent() {
    return Expanded(child: content);
  }
}
