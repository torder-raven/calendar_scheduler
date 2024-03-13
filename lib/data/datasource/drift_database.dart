import 'dart:ffi';
import 'dart:io';

import 'package:calendar_scheduler/data/datasource/entity/schedule_dao.dart';
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
    ScheduleDao,
  ],
)
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  // Stream 방식으로 모든 Schedule 조회
  Stream<List<ScheduleDaoData>> getAllScheduleAsStream() =>
      select(scheduleDao).watch();

  // Future 방식으로 모든 Schedule 조회
  Future<List<ScheduleDaoData>> getAllSchedule() => select(scheduleDao).get();

  // Future 방식으로 특정 조건(Date)에 맞는 Schedule 조회
  Future<List<ScheduleDaoData>> getAllScheduleByDateTime({
    required DateTime datetime,
  }) =>
      (select(scheduleDao)..where((tbl) => tbl.date.equals(datetime))).get();

  // Future 방식으로 특정 조건(colorCode)에 맞는 Schedule 조회
  Future<List<ScheduleDaoData>> getAllScheduleByColorCode({
    required int colorCode,
  }) =>
      (select(scheduleDao)..where((tbl) => tbl.colorCode.equals(colorCode)))
          .get();

  // Schedule 생성
  Future<int> registerSchedule(ScheduleDaoCompanion data) =>
      into(scheduleDao).insert(data);

  // Schedule 모두 삭제
  Future<int> deleteSchedule() => delete(scheduleDao).go();

  // 특정 조건(scheduleId)을 가진 Schedule 삭제
  Future<int> deleteScheduleById({required int scheduleId}) =>
      (delete(scheduleDao)..where((tbl) => tbl.id.equals(scheduleId))).go();

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
