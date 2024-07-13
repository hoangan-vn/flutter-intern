import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';

abstract class BabyInforLocalRepo {
  final DatabaseApp database;

  BabyInforLocalRepo(this.database);

  Future<BabyInforEntityData?> upsert(BabyInforEntityData entity);

  /// Upsert a value summarized by day into: Month table
  Future<BabyInforEntityData?> insertDetail(BabyInforEntityData entity);

  MultiSelectable<BabyInforEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<BabyInforEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();
}
