import 'package:drift/drift.dart';

class NotesEntity extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  DateTimeColumn get time => dateTime().nullable()();
  TextColumn get date => text()();
  DateTimeColumn get remindTime => dateTime().nullable()();
  TextColumn get medicine => text().nullable()();
  TextColumn get hospital => text().nullable()();
  TextColumn get detail => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
