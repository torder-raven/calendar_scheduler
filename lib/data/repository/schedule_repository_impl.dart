import 'package:calendar_scheduler/data/datasource/drift_database.dart';
import 'package:calendar_scheduler/domain/entity/schedule.dart';

import '../../domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl() {}

  @override
  Future<void> deleteSchedule({required int scheduleId}) {
    // TODO: implement deleteSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<Schedule>> getAllSchedule({required DateTime date}) {
    // TODO: implement getAllSchedule
    throw UnimplementedError();
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
