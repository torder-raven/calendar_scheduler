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
  Future<void> deleteSchedule({required int scheduleId}) {
    return _db.deleteScheduleById(
      scheduleId: scheduleId,
    );
  }

  @override
  Future<List<Schedule>> getAllSchedule({required DateTime date}) {
    return _db
        .getAllScheduleByDateTime(
          datetime: date,
        )
        .then((scheduleDaoDataList) => scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  @override
  Future<List<Schedule>> getScheduleByColor({required int colorCode}) {
    return _db
        .getAllScheduleByColorCode(
          colorCode: colorCode,
        )
        .then((scheduleDaoDataList) => scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  @override
  Future<List<Schedule>> getTemporaryDeleteSchedule() {
    return _db.getAllScheduleByDeleted().then((scheduleDaoDataList) =>
        scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  @override
  Future<void> registerSchedule({required Schedule schedule}) {
    _db.getAllSchedule().then((value) => print(value.length));
    return _db.registerSchedule(
      schedule.toRegisterScheduleDao(),
    );
  }

  @override
  Future<void> temporaryDeleteSchedule({required int scheduleId}) {
    return _db
        .getScheduleById(
          scheduleId: scheduleId,
        )
        .then((scheduleDaoData) => _db.updateScheduleById(
              id: scheduleDaoData.id,
              data:
                  scheduleDaoData.copyWith(isDeleted: true).toCompanion(false),
            ));
  }

  @override
  Future<void> updateSchedule({required Schedule schedule}) {
    return _db.updateScheduleById(
      id: schedule.id,
      data: schedule.toRegisterScheduleDao(),
    );
  }
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
}

extension _ScheduleMapper on Schedule {
  /**
   * Register의 경우 id 값이 포함될 경우 충돌이 발생!
   * DB에 생성하는 경우에 사용!
   */
  ScheduleDaoCompanion toRegisterScheduleDao() => ScheduleDaoCompanion(
        content: Value(content),
        date: Value(date),
        startTime: Value(startTime),
        endTime: Value(endTime),
        colorCode: Value(colorCode),
      );
}
