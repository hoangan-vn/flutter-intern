import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/dialogs/alert_wrapper.dart';
import 'package:safebump/src/feature/calendar/logic/calendar_bloc.dart';
import 'package:safebump/src/feature/calendar/logic/calendar_state.dart';
import 'package:safebump/src/feature/calendar/widget/note_item.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/note/note.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/button/text_button.dart';
import 'package:safebump/widget/calendar/month_calendar.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().inital(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: AppColors.white4,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderAppbar(context),
              _renderCalendar(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderDaysNotes(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppbar(BuildContext context) {
    return XAppBarDashboard(
      leading: Assets.images.images.logo.image(height: AppSize.s30),
      action: _renderAddIcon(),
      title: S.of(context).calendar,
    );
  }

  Widget _renderAddIcon() {
    return IconButton(
        onPressed: () {
          _showDialogAddNote();
        },
        icon: const Icon(
          Icons.edit_calendar_outlined,
          size: AppSize.s20,
        ));
  }

  void _showDialogAddNote() {
    XAlert.showCustomAlert(
      title: Text(
        S.of(context).addYourNote,
        style: AppTextStyle.titleTextStyle,
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<CalendarBloc>(context),
        child: DismissKeyBoard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _renderAddTitleField(),
              _renderAddDetailField(),
              _renderCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAddTitleField() {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) =>
          previous.titleAdd != current.titleAdd ||
          previous.errorTitleAdd != current.errorTitleAdd,
      builder: (context, state) {
        return XTextFieldWithLabel(
            label: S.of(context).title,
            hintText: S.of(context).enterHere,
            errorText: StringUtils.isNullOrEmpty(state.errorTitleAdd)
                ? null
                : state.errorTitleAdd,
            prefix: const Icon(
              Icons.abc_outlined,
              color: AppColors.primary,
            ),
            onChanged: (value) {
              context.read<CalendarBloc>().onChangedTitleAdd(value);
            });
      },
    );
  }

  Widget _renderAddDetailField() {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) => previous.detailAdd != current.detailAdd,
      builder: (context, state) {
        return XTextFieldWithLabel(
            maxLines: 2,
            label: S.of(context).detail,
            hintText: S.of(context).enterHere,
            prefix: const Icon(
              Icons.list,
              color: AppColors.primary,
            ),
            onChanged: (value) {
              context.read<CalendarBloc>().onChangedDetailAdd(value);
            });
      },
    );
  }

  Widget _renderCreateButton() {
    return XTextButton(
        callback: () {
          context.read<CalendarBloc>().createNote(context);
          AppCoordinator.pop();
        },
        label: S.of(context).create);
  }

  Widget _renderCalendar(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return XMonthCalendar(
          selectingDay: state.dateSelected,
          data: state.daysWithNoteType ?? {},
          onDaySelected: (date) =>
              context.read<CalendarBloc>().onChangedDate(date),
          minDate: DateTime.now().subtract(const Duration(days: 200)),
          maxDate: DateTime(DateTime.now().year + 2),
          calendarState: state.status,
        );
      },
    );
  }

  Widget _renderDaysNotes(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.dateSelected != current.dateSelected ||
          previous.listSelectedDatesNotes != current.listSelectedDatesNotes,
      builder: (context, state) {
        return state.status == CalendarStatus.normal
            ? Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    boxShadow: AppDecorations.shadow,
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.r10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderHeaderNote(context),
                  ]
                      .followedBy(state.listSelectedDatesNotes != null
                          ? _renderListNoteItem(
                              state.listSelectedDatesNotes ?? [])
                          : [const SizedBox.shrink()])
                      .toList(),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _renderHeaderNote(BuildContext context) {
    return Text(S.of(context).notesCreated,
        style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f16));
  }

  List<Widget> _renderListNoteItem(List<MNote> listNotes) {
    List<Widget> listNotesWidget = [];
    for (MNote note in listNotes) {
      listNotesWidget.add(_renderNoteItem(note));
    }
    return listNotesWidget;
  }

  Widget _renderNoteItem(MNote note) {
    return XNoteItem(
      note: note,
      deleteFunc: () =>
          context.read<CalendarBloc>().deleteNote(note.id, context),
    );
  }
}
