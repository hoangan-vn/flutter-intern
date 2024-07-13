import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/feature/edit_profile/widget/item/base_ruler.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_ext.dart';

typedef ValueChangedCallback = void Function(int value);

class RulerCT extends StatefulWidget {
  final ValueChangedCallback onValueChange;
  final RulerType rulerType;
  final MeasurementUnitType unitType;
  final int initValue;
  final RulerValue rulerValue;

  const RulerCT({
    Key? key,
    required this.initValue,
    this.rulerType = RulerType.height,
    this.unitType = MeasurementUnitType.metric,
    required this.rulerValue,
    required this.onValueChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RulerCTState();
}

class _RulerCTState extends State<RulerCT> {
  RulerPickerController? _rulerPickerController;
  late RulerValue _rulerValue;
  late int _currentValue;
  @override
  void initState() {
    super.initState();
    _rulerValue = widget.rulerValue;
    _currentValue = widget.initValue;
    _rulerPickerController = RulerPickerController(value: widget.initValue);
  }

  @override
  void dispose() {
    _rulerPickerController?.dispose();
    super.dispose();
  }

  List<ScaleLineStyle> _scaleLineStyle(RulerType rulerType) {
    switch (rulerType) {
      case RulerType.height:
        if (widget.unitType == MeasurementUnitType.imperial) {
          return const [
            ScaleLineStyle(
                color: Colors.black, width: 2, height: 24, scale: 12),
            ScaleLineStyle(
              color: Colors.black,
              width: 2,
              height: 12,
              scale: -1,
            ),
          ];
        } else {
          return const [
            ScaleLineStyle(color: Colors.black, width: 2, height: 24, scale: 5),
            ScaleLineStyle(color: Colors.black, width: 2, height: 12, scale: -1)
          ];
        }
      case RulerType.weight:
        return const [
          ScaleLineStyle(color: Colors.black, width: 2, height: 14, scale: 5),
          ScaleLineStyle(color: Colors.black, width: 2, height: 7, scale: -1)
        ];
    }
  }

  String _markerText(RulerType rulerType, MeasurementUnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            {
              int sub = _currentValue.toString().length == 3 ? 100 : 10;
              return "     ${(_currentValue ~/ sub).toString()}'${(_currentValue % sub).toInt().toString()}''";
            }

          case MeasurementUnitType.metric:
            return "$_currentValue";
        }
      case RulerType.weight:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return "${(_currentValue / 10)}";

          case MeasurementUnitType.metric:
            return "${(_currentValue / 10)}";
        }
    }
  }

  Widget _rulerMarker(RulerType rulerType, MeasurementUnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _markerText(rulerType, unitType),
              style: AppTextStyle.titleTextStyle
                  .copyWith(fontSize: AppFontSize.f20),
            ),
            const SizedBox(height: 4),
            Container(
              width: 4,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(28, 186, 146, 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        );
      case RulerType.weight:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _markerText(rulerType, unitType),
              style: AppTextStyle.titleTextStyle
                  .copyWith(fontSize: AppFontSize.f20),
            ),
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                color: const Color.fromRGBO(28, 186, 146, 1),
                height: 22,
                width: 9,
              ),
            ),
          ],
        );
    }
  }

  String _onBuildRulerScalueText(int index, int scaleValue) {
    switch (widget.rulerType) {
      case RulerType.height:
        switch (widget.unitType) {
          case MeasurementUnitType.imperial:
            return "${(scaleValue ~/ 100)}'";

          case MeasurementUnitType.metric:
            return "$scaleValue";
        }
      case RulerType.weight:
        switch (widget.unitType) {
          case MeasurementUnitType.imperial:
            return "${(scaleValue ~/ 10)}";

          case MeasurementUnitType.metric:
            return "${(scaleValue ~/ 10)}";
        }
    }
  }

  String _unitTitle(RulerType rulerType, MeasurementUnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return "feet, inch";
          case MeasurementUnitType.metric:
            return "cm";
        }
      case RulerType.weight:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return "lb";
          case MeasurementUnitType.metric:
            return "kg";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.rulerType.name.toString().capitalize(),
                style: const TextStyle(
                  fontFamily: FontFamily.inter,
                  color: AppColors.black,
                  fontSize: AppFontSize.f16,
                ),
              ),
              Text(
                _unitTitle(widget.rulerType, widget.unitType),
                style: const TextStyle(
                  fontFamily: FontFamily.inter,
                  color: AppColors.grey2,
                ),
              ),
            ],
          ),
        ),
        BaseRulerPicker(
          rulerScaleTextStyle: AppTextStyle.contentTexStyle,
          width: MediaQuery.of(context).size.width - 32,
          height: 70,
          scale: widget.rulerType == RulerType.height &&
                  widget.unitType == MeasurementUnitType.imperial
              ? 12
              : 10,
          controller: _rulerPickerController,
          beginValue: _rulerValue.beginValue,
          endValue: _rulerValue.endValue,
          initValue: _currentValue,
          scaleLineStyleList: _scaleLineStyle(widget.rulerType),
          onBuildRulerScalueText: (index, scaleValue) {
            return _onBuildRulerScalueText(index, scaleValue);
          },
          onEndEdit: () {
            widget.onValueChange.call(_currentValue);
          },
          onValueChange: (value) {
            setState(() {
              _currentValue = value;
            });
          },
          marker: _rulerMarker(
            widget.rulerType,
            widget.unitType,
          ),
          rulerBackgroundColor: Colors.transparent,
        ),
      ]),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 6);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
