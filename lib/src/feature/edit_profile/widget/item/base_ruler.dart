import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';

class RulerPickerController extends ValueNotifier<int> {
  RulerPickerController({int value = 0}) : super(value);
}

typedef ValueChangedCallback = void Function(int value);

class BaseRulerPicker extends StatefulWidget {
  final int selectedValue;
  final ValueChangedCallback onValueChange;
  final VoidCallback? onStartEdit;
  final VoidCallback onEndEdit;
  final String Function(int index, int rulerScaleValue)? onBuildRulerScalueText;
  final double width;
  final double height;
  final int beginValue;
  final int endValue;
  final int initValue;
  final TextStyle rulerScaleTextStyle;
  final List<ScaleLineStyle> scaleLineStyleList;
  final Widget? marker;
  final double rulerMarginTop;
  final Color rulerBackgroundColor;
  final int scale;
  final RulerPickerController? controller;
  final double? scaleInterval;
  final Alignment scaleDivisionAlignment;
  final bool hideMarkNumber;

  const BaseRulerPicker({
    super.key,
    this.selectedValue = 0,
    required this.beginValue,
    required this.endValue,
    required this.onValueChange,
    required this.onEndEdit,
    required this.width,
    required this.height,
    this.onStartEdit,
    this.rulerMarginTop = 0,
    this.scale = 10,
    this.scaleLineStyleList = const [
      ScaleLineStyle(
          scale: 0, color: AppColors.greyScaleLine, width: 2, height: 32),
      ScaleLineStyle(color: AppColors.greyScaleLine, width: 1, height: 20),
    ],
    this.rulerScaleTextStyle = const TextStyle(
      color: AppColors.greyScaleLine,
      fontSize: 14,
    ),
    this.marker,
    this.onBuildRulerScalueText,
    this.initValue = 0,
    this.rulerBackgroundColor = Colors.white,
    this.controller,
    this.scaleInterval,
    this.scaleDivisionAlignment = Alignment.bottomCenter,
    this.hideMarkNumber = false,
  }) : assert(endValue > beginValue,
            initValue >= beginValue && initValue <= endValue);
  @override
  State<StatefulWidget> createState() {
    return BaseRulerPickerState();
  }
}

class BaseRulerPickerState extends State<BaseRulerPicker> {
  double lastOffset = 0;
  bool isPosFixed = false;
  var _isStartScroll = false;

  late ScrollController scrollController;
  final Map<int, ScaleLineStyle> _scaleLineStyleMap = {};
  late double _ruleScaleInterval;

  @override
  void initState() {
    super.initState();

    _ruleScaleInterval = widget.scaleInterval ?? 10;

    _scaleLineStyleMap[0] = widget.scaleLineStyleList[0];
    _scaleLineStyleMap[1] = widget.scaleLineStyleList[1];

    int initValue = (widget.beginValue == 24 && widget.endValue == 96)
        ? specScaleToNum(widget.initValue)
        : widget.initValue;

    double initValueOffset =
        (initValue - widget.beginValue) * _ruleScaleInterval;
    scrollController = ScrollController(
        initialScrollOffset: initValueOffset > 0 ? initValueOffset : 0);

    scrollController.addListener(() {
      setState(() {
        int currentScale =
            scrollController.offset ~/ _ruleScaleInterval.round();
        if (currentScale < 0) currentScale = 0;
        int currentValue = currentScale + widget.beginValue;
        if (currentValue > widget.endValue) currentValue = widget.endValue;
        if (widget.beginValue == 24 && widget.endValue == 96) {
          widget.onValueChange(_numToSpecScale(currentValue));
        } else {
          widget.onValueChange(currentValue);
        }
      });
    });

    widget.controller?.addListener(() {
      if (widget.controller!.value >= widget.beginValue &&
          widget.controller!.value <= widget.endValue) {
        setPositionByValue(widget.controller?.value ?? 0);
      }
    });
  }

  bool isFirst(int index) {
    if (index == 0) return true;

    return false;
  }

  bool isLast(int index) {
    if (index == (widget.endValue - widget.beginValue)) return true;
    return false;
  }

  Widget _buildRulerScaleLine(int index) {
    double width = 0;
    double height = 0;
    Color color = AppColors.greyScaleLine;
    final scaleDivisible = index % _scaleLineStyleMap[0]!.scale == 0;
    if (index == 0 || scaleDivisible) {
      width = _scaleLineStyleMap[0]!.width;
      height = _scaleLineStyleMap[0]!.height;
      color = _scaleLineStyleMap[0]!.color;
    } else {
      width = _scaleLineStyleMap[1]!.width;
      height = _scaleLineStyleMap[1]!.height;
      color = _scaleLineStyleMap[1]!.color;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(2))),
    );
  }

  Widget _buildRulerScale(BuildContext context, int index) {
    return SizedBox(
      width: _ruleScaleInterval,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Align(
              alignment: widget.scaleDivisionAlignment,
              child: _buildRulerScaleLine(index)),
          Positioned(
            bottom: _scaleLineStyleMap[0]?.height,
            width: 50,
            left: -25 + _ruleScaleInterval / 2,
            child: index % widget.scale == 0 && !widget.hideMarkNumber
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      getRulerScaleText(index),
                      style: widget.rulerScaleTextStyle,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  int _numToSpecScale(int index) {
    return int.parse(
        "${index ~/ 12}${(index % 12).toString().length == 1 ? "0" : ""}${index % 12}");
  }

  int specScaleToNum(int value) {
    return (value ~/ 100) * 12 + (value % 100).toInt();
  }

  void fixOffset() {
    int tempFixedOffset = (scrollController.offset + 0.5) ~/ 1;
    double fixedOffset = ((tempFixedOffset + _ruleScaleInterval / 2) ~/
        _ruleScaleInterval.round() *
        _ruleScaleInterval);
    Future.delayed(Duration.zero, () {
      if (scrollController.hasClients) {
        scrollController
            .animateTo(fixedOffset,
                duration: const Duration(milliseconds: 50),
                curve: Curves.bounceInOut)
            .then((value) {
          widget.onEndEdit.call();
          _isStartScroll = false;
        });
      }
    });
  }

  String getRulerScaleText(int index) {
    int rulerScaleValue = index + widget.beginValue;
    int currentScale = scrollController.offset ~/ _ruleScaleInterval.round();

    if (currentScale < 0) currentScale = 0;

    int currentValue = currentScale + widget.beginValue;

    if (currentValue > widget.endValue) currentValue = widget.endValue;

    // WHEN SCALE TEXT ARE IN RANGE OF [current value -5; current value + 5] then hiddend.
    // log("rulerScaleValue: $rulerScaleValue");
    if (rulerScaleValue > (currentValue - 3) &&
        rulerScaleValue < (currentValue + 3)) {
      return "";
    }

    if (widget.onBuildRulerScalueText == null) {
      return rulerScaleValue.toString();
    }

    //HANDLE SCALE 12
    if (widget.beginValue == 24 && widget.endValue == 96) {
      return widget.onBuildRulerScalueText!
          .call(index, _numToSpecScale(rulerScaleValue));
    } else {
      return widget.onBuildRulerScalueText!.call(index, rulerScaleValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height + widget.rulerMarginTop,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Listener(
              onPointerDown: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
                isPosFixed = false;
              },
              onPointerUp: (event) {},
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    if (!_isStartScroll) {
                      widget.onStartEdit?.call();
                      _isStartScroll = true;
                    }
                  } else if (scrollNotification is ScrollUpdateNotification) {
                  } else if (scrollNotification is ScrollEndNotification) {
                    if (!isPosFixed) {
                      isPosFixed = true;
                      fixOffset();
                    }
                  }
                  return true;
                },
                child: Container(
                  width: double.infinity,
                  height: widget.height,
                  color: widget.rulerBackgroundColor,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: (widget.width - _ruleScaleInterval) / 2,
                        right: (widget.width - _ruleScaleInterval) / 2),
                    itemExtent: _ruleScaleInterval,
                    itemCount: widget.endValue - widget.beginValue + 1,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: _buildRulerScale,
                  ),
                ),
              ),
            ),
          ),
          widget.marker != null
              ? IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.marker,
                  ),
                )
              : Container(),
          _bottomLeftOpac(),
          _bottomRightOpac(),
        ],
      ),
    );
  }

  Widget _bottomLeftOpac() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Container(
          height: widget.height,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                AppColors.white4.withOpacity(0.0),
                AppColors.white4.withOpacity(1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomRightOpac() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Container(
          height: widget.height,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.white4.withOpacity(0.0),
                AppColors.white4.withOpacity(1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void didUpdateWidget(BaseRulerPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void setPositionByValue(int value) {
    double targetValue = (value - widget.beginValue) * _ruleScaleInterval;
    if (targetValue < 0) targetValue = 0;
    scrollController.jumpTo(targetValue.toDouble());
  }
}

class ScaleLineStyle {
  final int scale;
  final Color color;
  final double width;
  final double height;

  const ScaleLineStyle({
    this.scale = -1,
    required this.color,
    required this.width,
    required this.height,
  });
}

class RulerValue {
  final int beginValue;
  final int endValue;
  RulerValue({
    required this.beginValue,
    required this.endValue,
  });
}
