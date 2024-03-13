import 'dart:ffi';
import 'dart:io';

import 'package:calendar_scheduler/data/datasource/entity/schedule_entities.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'drift_database.g.dart';

const _DB_FILE_NAME = "db.sqlite";

/**
 * LocalDataBase 클래스
 * flutter pub run build_runner build 으로 database generate 가능
 */
@DriftDatabase(
  tables: [
    ScheduleEntities,
  ],
)
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
        _DB_FILE_NAME,
      ),
    );
    return NativeDatabase(dbFile);
  });
}
