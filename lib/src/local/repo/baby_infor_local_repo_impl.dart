import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo.dart';
import 'package:safebump/src/utils/utils.dart';

class BabyInforLocalRepoImpl extends BabyInforLocalRepo {
  BabyInforLocalRepoImpl(super.database);

  @override
  MultiSelectable<BabyInforEntityData> getDetail({required String id}) {
    return (database.select(database.babyInforEntity)
      ..where((baby) => baby.id.equals(id)));
  }

  @override
  MultiSelectable<BabyInforEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.babyInforEntity);
    }

    return (database.select(database.babyInforEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<BabyInforEntityData?> upsert(BabyInforEntityData entity) async {
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
      await database.delete(database.babyInforEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<BabyInforEntityData?> upsertDetail(BabyInforEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.babyInforEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.babyInforEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<BabyInforEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.babyInforEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<BabyInforEntityData?> insertDetail(BabyInforEntityData entity) async {
    try {
      await database
          .into(database.babyInforEntity)
          .insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }
}
