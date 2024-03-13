import 'package:calendar_scheduler/data/datasource/drift_database.dart';
import 'package:calendar_scheduler/domain/entity/schedule.dart';
import 'package:drift/drift.dart';

import '../../domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  // 테스트 코드 -> 나중에 Di로 교체해야할 듯?
  final _db = LocalDataBase();

  ScheduleRepositoryImpl() {}

  @override
  Future<void> deleteSchedule({required int scheduleId}) {
    return _db.deleteScheduleById(scheduleId: scheduleId);
  }

  @override
  Future<List<Schedule>> getAllSchedule({required DateTime date}) {
    return _db.getAllScheduleByDateTime(datetime: date).then(
        (scheduleDaoDataList) => scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  @override
  Future<List<Schedule>> getScheduleByColor({required int colorCode}) {
    return _db.getAllScheduleByColorCode(colorCode: colorCode).then(
        (scheduleDaoDataList) => scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  @override
  Future<List<Schedule>> getTemporaryDeleteSchedule() {
    // TODO: implement getTemporaryDeleteSchedule
    throw UnimplementedError();
  }

  @override
  Future<void> registerSchedule({required Schedule schedule}) {
    return _db.registerSchedule(schedule.toRegisterScheduleDao());
  }

  @override
  Future<void> temporaryDeleteSchedule({required int scheduleId}) {
    // TODO: implement temporaryDeleteSchedule
    throw UnimplementedError();
  }

  @override
  Future<void> updateSchedule({required Schedule schedule}) {
    // TODO: implement updateSchedule
    throw UnimplementedError();
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
