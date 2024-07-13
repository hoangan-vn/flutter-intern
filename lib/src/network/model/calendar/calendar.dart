import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/network/model/note/note.dart';

part 'calendar.freezed.dart';
part 'calendar.g.dart';

@freezed
class MCalendar with _$MCalendar {
  const MCalendar._();
  const factory MCalendar({required List<MNote> notes, required String date}) =
      _MCalendar;

  factory MCalendar.empty() {
    return const MCalendar(notes: [], date: '');
  }

  factory MCalendar.fromJson(Map<String, Object?> json) =>
      _$MCalendarFromJson(json);
}

extension MCalendarExt on List<MCalendar> {
  static List<MCalendar> toListMCalendar(List<NotesEntityData> listLocalNotes) {
    List<MCalendar> list = [];
    list.add(
      MCalendar(
        date: listLocalNotes.first.date,
        notes: NotesModelExt.toListMNote(listLocalNotes),
      ),
    );
    return list;
  }
}
