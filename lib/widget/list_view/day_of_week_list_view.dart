import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';

class XDayOfWeekListView extends StatelessWidget {
  const XDayOfWeekListView(
      {super.key,
      this.isShowWeek = true,
      required this.listDayOfWeek,
      this.isShowDetail = true,
      required this.today,
      this.week,
      this.selectedDay,
      required this.onTappedDay});
  final bool? isShowWeek;
  final List<DateTime> listDayOfWeek;
  final bool? isShowDetail;
  final DateTime today;
  final DateTime? selectedDay;
  final String? week;
  final void Function(DateTime) onTappedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _renderWeekPergnancy(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        _renderListDay(),
      ],
    );
  }

  Widget _renderWeekPergnancy(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontFamily: FontFamily.abel,
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.f20,
          color: AppColors.black),
      child: Row(
        children: [
          Text(week ?? ""),
          Text(S.of(context).weekOfPregnancy),
        ],
      ),
    );
  }

  Widget _renderListDay() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (DateTime day in listDayOfWeek)
          _renderDay(
              day: day,
              isToday: day.compareTo(today) == 0,
              isSelected: day.compareTo(selectedDay ?? today) == 0),
      ],
    );
  }

  Widget _renderDay(
      {required DateTime day, bool isToday = false, bool isSelected = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTappedDay.call(day);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.all(AppPadding.p10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r5),
            boxShadow: AppDecorations.shadow,
            color: isToday
                ? AppColors.primary
                : isSelected
                    ? AppColors.subPrimary
                    : AppColors.white,
          ),
          child: Column(
            children: [
              Text(
                DateFormat("EEE").format(day),
                style: const TextStyle(
                    fontFamily: FontFamily.inter, fontSize: AppFontSize.f9),
              ),
              XPaddingUtils.verticalPadding(height: AppPadding.p8),
              Text(
                day.day.toString(),
                style: const TextStyle(
                    fontFamily: FontFamily.abel, fontSize: AppFontSize.f14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
