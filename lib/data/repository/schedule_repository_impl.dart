import 'package:calendar_scheduler/data/datasource/drift_database.dart';
import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:drift/drift.dart';

import '../../domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final LocalDataBase _db;

  ScheduleRepositoryImpl({
    required LocalDataBase db,
  }) : _db = db;

  @override
  Stream<List<Schedule>> getAllSchedule({required DateTime date}) {
    return _db
        .getAllSchedulesAsStreamByDateTime(
          datetime: date,
        )
        .map(
          (scheduleDaoDataList) => scheduleDaoDataList
              .map(
                (scheduleDaoData) => scheduleDaoData.toSchedule(),
              )
              .toList(),
        );
  }

  @override
  Future<List<Schedule>> getScheduleByColor({required int colorCode}) {
    return _db
        .getAllSchedulesByColorCode(
          colorCode: colorCode,
        )
        .then((scheduleDaoDataList) => scheduleDaoDataList
            .map(
              (scheduleDaoData) => scheduleDaoData.toSchedule(),
            )
            .toList());
  }

  @override
  Future<void> registerSchedule({required Schedule schedule}) {
    return _db.registerSchedule(
      schedule.toRegisterScheduleDao(),
    );
  }

  @override
  Future<void> updateSchedule({required Schedule schedule}) {
    return _db.updateScheduleById(
      id: schedule.id,
      data: schedule.toRegisterScheduleDao(),
    );
  }

  @override
  Future<List<Schedule>> getTemporaryDeleteSchedule() {
    return _db.getAllTemporaryDeletedSchedules().then(
          (scheduleDaoDataList) => scheduleDaoDataList
              .map(
                (temporaryDeletedSchedule) =>
                    temporaryDeletedSchedule.toSchedule(),
              )
              .toList(),
        );
  }

  @override
  Future<void> temporaryDeleteSchedule({required int scheduleId}) {
    return _db
        .getScheduleById(
          scheduleId: scheduleId,
        )
        .then(
          (scheduleDaoData) => _db.registerTemporaryDeletedSchedule(
            scheduleDaoData.toTemporaryDeletedScheduleDao(),
          ),
        )
        .then(
          (temporaryDeletedScheduleId) => _db.deleteScheduleById(
            scheduleId: temporaryDeletedScheduleId,
          ),
        );
  }

  @override
  Future<void> deleteSchedule({required int scheduleId}) {
    return _db.deleteTemporaryDeletedScheduleById(
      temporaryDeletedScheduleId: scheduleId,
    );
  }
}

extension _TemporaryDeletedScheduleDaoDataMapper
    on TemporaryDeletedScheduleDaoData {
  Schedule toSchedule() => Schedule(
        date: date,
        startTime: startTime,
        endTime: endTime,
        colorCode: colorCode,
        content: content,
        id: id,
      );
}

extension _ScheduleDaoDataMapper on ScheduleDaoData {
  Schedule toSchedule() => Schedule(
        date: date,
        startTime: startTime,
        endTime: endTime,
        colorCode: colorCode,
        content: content,
        id: id,
      );

  TemporaryDeletedScheduleDaoCompanion toTemporaryDeletedScheduleDao() =>
      TemporaryDeletedScheduleDaoCompanion(
        content: Value(content),
        date: Value(date),
        startTime: Value(startTime),
        endTime: Value(endTime),
        colorCode: Value(colorCode),
        id: Value(id),
      );
}

extension _ScheduleMapper on Schedule {
  ScheduleDaoCompanion toRegisterScheduleDao() => ScheduleDaoCompanion(
        content: Value(content),
        date: Value(date),
        startTime: Value(startTime),
        endTime: Value(endTime),
        colorCode: Value(colorCode),
      );
}
