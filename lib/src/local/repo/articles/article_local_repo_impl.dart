import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/articles/article_local_repo.dart';
import 'package:safebump/src/utils/utils.dart';

class ArticlesLocalRepoImpl extends ArticlesLocalRepo {
  ArticlesLocalRepoImpl(super.database);

  @override
  MultiSelectable<ArticlesEntityData> getDetail({required String id}) {
    return (database.select(database.articlesEntity)
      ..where((notes) => notes.id.equals(id)));
  }

  @override
  MultiSelectable<ArticlesEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.articlesEntity);
    }

    return (database.select(database.articlesEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<ArticlesEntityData?> upsert(ArticlesEntityData entity) async {
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
      await database.delete(database.articlesEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<ArticlesEntityData?> upsertDetail(ArticlesEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.articlesEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.articlesEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<ArticlesEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.articlesEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<ArticlesEntityData?> insertDetail(ArticlesEntityData entity) async {
    try {
      await database.into(database.articlesEntity).insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }

  @override
  Future<void> deleteNoteById(String id) async {
    try {
      (database.delete(database.articlesEntity)..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (error) {
      xLog.e("[error - _deleteNoteById] $error");
    }
  }
}
