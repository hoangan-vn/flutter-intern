import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safebump/src/local/database_app.dart';

part 'note.g.dart';

@JsonSerializable(explicitToJson: true)
class MNote {
  String title;
  String id;
  String? detail;
  String? hospital;
  String type;
  String? medicine;
  DateTime? time;
  DateTime? remindTime;

  MNote(
      {required this.title,
      required this.type,
      this.detail,
      this.hospital,
      this.medicine,
      this.time,
      required this.id,
      this.remindTime});

  factory MNote.fromJson(Map<String, dynamic> json) => _$MNoteFromJson(json);

  Map<String, dynamic> toJson() => _$MNoteToJson(this);

  @override
  String toString() {
    return 'MNote{id =$id, title=$title, detail=$detail, hospital=$hospital, type=$type, medicine=$medicine, time=$time, remindTime=$remindTime}';
  }
}

extension NotesModelExt on List<MNote> {
  List<NotesEntityData> toListNotesEntityData(String date) {
    List<NotesEntityData> list = [];
    for (MNote item in this) {
      list.add(NotesEntityData(
        date: date,
        time: item.time,
        remindTime: item.remindTime,
        detail: item.detail,
        id: item.id,
        title: item.title,
        type: item.type,
        hospital: item.hospital,
        medicine: item.medicine,
      ));
    }
    return list;
  }

  static List<MNote> toListMNote(List<NotesEntityData> listLocalNotes) {
    List<MNote> list = [];
    for (NotesEntityData item in listLocalNotes) {
      list.add(MNote(
        time: item.time,
        remindTime: item.remindTime,
        detail: item.detail,
        id: item.id,
        title: item.title,
        type: item.type,
        hospital: item.hospital,
        medicine: item.medicine,
      ));
    }
    return list;
  }
}
