import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:safebump/src/local/entities/articles_entity.dart';
import 'package:safebump/src/local/entities/baby_infor_entity.dart';
import 'package:safebump/src/local/entities/baby_infor_fact_entity.dart';
import 'package:safebump/src/local/entities/notes_entity.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
part 'database_app.g.dart';

//Run this comment to generate new schema:
//flutter pub run build_runner build --delete-conflicting-outputs
@DriftDatabase(tables: [
  BabyInforEntity,
  NotesEntity,
  ArticlesEntity,
  BabyInforFactEntity,
])
class DatabaseApp extends _$DatabaseApp {
  DatabaseApp() : super(_openConnection());

  @override
  int get schemaVersion => 2;
  Future<void> deleteAll() async {
    await GetIt.I.get<BabyInforLocalRepo>().deleteAll();
    await GetIt.I.get<NotesLocalRepo>().deleteAll();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // The database saves into the support directory, doesn't expose to user
    // Review carefully before modifying it
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'safebump.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
