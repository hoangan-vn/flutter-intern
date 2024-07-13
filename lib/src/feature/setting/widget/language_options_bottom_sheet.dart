import 'package:flutter/material.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/config/enum/language_enum.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_ext.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';

class LanguageModel {
  LanguageModel(
      {required this.language, required this.flag, this.isSelected = false});
  final String language;
  final Widget flag;
  final bool isSelected;
}

class XOptionsBottomSheet extends StatefulWidget {
  final String? title;
  const XOptionsBottomSheet({super.key, this.title});

  @override
  State<XOptionsBottomSheet> createState() => _XOptionsBottomSheetState();
}

class _XOptionsBottomSheetState extends State<XOptionsBottomSheet> {
  late LanguageEnum _selectedLanguage;
  late List<LanguageModel> _listLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = LanguageEnum.english;
    _getListLanguageOptions();
  }

  void _getListLanguageOptions() {
    _listLanguage = [];
    for (final language in LanguageEnum.values) {
      _listLanguage.add(LanguageModel(
          language: language.getText(),
          flag: Assets.svg.icUs.svg(width: AppSize.s16),
          isSelected: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _renderTitle(),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderOptions(),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderSelectButton(),
          ],
        ),
      )),
    );
  }

  Widget _renderTitle() {
    return StringUtils.isNullOrEmpty(widget.title)
        ? const SizedBox.shrink()
        : Text(
            widget.title!,
            style: const TextStyle(
                fontFamily: FontFamily.abel,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.f16,
                color: AppColors.black),
          );
  }

  Widget _renderOptions() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _listLanguage.length,
        itemBuilder: (context, index) => _renderOption(index));
  }

  Widget _renderOption(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p16, horizontal: AppPadding.p8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _listLanguage[index].flag,
              XPaddingUtils.horizontalPadding(width: AppPadding.p8),
              Expanded(
                  child: Text(
                _listLanguage[index].language.capitalize(),
                style: const TextStyle(fontFamily: FontFamily.abel),
              )),
              _listLanguage[index].isSelected
                  ? const Icon(
                      Icons.check,
                      color: AppColors.green,
                      size: AppSize.s16,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }

  Widget _renderSelectButton() {
    return XFillButton(
        onPressed: () {
          AppCoordinator.pop(_selectedLanguage);
        },
        label: Text(
          S.of(context).select,
          style: const TextStyle(
              fontFamily: FontFamily.productSans,
              fontSize: AppFontSize.f20,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ));
  }
}
