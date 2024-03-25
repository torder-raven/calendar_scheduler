import 'dart:io';

import 'package:calendar_scheduler/data/datasource/entity/schedule_dao.dart';
import 'package:calendar_scheduler/data/datasource/entity/temporary_deleted_schedule_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_database.g.dart';

const _DB_FILE_NAME = "db.sqlite";

@DriftDatabase(
  tables: [ScheduleDao, TemporaryDeletedScheduleDao],
)
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  Stream<List<ScheduleDaoData>> getAllSchedulesAsStream() =>
      select(scheduleDao).watch();

  Stream<List<ScheduleDaoData>> getAllSchedulesAsStreamByDateTime({
    required DateTime datetime,
  }) =>
      (select(scheduleDao)
            ..where(
              (tbl) => tbl.date.year.equals(
                datetime.year,
              ),
            )
            ..where(
              (tbl) => tbl.date.month.equals(
                datetime.month,
              ),
            )
            ..where(
              (tbl) => tbl.date.day.equals(
                datetime.day,
              ),
            ))
          .watch();

  Future<List<ScheduleDaoData>> getAllSchedules() => select(scheduleDao).get();

  Future<List<ScheduleDaoData>> searchSchedule({required String keyword}) =>
      ((select(scheduleDao))..where((tbl) => tbl.content.contains(keyword)))
          .get();

  Stream<List<ScheduleDaoData>> searchScheduleBetween({
    required DateTime startDay,
    required DateTime endDay,
  }) =>
      ((select(scheduleDao))
        ..where((tbl) => tbl.date.isBetweenValues(startDay, endDay)))
          .watch();

  Future<List<ScheduleDaoData>> getAllSchedulesByColorCode({
    required int colorCode,
  }) =>
      (select(scheduleDao)
            ..where(
              (tbl) => tbl.colorCode.equals(colorCode),
            ))
          .get();

  Future<ScheduleDaoData> getScheduleById({
    required int scheduleId,
  }) =>
      (select(scheduleDao)
            ..where(
              (tbl) => tbl.id.equals(scheduleId),
            ))
          .getSingle();

  Future<int> registerSchedule(ScheduleDaoCompanion data) =>
      into(scheduleDao).insert(data);

  Future<int> deleteSchedules() => delete(scheduleDao).go();

  Future<int> deleteScheduleById({
    required int scheduleId,
  }) =>
      (delete(scheduleDao)
            ..where(
              (tbl) => tbl.id.equals(scheduleId),
            ))
          .go();

  Future<int> updateScheduleById({
    required int id,
    required ScheduleDaoCompanion data,
  }) =>
      (update(scheduleDao)
            ..where(
              (tbl) => tbl.id.equals(id),
            ))
          .write(data);

  Stream<List<TemporaryDeletedScheduleDaoData>>
      getAllTemporaryDeletedSchedules() =>
          select(temporaryDeletedScheduleDao).watch();

  Future<int> registerTemporaryDeletedSchedule(
          TemporaryDeletedScheduleDaoCompanion data) =>
      into(temporaryDeletedScheduleDao).insert(data);

  Future<int> deleteTemporaryDeletedScheduleById({
    required int temporaryDeletedScheduleId,
  }) =>
      (delete(temporaryDeletedScheduleDao)
            ..where(
              (tbl) => tbl.id.equals(temporaryDeletedScheduleId),
            ))
          .go();

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

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(dbFile);
  });
}
