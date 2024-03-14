import 'package:calendar_scheduler/data/datasource/drift_database.dart';
import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:drift/drift.dart';

import '../../domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final LocalDataBase _db;

  ScheduleRepositoryImpl({
    required LocalDataBase db,
  }) : _db = db;

  /// 일정 삭제
  @override
  Future<void> deleteSchedule({required int scheduleId}) {
    return _db.deleteScheduleById(
      scheduleId: scheduleId,
    );
  }

  /// 전체 일정 가져오기
  @override
  Stream<List<Schedule>> getAllSchedule({required DateTime date}) {
    return _db
        .getAllScheduleByDateTime(
          datetime: date,
        )
        .map((scheduleDaoDataList) => scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  /// 특정 Color에 해당하는 일정 가져오기
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

  /// 휴지통(삭제 처리된)에 있는 일정 가져오기
  @override
  Future<List<Schedule>> getTemporaryDeleteSchedule() {
    return _db.getAllScheduleByDeleted().then((scheduleDaoDataList) =>
        scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  /// 일정 생성
  @override
  Future<void> registerSchedule({required Schedule schedule}) {
    return _db.registerSchedule(
      schedule.toRegisterScheduleDao(),
    );
  }

  /// 특정 일정을 삭제 처리함
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

  /// 알정 업데이트
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
