import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';

abstract class BabyInforFactLocalRepo {
  final DatabaseApp database;

  BabyInforFactLocalRepo(this.database);

  MultiSelectable<BabyInforFactEntityData> getDetail({required String id});

  MultiSelectable<BabyInforFactEntityData> getDetailFollowWeek(
      {required int week});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<BabyInforFactEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  Future<BabyInforFactEntityData?> upsert(BabyInforFactEntityData entity);
}
