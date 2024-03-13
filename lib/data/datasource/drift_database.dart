import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'drift_database.g.dart';

@DriftDatabase()
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(
      path.join(
        dbFolder.path,
        "db.sqlite",
      ),
    );
    return NativeDatabase(dbFile);
  });
}