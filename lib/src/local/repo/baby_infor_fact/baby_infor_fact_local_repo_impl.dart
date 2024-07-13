import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/baby_infor_fact/baby_infor_fact_local_repo.dart';
import 'package:safebump/src/utils/utils.dart';

class BabyInforFactLocalRepoImpl extends BabyInforFactLocalRepo {
  BabyInforFactLocalRepoImpl(super.database);

  @override
  MultiSelectable<BabyInforFactEntityData> getDetail({required String id}) {
    return (database.select(database.babyInforFactEntity)
      ..where((baby) => baby.id.equals(id)));
  }

  @override
  MultiSelectable<BabyInforFactEntityData> getDetailFollowWeek(
      {required int week}) {
    return (database.select(database.babyInforFactEntity)
      ..where((baby) => baby.week.equals(week)));
  }

  @override
  MultiSelectable<BabyInforFactEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.babyInforFactEntity);
    }

    return (database.select(database.babyInforFactEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<void> deleteAll() async {
    try {
      await database.delete(database.babyInforFactEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  @override
  Future<BabyInforFactEntityData?> upsert(
      BabyInforFactEntityData entity) async {
    try {
      await upsertDetail(entity);
      return entity;
    } catch (error) {
      return null;
    }
  }

  Future<BabyInforFactEntityData?> upsertDetail(
      BabyInforFactEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.babyInforFactEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.babyInforFactEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<BabyInforFactEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.babyInforFactEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }
}
