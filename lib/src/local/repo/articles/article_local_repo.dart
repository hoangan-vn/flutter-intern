import 'package:drift/drift.dart';
import 'package:safebump/src/local/database_app.dart';

abstract class ArticlesLocalRepo {
  final DatabaseApp database;

  ArticlesLocalRepo(this.database);

  Future<ArticlesEntityData?> upsert(ArticlesEntityData entity);

  /// Upsert a value summarized by day into: Month table
  Future<ArticlesEntityData?> insertDetail(ArticlesEntityData entity);

  MultiSelectable<ArticlesEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<ArticlesEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteNoteById(String id);
}
