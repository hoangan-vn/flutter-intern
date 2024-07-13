import 'package:drift/drift.dart';

//Using to display all single values in daily chart
//Collect a single value per point
class BabyInforFactEntity extends Table {
  TextColumn get id => text()();
  IntColumn get week => integer()();
  RealColumn get weight => real().nullable()();
  RealColumn get height => real().nullable()();
  BlobColumn get image => blob().nullable()();
  TextColumn get yourBaby => text()();
  TextColumn get yourBody => text()();
  TextColumn get thingsToRemember => text()();
  TextColumn get fact => text().nullable()();

  @override
  Set<Column> get primaryKey => {id, week};
}
