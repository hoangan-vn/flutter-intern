import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
import 'package:safebump/src/utils/utils.dart';

class NotesLocalRepoImpl extends NotesLocalRepo {
  NotesLocalRepoImpl(super.database);

  @override
  MultiSelectable<NotesEntityData> getDetail({required String id}) {
    return (database.select(database.notesEntity)
      ..where((notes) => notes.id.equals(id)));
  }

  @override
  MultiSelectable<NotesEntityData> getDetailByDate({required String date}) {
    return (database.select(database.notesEntity)
      ..where((notes) => notes.date.equals(date)));
  }

  @override
  MultiSelectable<NotesEntityData> getDetailByMedicineName({required String name}) {
    return (database.select(database.notesEntity)
      ..where((notes) => notes.medicine.equals(name)));
  }

  @override
  MultiSelectable<NotesEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.notesEntity);
    }

    return (database.select(database.notesEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<NotesEntityData?> upsert(NotesEntityData entity) async {
    try {
      await upsertDetail(entity);
      return entity;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await database.delete(database.notesEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<NotesEntityData?> upsertDetail(NotesEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.notesEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.notesEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<NotesEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.notesEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<NotesEntityData?> insertDetail(NotesEntityData entity) async {
    try {
      await database.into(database.notesEntity).insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }

  @override
  Future<void> deleteNoteById(String id) async {
    try {
      (database.delete(database.notesEntity)..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (error) {
      xLog.e("[error - _deleteNoteById] $error");
    }
  }
}
