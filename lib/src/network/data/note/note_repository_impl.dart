import 'package:get_it/get_it.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/note/note_reference.dart';
import 'package:safebump/src/network/data/note/note_repository.dart';
import 'package:safebump/src/network/model/calendar/calendar.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/note/note.dart';

class NoteRepositoryImpl extends NoteRepository {
  final notesRef = NoteReference();
  @override
  Future<MResult<MCalendar>> getNoteInDate(DateTime date) async {
    final calendar = await notesRef.getNote(date);
    return MResult.success(calendar.data);
  }

  @override
  Future<MResult<MCalendar>> upsertNote(MCalendar notes) {
    return notesRef.upsertNote(notes);
  }

  @override
  Future<MResult<List<MCalendar>>> getNotes() async {
    final result = await notesRef.getNotes();
    if (result.data != null) {
      for (MCalendar day in result.data!) {
        for (NotesEntityData note
            in day.notes.toListNotesEntityData(day.date)) {
          GetIt.I.get<NotesLocalRepo>().upsert(note);
        }
      }
      return result;
    }
    return MResult.error(S.text.someThingWentWrong);
  }

  @override
  Future<MResult<bool>> deleteDay(MCalendar day) async {
    return notesRef.deleteNote(day);
  }
}
