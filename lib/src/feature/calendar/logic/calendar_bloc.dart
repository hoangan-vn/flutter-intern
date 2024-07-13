import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/feature/calendar/logic/calendar_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/note/note_repository.dart';
import 'package:safebump/src/network/model/calendar/calendar.dart';
import 'package:safebump/src/network/model/note/note.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/datetime_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/calendar/month_calendar.dart';

class CalendarBloc extends Cubit<CalendarState> {
  CalendarBloc() : super(CalendarState(dateSelected: DateTime.now()));

  Future<void> inital(BuildContext context) async {
    await _getAllDaysHaveNotes();
    _getNotesInSelectedDay(state.dateSelected);
  }

  Future<void> _getAllDaysHaveNotes() async {
    try {
      List<NotesEntityData> listNotesLocal =
          await GetIt.I.get<NotesLocalRepo>().getAllDetails().get();
      Map<DateTime, List<NoteType>> daysHaveNote =
          _convertToMapNotes(listNotesLocal);
      emit(state.copyWith(
          daysWithNoteType: daysHaveNote, status: CalendarStatus.normal));
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: CalendarStatus.error));
    }
  }

  Map<DateTime, List<NoteType>> _convertToMapNotes(
      List<NotesEntityData> allNotes) {
    Map<DateTime, List<NoteType>> data = {};
    for (NotesEntityData note in allNotes) {
      final key = DateTimeUtils.fromyMMMd(note.date);
      NoteType value = NoteType.toNoteTypeEnum(note.type);
      if (data.containsKey(key)) {
        if (!data[key]!.contains(value)) {
          data[key]!.add(value);
        }
      } else {
        data.addEntries({
          key: [value]
        }.entries);
      }
    }
    return data;
  }

  Future<List<NotesEntityData>> _getNotesInSelectedDay(
      DateTime dateSelected) async {
    try {
      final notes = await GetIt.I
          .get<NotesLocalRepo>()
          .getDetailByDate(date: dateSelected.toMMMdy)
          .get();
      emit(state.copyWith(
          listSelectedDatesNotes: NotesModelExt.toListMNote(notes)));
      return notes;
    } catch (e) {
      emit(state.copyWith(listSelectedDatesNotes: []));
      xLog.e(e);
      return [];
    }
  }

  void onChangedDate(DateTime date) {
    emit(state.copyWith(dateSelected: date, listSelectedDatesNotes: []));
    _getNotesInSelectedDay(date);
  }

  void onChangedTitleAdd(String title) {
    emit(state.copyWith(titleAdd: title, errorTitleAdd: ''));
  }

  void onChangedDetailAdd(String detail) {
    emit(state.copyWith(detailAdd: detail));
  }

  Future<void> createNote(BuildContext context) async {
    if (state.createStatus == CreateNoteStatus.creating) return;
    if (_checkInvalidTitle(state.titleAdd)) {
      emit(state.copyWith(
          errorTitleAdd: S.of(context).thisFieldIsNotEmpty,
          createStatus: CreateNoteStatus.fail));
      return;
    }
    emit(state.copyWith(createStatus: CreateNoteStatus.creating));
    try {
      await GetIt.I
          .get<NotesLocalRepo>()
          .insertDetail(NotesEntityData(
              id: StringUtils.createGenerateRandomText(length: 20),
              title: state.titleAdd,
              detail: state.detailAdd,
              type: NoteType.other.toNoteTypeText(),
              date: state.dateSelected.toMMMdy))
          .then((value) async {
        await inital(context);
        await _syncingToFirebase();
      });
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(createStatus: CreateNoteStatus.fail));
    }
  }

  Future<void> _syncingToFirebase() async {
    try {
      final notesInSelectedDay =
          await _getNotesInSelectedDay(state.dateSelected);
      if (notesInSelectedDay.isEmpty) {
        xLog.e('message');
        await GetIt.I
            .get<NoteRepository>()
            .deleteDay(MCalendar(notes: [], date: state.dateSelected.toMMMdy));
        return;
      }
      final dataUpsertDay = MCalendarExt.toListMCalendar(notesInSelectedDay);
      await GetIt.I.get<NoteRepository>().upsertNote(dataUpsertDay.first);
    } catch (e) {
      xLog.e(e);
    }
  }

  bool _checkInvalidTitle(String titleAdd) {
    return StringUtils.isNullOrEmpty(titleAdd);
  }

  Future<void> deleteNote(String idNote, BuildContext context) async {
    try {
      await GetIt.I
          .get<NotesLocalRepo>()
          .deleteNoteById(idNote)
          .then((value) async {
        await inital(context);
        await _syncingToFirebase();
      });
    } catch (e) {
      xLog.e(e);
    }
  }
}
