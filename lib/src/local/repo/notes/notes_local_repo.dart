import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';

abstract class NotesLocalRepo {
  final DatabaseApp database;

  NotesLocalRepo(this.database);

  Future<NotesEntityData?> upsert(NotesEntityData entity);

  /// Upsert a value summarized by day into: Month table
  Future<NotesEntityData?> insertDetail(NotesEntityData entity);

  MultiSelectable<NotesEntityData> getDetail({required String id});

  MultiSelectable<NotesEntityData> getDetailByDate({required String date});

  MultiSelectable<NotesEntityData> getDetailByMedicineName(
      {required String name});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<NotesEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteNoteById(String id);
}
