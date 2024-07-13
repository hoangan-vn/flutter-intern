import 'package:drift/drift.dart';

//Using to display all single values in daily chart
//Collect a single value per point
class BabyInforEntity extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get gender => text().nullable()();
  RealColumn get weight => real().nullable()();
  RealColumn get height => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
