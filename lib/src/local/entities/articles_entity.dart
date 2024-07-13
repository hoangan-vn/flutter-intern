import 'package:drift/drift.dart';

//Using to display all single values in daily chart
//Collect a single value per point
class ArticlesEntity extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get summarize => text()();
  TextColumn get content => text()();
  TextColumn get tag => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get link => text().nullable()();
  TextColumn get image => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
