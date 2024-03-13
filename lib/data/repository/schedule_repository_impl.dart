import 'package:calendar_scheduler/data/datasource/drift_database.dart';
import 'package:calendar_scheduler/domain/entity/schedule.dart';

import '../../domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  // 테스트 코드 -> 나중에 Di로 교체해야할 듯?
  final database = LocalDataBase();

  ScheduleRepositoryImpl() {
    testFunction();
  }

  /**
   * 개발을 위한 테스트 코드 (삭제 예정)
   */
  testFunction() async {
    database.getAllScheduleAsStream().listen((scheduleDaoDataList) {
      print("stream : $scheduleDaoDataList");
    });

    print("getAllSchedule : ${await database.getAllSchedule()}");
    print(
        "getAllScheduleByDateTime DateTime(${DateTime.now()}) : ${await database.getAllScheduleByDateTime(datetime: DateTime.now())}");
    print("getAllSchedule : ${await getAllSchedule(date: DateTime.now())}");
  }

  @override
  Future<void> deleteSchedule({required int scheduleId}) {
    // TODO: implement deleteSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<Schedule>> getAllSchedule({required DateTime date}) {
    return database.getAllScheduleByDateTime(datetime: date).then(
        (scheduleDaoDataList) => scheduleDaoDataList
            .map((scheduleDaoData) => scheduleDaoData.toSchedule())
            .toList());
  }

  @override
  Future<List<Schedule>> getScheduleByColor({required int colorCode}) {
    // TODO: implement getScheduleByColor
    throw UnimplementedError();
  }

  @override
  Future<List<Schedule>> getTemporaryDeleteSchedule() {
    // TODO: implement getTemporaryDeleteSchedule
    throw UnimplementedError();
  }

  @override
  Future<void> registerSchedule({required Schedule schedule}) {
    // TODO: implement registerSchedule
    throw UnimplementedError();
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
        colorCode: colorHexCode,
        content: content,
        id: id,
      );
}
