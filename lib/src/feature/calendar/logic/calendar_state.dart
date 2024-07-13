import 'package:equatable/equatable.dart';
import 'package:safebump/src/network/model/calendar/calendar.dart';
import 'package:safebump/src/network/model/note/note.dart';
import 'package:safebump/widget/calendar/month_calendar.dart';

enum CreateNoteStatus { init, creating, fail, success }

class CalendarState with EquatableMixin {
  CalendarState({
    this.status = CalendarStatus.normal,
    this.createStatus = CreateNoteStatus.init,
    required this.dateSelected,
    this.daysWithNoteType,
    this.listDaysHaveNotes,
    this.listSelectedDatesNotes,
    this.titleAdd = '',
    this.errorTitleAdd,
    this.detailAdd,
  });

  final CalendarStatus status;
  final CreateNoteStatus createStatus;
  final DateTime dateSelected;
  final Map<DateTime, List<NoteType>>? daysWithNoteType;
  final List<MNote>? listSelectedDatesNotes;
  final List<MCalendar>? listDaysHaveNotes;
  final String titleAdd;
  final String? errorTitleAdd;
  final String? detailAdd;

  CalendarState copyWith({
    CalendarStatus? status,
    CreateNoteStatus? createStatus,
    DateTime? dateSelected,
    List<MCalendar>? listDaysHaveNotes,
    Map<DateTime, List<NoteType>>? daysWithNoteType,
    List<MNote>? listSelectedDatesNotes,
    String? titleAdd,
    String? errorTitleAdd,
    String? detailAdd,
  }) {
    return CalendarState(
      status: status ?? this.status,
      createStatus: createStatus ?? this.createStatus,
      listDaysHaveNotes: listDaysHaveNotes ?? this.listDaysHaveNotes,
      dateSelected: dateSelected ?? this.dateSelected,
      daysWithNoteType: daysWithNoteType ?? this.daysWithNoteType,
      listSelectedDatesNotes:
          listSelectedDatesNotes ?? this.listSelectedDatesNotes,
      titleAdd: titleAdd ?? this.titleAdd,
      errorTitleAdd: errorTitleAdd ?? this.errorTitleAdd,
      detailAdd: detailAdd ?? this.detailAdd,
    );
  }

  @override
  String toString() {
    return 'CalendarState{status=$status, dateSelected=$dateSelected, dateHaveNotes=$daysWithNoteType, listSelectedDatesNotes=$listSelectedDatesNotes}';
  }

  @override
  List<Object?> get props => [
        status,
        dateSelected,
        daysWithNoteType,
        listSelectedDatesNotes,
        titleAdd,
        errorTitleAdd,
        detailAdd
      ];
}
