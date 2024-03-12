import 'package:calendar_scheduler/domain/entity/schedule.dart';

abstract class ScheduleRepository {
  Future<void> deleteSchedule({required Schedule schedule});
  Future<void> temporaryDeleteSchedule({required Schedule schedule});
  Future<void> updateSchedule({required Schedule schedule});
  Future<void> registerSchedule({required Schedule schedule});
  Future<List<Schedule>> getAllSchedule();
  Future<List<Schedule>> getScheduleByColor({required String colorCode});
  Future<List<Schedule>> getTemporaryDeleteSchedule();
}
