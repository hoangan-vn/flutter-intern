import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/utils.dart';

class XAdjustValueInput extends StatefulWidget {
  final String? title;
  final double? amount;
  final double? minValue;
  final double? maxValue;
  final Color? backgroundColor;
  final Color? borderColor;
  final void Function(double value) onValueChange;
  final TextStyle? titleStyle;

  const XAdjustValueInput({
    Key? key,
    this.title,
    this.amount = 1,
    this.minValue = 1,
    this.maxValue = 100,
    this.backgroundColor,
    this.borderColor,
    required this.onValueChange,
    this.titleStyle,
  }) : super(key: key);

  @override
  State<XAdjustValueInput> createState() => _XAdjustValueInputState();
}

class _XAdjustValueInputState extends State<XAdjustValueInput> {
  var _amount = 1.0;

  @override
  void initState() {
    _amount = widget.amount ?? 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Container(
                margin: const EdgeInsets.only(bottom: AppMargin.m8),
                child: Text(
                  widget.title!,
                  style: widget.titleStyle ?? AppTextStyle.labelStyle,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.grey6,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r10)),
            border: Border.all(
              color: widget.borderColor ?? AppColors.grey5,
              width: widget.borderColor != null ? 1 : 0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (_amount == widget.minValue) {
                    return;
                  }
                  setState(() {
                    _amount = _amount - 0.5;
                    widget.onValueChange(_amount);
                  });
                },
                splashRadius: 1,
                icon: Icon(
                  Icons.remove,
                  size: AppSize.s14,
                  color: _amount > widget.minValue!
                      ? AppColors.black
                      : AppColors.grey4,
                ),
              ),
              Flexible(
                child: TextField(
                  controller: TextEditingController(
                      text: Utils.formatDecimalNumber(_amount)),
                  enabled: false,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.labelStyle,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_amount == widget.maxValue) {
                    return;
                  }
                  setState(() {
                    _amount = _amount + 0.5;
                    widget.onValueChange(_amount);
                  });
                },
                splashRadius: 1,
                icon: Icon(
                  Icons.add,
                  size: AppSize.s14,
                  color: _amount < widget.maxValue!
                      ? AppColors.black
                      : AppColors.grey4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
